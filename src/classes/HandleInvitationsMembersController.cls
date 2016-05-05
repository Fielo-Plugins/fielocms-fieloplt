global with sharing class HandleInvitationsMembersController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){   
        Component.HandleInvitationsMembers handleInvitationsMembers = new Component.HandleInvitationsMembers();        
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
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
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

        return result;
    }

    private static void resendInvitations(Set<Id> memberIds){
        Set<Id> programIds = new Set<Id>();
        List<FieloAlpha__Member__c> members = new MembersSelector().selectById(memberIds);
        for(FieloAlpha__Member__c member : members){
            programIds.add(member.FieloAlpha__Program__c);
        }
        Map<Id, FieloAlpha__Program__c> programsMap = new Map<Id, FieloAlpha__Program__c>([SELECT FieloAlpha__SiteUrl__c, FieloAlpha__RegisterPage__c FROM FieloAlpha__Program__c WHERE Id in : programIds]);
        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloAlpha__Email__c.SObjectType});
        for(FieloAlpha__Member__c member : members){
            String recipientName = member.FieloAlpha__FirstName__c + ' ' + member.FieloAlpha__LastName__c;
            String url = programsMap.get(member.FieloAlpha__Program__c).FieloAlpha__SiteUrl__c + 'FieloAlpha__Page?memberId=' + member.Id + '&pageId=' + programsMap.get(member.FieloAlpha__Program__c).FieloAlpha__RegisterPage__c;
            uow.registerNew( new FieloAlpha__Email__c(FieloAlpha__Email__c = member.FieloAlpha__Email__c, FieloAlpha__Type__c = 'Register', FieloAlpha__Member__c = member.Id, FieloAlpha__Program__c = member.FieloAlpha__Program__c, FieloAlpha__Link__c = url, FieloAlpha__RecipientName__c = recipientName) );
        }

        uow.commitWork();
    }

    public static void cancelInvitations(Set<Id> memberIds){
        List<FieloAlpha__Member__c> members = new MembersSelector( new Set<String>{'RecordType.DeveloperName', 'FieloAlpha__OrganizationAccount__r.FieloAlpha__Blocked__c'} ).selectById(new Set<Id>(memberIds));                
        Boolean doCommit = false;
        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloAlpha__Member__c.SObjectType});                
        for(FieloAlpha__Member__c member : new MembersSelector( new Set<String>{'RecordType.DeveloperName'} ).selectById(memberIds)){
            if(!member.FieloAlpha__OrganizationAccount__r.FieloAlpha__Blocked__c){
                if(member.RecordType.DeveloperName != 'OrganizationContributor'){
                    throw new FieloCustomException(Label.ErrorOrganizationAccountAction);
                } else {
                    if(member.FieloAlpha__FieloAccountStatus__c == 'New'){
                        uow.registerDeleted(member);
                        doCommit = true;
                    } else {
                        throw new FieloCustomException(Label.ErrorDeleteFieloAccount);
                    }
                }
            }else{
                throw new FieloCustomException(Label.ErrorFieloAccountBlocked);
            }
        }
        if(doCommit)
            uow.commitWork();            
    }
}