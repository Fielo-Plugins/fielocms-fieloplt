global with sharing class AddToCartController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(Field field, SObject record){   
        Component.AddToCart addToCart = new Component.AddToCart();
        if(record != null){
            addToCart.record = record;
        }else{
            addToCart.expressions.record = '{!record}';
        }
        addToCart.field = field;        
        addToCart.relatedListName = 'RedemptionItems__r';
        return addToCart;
    }

    @RemoteAction
    global static RemoteActionResult addToCart(Id rewardId, Integer quantity, Integer quantInCart, String config){
        RemoteActionResult result = new RemoteActionResult();
        try{
            Redemption__c redemption = RewardService.addToCart(MemberService.getCurrentMemberId(), rewardId, quantity, config.ShoppingCart__c);
            if(redemption != null){
                if(redemption.Status__c == 'Open' || redemption.Status__c == null){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SuccessRewardAddToChart)));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantInCart', String.valueOf(quantity)));
                }else if(redemption.Status__c == 'Pending'){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantInCart', '0'));
                    result.refresh.add( new RemoteActionResult.RemoteActionRefresh('quantity', '1'));
                }else if(redemption.Status__c == 'Close'){
                    result.redirectURL = '/Page?pageId=' + config.DetailPage__c + '&' + config.DetailParameter__c + '=' + redemption.Id;
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