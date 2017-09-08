global with sharing class FieloCMSPLT_CheckoutCtrl implements FieloCMS.ViewSubComponentInterface {

    global ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
        Component.FieloCMSPLT_Checkout checkout = new Component.FieloCMSPLT_Checkout();
        if(record != null){
            checkout.record = record;
        }else{
            checkout.expressions.record = '{!record}';
        }        
        checkout.field = field;        
        return checkout;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult checkout(Id rewardId, Integer quantity, String detailUrl){                        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{                            
            List<FieloPLT__Redemption__c> redemptions = FieloPLT.RedemptionService.createRedemptions(new Map<Id,Integer>{rewardId => quantity}, FieloCMSPLT_MemberService.getCurrentMemberId());
            if(redemptions[0].FieloPLT__Status__c == 'Closed'){                
                result.redirectURL = detailUrl + redemptions[0].Id;
            }else{
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.FieloCMSPLT_InfoRedemptionApproval)));
                result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('quantity', '1'));
            }            
        }catch(Exception e){
            Database.rollBack(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}