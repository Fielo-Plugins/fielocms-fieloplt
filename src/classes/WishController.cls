global class WishController implements FieloCMS.ViewSubComponentInterface {
    
    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
        Component.Wish wishComponent = new Component.Wish();
        if(record != null){
            wishComponent.record = record;
        }else{
            wishComponent.expressions.record = '{!record}';
        }
        wishComponent.field = field;        
        return wishComponent;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult wish(Id rewardId, String action){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try {
            doWish(MemberService.getCurrentMemberId(),rewardId, Boolean.valueOf(action));
            result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh( 'wish', action) );
            result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh( 'action', String.valueOf(!Boolean.valueOf(action))));
        } catch(FieloCustomException e){
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

    private static void doWish(Id memberId, Id rewardId, Boolean wish){
        if(wish){
            insert new FieloAlpha__RewardWish__c(FieloAlpha__Member__c = memberId, FieloAlpha__Reward__c = rewardId);
        }else{
            delete [SELECT Id FROM FieloAlpha__RewardWish__c WHERE FieloAlpha__Member__c =: memberId AND FieloAlpha__Reward__c =: rewardId];
        }        
    }
}