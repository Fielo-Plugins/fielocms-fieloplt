//NO DOCUMENT
global with sharing class BlockUnblockMemberController {

    @RemoteAction
    global static RemoteActionResult blockUnblockMember(Id componentId, Id memberId){
    	RemoteActionResult result = new RemoteActionResult();

    	try {
    		MemberService.blockUnblock(MemberUtil.getMemberId(), new List<Id>{memberId});
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.redirectURL = '#';
    	} catch(DMLException e) {
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e, componentId));
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