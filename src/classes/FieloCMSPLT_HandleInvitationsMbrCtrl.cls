global with sharing class FieloCMSPLT_HandleInvitationsMbrCtrl implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
        Component.FieloCMSPLT_HandleInvitationsMembers handleInvitationsMembers = new Component.FieloCMSPLT_HandleInvitationsMembers();
        handleInvitationsMembers.field = field;
        if(record != null){
            handleInvitationsMembers.record = record;
        }else{
            handleInvitationsMembers.expressions.record = '{!record}';
        }
        return handleInvitationsMembers;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult resendInvitation(Id memberId){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();

        try {
            resendInvitations(new Set<Id>{memberId});
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.FieloCMSPLT_SuccessfulRemoteActionRefresh));
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

    @RemoteAction
    global static FieloCMS.RemoteActionResult cancelInvitation(Id memberId){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();

        //first I check if the User has access to delete the Member
        UserRecordAccess ura = [SELECT RecordId, HasDeleteAccess FROM UserRecordAccess WHERE UserId =: UserInfo.getUserId() AND RecordId =: memberId];

        if(ura.HasDeleteAccess){
            try {
                cancelInvitations(new Set<Id>{memberId});
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
        }else{
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, Label.FieloCMSPLT_InsufficientAccessToCancelInvitation));
        }

        return result;
    }

    private static void resendInvitations(Set<Id> memberIds){
        Set<Id> programIds = new Set<Id>();
        List<FieloPLT__Member__c> members = new FieloCMSPLT_MembersSelector().selectById(memberIds);
        for(FieloPLT__Member__c member : members){
            programIds.add(member.FieloPLT__Program__c);
        }
        /*Map<Id, FieloPLT__Program__c> programsMap = new Map<Id, FieloPLT__Program__c>([SELECT FieloCMSPLT_SiteURL__c, RegisterPage__c FROM FieloPLT__Program__c WHERE Id in : programIds]);
        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloPLT__Email__c.SObjectType});
        for(FieloPLT__Member__c member : members){
            String recipientName = member.FieloPLT__FirstName__c + ' ' + member.FieloPLT__LastName__c;
            String url = programsMap.get(member.FieloPLT__Program__c).FieloCMSPLT_SiteURL__c + 'FieloCMS__Page?memberId=' + member.Id + '&pageId=' + programsMap.get(member.FieloPLT__Program__c).FieloPLT__RegisterPage__c;
            uow.registerNew( new FieloPLT__Email__c(FieloPLT__Email__c = member.FieloPLT__Email__c, FieloPLT__Type__c = 'Register', FieloPLT__Member__c = member.Id, FieloPLT__Program__c = member.FieloPLT__Program__c, FieloPLT__Link__c = url, FieloPLT__RecipientName__c = recipientName) );
        }*/

        //uow.commitWork();
    }

    public static void cancelInvitations(Set<Id> memberIds){
        Boolean doCommit = false;
        FieloCMSPLT_SObjectUnitOfWork uow = new FieloCMSPLT_SObjectUnitOfWork(new List<Schema.SobjectType>{FieloPLT__Member__c.SObjectType});
        for(FieloPLT__Member__c member : new FieloCMSPLT_MembersSelector( new Set<String>{'FieloPLT__OrganizationAccount__r.FieloPLT__Status__c','FieloPLT__Type__c'} ).selectById(memberIds)){
            if(member.FieloPLT__OrganizationAccount__r.FieloPLT__Status__c == 'Active'){
                if(member.FieloPLT__Type__c != 'OrganizationContributor'){
                    throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorOrganizationAccountAction);
                } else {
                    if(member.FieloPLT__Status__c == 'New'){
                        uow.registerDeleted(member);
                        doCommit = true;
                    } else {
                        throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorDeleteFieloAccount);
                    }
                }
            }else{
                throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorFieloAccountBlocked);
            }
        }
        if(doCommit)
            uow.commitWork();
    }
}