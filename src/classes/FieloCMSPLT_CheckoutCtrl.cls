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
            FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__OrganizationFieloCMSPLT_Account__c','FieloPLT__Type__c','FieloPLT__IsManager__c'});
            Id memberId = (loggedMember.FieloPLT__Type__c == 'Organization Contributor' && loggedMember.FieloPLT__OrganizationAccount__c != null && loggedMember.FieloPLT__IsManager__c) ? loggedMember.FieloPLT__OrganizationAccount__c : loggedMember.Id;
                          
            List<FieloPLT__Redemption__c> redemptions = FieloPLT.RedemptionService.createRedemptions(new Map<Id,Integer>{rewardId => quantity}, memberId);
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