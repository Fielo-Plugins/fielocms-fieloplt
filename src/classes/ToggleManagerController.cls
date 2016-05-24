global with sharing class ToggleManagerController implements FieloCMS.ViewSubComponentInterface {

    global ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
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
    global static FieloCMS.RemoteActionResult toggleManager(Id memberId, String action){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();

        try {
            FieloAlpha.MemberService.toggleManagers(new List<Id>{memberId}, action);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.refresh.add(new FieloCMS.RemoteActionResult.RemoteActionRefresh('action',action));
            result.redirectURL = '#';
        } catch(DMLException e) {
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
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