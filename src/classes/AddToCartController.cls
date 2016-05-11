global with sharing class AddToCartController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){   
        Component.AddToCart addToCart = new Component.AddToCart();
        if(record != null){
            addToCart.record = record;
        }else{
            addToCart.expressions.record = '{!record}';
        }        
        addToCart.field = field;        
        return addToCart;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult addToCart(Id rewardId, Integer quantity, Boolean closeOrder, String detailUrl){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try{
            FieloAlpha__Redemption__c redemption = FieloAlpha.RewardService.addToCart(MemberService.getCurrentMemberId(), rewardId, quantity, closeOrder);
            if(redemption != null){
                if(redemption.FieloAlpha__Status__c == 'Open' || redemption.FieloAlpha__Status__c == null){
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SuccessRewardAddToChart)));
                    result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('quantInCart', String.valueOf(quantity)));
                }else if(redemption.FieloAlpha__Status__c == 'Pending'){
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));
                    result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('quantInCart', '0'));
                    result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('quantity', '1'));
                }else if(redemption.FieloAlpha__Status__c == 'Close'){
                    result.redirectURL = detailUrl + redemption.Id;
                }
            }
        }catch(FieloCustomException e){
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