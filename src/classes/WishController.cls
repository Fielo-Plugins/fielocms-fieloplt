global class WishController implements FieloCMS.SubComponentInterface {
    
    public ApexPages.Component getSubComponent(Component__c config, Field field, SObject record){
        Component.Wish wishComponent = new Component.Wish();
        if(record != null){
            wishComponent.record = record;
        }else{
            wishComponent.expressions.record = '{!record}';
        }
        wishComponent.field = field;
        wishComponent.config = config;
        wishComponent.relatedListName = 'Members_Reward__r';
        return wishComponent;
    }

    @RemoteAction
    global static RemoteActionResult wish(Id rewardId, String WishController){
        RemoteActionResult result = new RemoteActionResult();
        try {
            Member__c member = MemberUtil.getLoggedMember(null);
            if ( doWish(MemberService.getCurrentMemberId(),rewardId) ) {
                result.refresh.add( new RemoteActionResult.RemoteActionRefresh( 'wish', 'true') );        
            } else {
                result.refresh.add( new RemoteActionResult.RemoteActionRefresh( 'wish', 'false') );
            }
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

    private static Boolean doWish(Id memberId, Id rewardId){
        List<RewardWish__c> wishRewards = [SELECT Id FROM RewardWish__c WHERE Member__c =: memberId AND Reward__c =: rewardId];
        if(wishRewards.isEmpty()){
            insert new RewardWish__c(Member__c = memberId, Reward__c = rewardId);
            return true;
        }else{
            delete wishRewards;
            return false;
        }

        return null;
    }
}