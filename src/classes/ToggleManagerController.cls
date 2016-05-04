global with sharing class ToggleManagerController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(Field field, SObject record){
        Component.ToggleManager toggleManager = new Component.ToggleManager();        
        toggleManager.field = field;
        if(record != null){
            toggleManager.record = record;
        }else{
            toggleManager.expressions.record = '{!record}';
        }
        return toggleManager;
    }

    @RemoteAction
    global static RemoteActionResult toggleManager(Id memberId, String action){
        RemoteActionResult result = new RemoteActionResult();

        try {
            MemberService.toggleManager(new List<Id>{memberId}, action);
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.refresh.add(new RemoteActionRefresh('action',action));
            result.redirectURL = '#';
        } catch(DMLException e) {
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
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