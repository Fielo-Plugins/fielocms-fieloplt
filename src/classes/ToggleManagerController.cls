//NO DOCUMENT
global with sharing class ToggleManagerController {

    @RemoteAction
    global static RemoteActionResult toggleManager(Id componentId, Id memberId, String action){
        RemoteActionResult result = new RemoteActionResult();

        try {
            MemberService.toggleManager(MemberUtil.getMemberId(), new List<Id>{memberId}, action);
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