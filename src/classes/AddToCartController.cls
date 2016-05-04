global with sharing class AddToCartController implements CMSViewSubComponentInterface {

    public ApexPages.Component getSubComponent(CMSField field, SObject record){   
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
    global static CMSRemoteActionResult addToCart(Id rewardId, Integer quantity, Integer quantInCart, Boolean closeOrder, String detailUrl){
        CMSRemoteActionResult result = new CMSRemoteActionResult();
        try{
            FieloAlpha__Redemption__c redemption = FieloAlpha.RewardService.addToCart(MemberService.getCurrentMemberId(), rewardId, quantity, closeOrder);
            if(redemption != null){
                if(redemption.Status__c == 'Open' || redemption.Status__c == null){
                    result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SuccessRewardAddToChart)));
                    result.refresh.add( new CMSRemoteActionResult.RemoteActionRefresh('quantInCart', String.valueOf(quantity)));
                }else if(redemption.Status__c == 'Pending'){
                    result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));
                    result.refresh.add( new CMSRemoteActionResult.RemoteActionRefresh('quantInCart', '0'));
                    result.refresh.add( new CMSRemoteActionResult.RemoteActionRefresh('quantity', '1'));
                }else if(redemption.Status__c == 'Close'){
                    result.redirectURL = detailUrl + redemption.Id;
                }
            }            
        }catch(FieloCustomException e){
            result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}