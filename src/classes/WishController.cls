global class WishController implements FieloCMS.ViewSubComponentInterface {
    
    public ApexPages.Component getSubComponent(Field field, SObject record){
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
    global static RemoteActionResult wish(Id rewardId, String action){
        RemoteActionResult result = new RemoteActionResult();
        try {
            doWish(MemberService.getCurrentMemberId(),rewardId, action);
            result.refresh.add( new RemoteActionResult.RemoteActionRefresh( 'wish', action) );
            result.refresh.add( new RemoteActionResult.RemoteActionRefresh( 'action', String.valueOf(!Boolean.valueOf(action)) );
        } catch(FieloCustomException e){
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

    private static void doWish(Id memberId, Id rewardId, Boolean wish){
        if(wish){
            insert new RewardWish__c(Member__c = memberId, Reward__c = rewardId);
        }else{
            delete [SELECT Id FROM RewardWish__c WHERE Member__c =: memberId AND Reward__c =: rewardId];
        }        
    }
}