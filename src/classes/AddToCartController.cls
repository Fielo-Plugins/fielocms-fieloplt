//NO DOCUMENT
global with sharing class AddToCartController {
   
    @RemoteAction
    global static RemoteActionResult addToCart(Id componentId, Id rewardId, Integer quantity, Integer quantInCart){        
        Component__c component = [SELECT Id, DetailParameter__c, DetailPage__c FROM Component__c WHERE Id =: componentId];
        RemoteActionResult result = new RemoteActionResult();
        try{
            Site__c program = SiteUtil.getSiteProgram(new List<String>{'ShoppingCart__c'});
            Redemption__c redemption = RewardService.addToCart(rewardId, quantity, program.ShoppingCart__c);
            if(redemption != null){
                if(redemption.Status__c == 'Open' || redemption.Status__c == null){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SuccessRewardAddToChart)));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantInCart', String.valueOf(quantity)));
                }else if(redemption.Status__c == 'Pending'){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantInCart', '0'));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantity', '1'));
                }else if(redemption.Status__c == 'Close'){
                    result.redirectURL = '/Page?pageId=' + component.DetailPage__c + '&' + component.DetailParameter__c + '=' + redemption.Id;
                }
            }            
        }catch(FieloCustomException e){
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}