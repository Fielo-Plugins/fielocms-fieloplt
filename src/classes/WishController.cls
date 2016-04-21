//NO DOCUMENT
global class WishController {
    
    @RemoteAction
    global static RemoteActionResult wish(Id rewardId, String WishController){                
        RemoteActionResult result = new RemoteActionResult();
        try {
            Member__c member = MemberUtil.getLoggedMember(null);
            if ( doWish(member.Id,rewardId) ) {
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