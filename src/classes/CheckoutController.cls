global with sharing class CheckoutController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
        Component.Checkout checkout = new Component.Checkout();
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
        try{            
            List<FieloPLT__Redemption__c> redemptions = FieloPLT.createRedemptions(new Map<Id,Integer>{rewardId => quantity}, MemberService.getCurrentMemberId());
            if(redemptions[0].FieloPLT__Status__c == 'Close'){
                result.redirectURL = detailUrl + redemption.Id;
            }else if(redemptions[0].FieloPLT__Status__c == 'Pending'){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));                
                result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('quantity', '1'));
            }            
        }catch(FieloException e){
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloPLT.FieloException e){
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