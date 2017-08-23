global with sharing class FieloCMSPLT_ToggleManagerCtrl implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
        Component.FieloCMSPLT_ToggleManager toggleManager = new Component.FieloCMSPLT_ToggleManager();        
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
            FieloPLT.MemberService.toggleManagers(new List<Id>{memberId}, action);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.FieloCMSPLT_SuccessfulRemoteActionRefresh));
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