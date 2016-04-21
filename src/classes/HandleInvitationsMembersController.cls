//NO DOCUMENT
global with sharing class HandleInvitationsMembersController {

    @RemoteAction
    global static RemoteActionResult resendInvitation(Id componentId, Id memberId){
        RemoteActionResult result = new RemoteActionResult();

        try {
            resendInvitations(new Set<Id>{memberId});
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

    @RemoteAction
    global static RemoteActionResult cancelInvitation(Id componentId, Id memberId){
        RemoteActionResult result = new RemoteActionResult();

        try {
            cancelInvitations(MemberUtil.getMemberId(), new Set<Id>{memberId});
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

    private static void resendInvitations(Set<Id> memberIds){
        Set<Id> programIds = new Set<Id>();
        List<Member__c> members = new MembersSelector().selectById(memberIds);
        for(Member__c member : members){
            programIds.add(member.Program__c);
        }
        Map<Id, Program__c> programsMap = new Map<Id, Program__c>( new ProgramsSelector().selectbyId(programIds) );
        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{Email__c.SObjectType});
        for(Member__c member : members){
            String recipientName = member.FirstName__c + ' ' + member.LastName__c;
            String url = programsMap.get(member.Program__c).SiteUrl__c + OrganizationUtil.getPrefixUnderScore() + 'Page?memberId=' + member.Id + '&pageId=' + programsMap.get(member.Program__c).RegisterPage__c;
            uow.registerNew( new Email__c(Email__c = member.Email__c, Type__c = 'Register', Member__c = member.Id, Program__c = member.Program__c, Link__c = url, RecipientName__c = recipientName) );
        }

        uow.commitWork();
    }

    private static void cancelInvitations(Id orgAccountId, Set<Id> memberIds){
        List<Member__c> orgAccount = new MembersSelector( new Set<String>{'RecordType.DeveloperName', OrganizationUtil.getPrefixUnderScore()+'Blocked__c'} ).selectById( new Set<Id>{orgAccountId} );
        if( orgAccount.get(0).RecordType.DeveloperName == 'OrganizationAccount' ){
            if( !orgAccount.get(0).Blocked__c ){
                Boolean doCommit = false;
                SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{Member__c.SObjectType});
                for(Member__c member : new MembersSelector( new Set<String>{'RecordType.DeveloperName'} ).selectById(memberIds)){
                    if(member.RecordType.DeveloperName != 'OrganizationContributor'){
                        throw new FieloCustomException(Label.ErrorOrganizationAccountAction);
                    } else {
                        if(member.FieloAccountStatus__c == 'New'){
                            uow.registerDeleted(member);
                            doCommit = true;
                        } else {
                            throw new FieloCustomException(Label.ErrorDeleteFieloAccount);
                        }
                    }
                }
                if(doCommit)
                    uow.commitWork();
            } else {
                throw new FieloCustomException(Label.ErrorFieloAccountBlocked);
            }
        } else {
            throw new FieloCustomException(Label.ErrorOrganizationAccountAction);
        }
    }
}