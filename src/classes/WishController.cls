//NO DOCUMENT
global class WishController {
    
    @RemoteAction
    global static RemoteActionResult wish(Id rewardId, String WishController){                
        RemoteActionResult result = new RemoteActionResult();
        try {
            Member__c member = MemberUtil.getLoggedMember(null);
            if ( MemberUtil.doWish(member.Id,rewardId) ) {
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
}