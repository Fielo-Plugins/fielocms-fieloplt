/**
* @description Class to create a member from an Account
*/
public with sharing class MemberCreateFromAccountExtension {
    public List<Account> accounts{get; set;}

    /**
    * @description constructor
    */
    public MemberCreateFromAccountExtension(ApexPages.StandardSetController ssc){

        Id accountId = ApexPages.currentPage().getParameters().get('accountId');
        if(accountId != null){
            accounts = new AccountsSelector().selectById(new Set<Id>{accountId});
        }else{
            if(!System.Test.isRunningTest()){
                List<String> fieldsAccount = new List<String>{'Id', 'Name'};
                ssc.addFields(fieldsAccount);
            }
            accounts = ssc.getSelected();
        }
    }

    /**
    * @description convierte la lista de contactos en members de Fielo
    * @return RemoteActionResult 
    */
    @RemoteAction
    static public RemoteActionResult createMembers(List<Id> listAccountId, Id programId){
        RemoteActionResult result = new RemoteActionResult();
        Map<Id,String> createResults;
        if(listAccountId.size() > 0){
            try {
                Set<Id> accountIds = new Set<Id>();
                for ( String id : listAccountId ) {
                    accountIds.add(id);
                }
                createResults = createFromAccounts(accountIds, programId);
            } catch(Exception e) {
                result.addMessage( new RemoteActionResult.RemoteActionMessage(e) );
            }
     
            if(createResults != null){
                for ( Id accountId :createResults.keySet() ) {
                    result.addMessage( new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.ERROR , createResults.get(accountId) ) );
                }
            } else {
                result.addMessage( new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info , Label.SuccessfulMembersCreation ) );
            }

        }else{
            result.addMessage( new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.ERROR , Label.PleaseSelectAtLeastOneAccount ) );
        }

        return result;
    }

    /**
    * @description returns a list with the posible Programs
    * @return List<SelectOption>
    */
    public List<SelectOption> getPrograms(){
        return SiteUtil.getProgramsSelectOptions();
    }

    private static Map<Id, String> createFromAccounts(Set<Id> accountIds, String programId){
        Map<Id, String> errorsMap;
        AccountsSelector accountsSelector = new AccountsSelector();

        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{Member__c.SObjectType});
        Id indAccRT;
        Id orgAccRT;

        for(RecordType rt : new RecordTypesSelector().getRecordTypes(OrganizationUtil.getPrefixUnderScore() + 'Member__c')){
            if(rt.DeveloperName == 'OrganizationAccount') orgAccRT = rt.Id;
            if(rt.DeveloperName == 'IndividualAccount') indAccRT = rt.Id;
        }

        List<Id> accountIdsList = new List<Id>();

        Map<Id, RecordType> accRecordTypesMap = new Map<Id, RecordType>(new RecordTypesSelector().getRecordTypes('Account'));

        Map<Id,String> accountsNameMap = new Map<Id,String>();

        for(Account acc : accountsSelector.selectByIdWithPersonAccountContacts(accountIds)){
            accountsNameMap.put(acc.Id, acc.Name);
            Member__c member = new Member__c(Program__c = programId, Account__c = acc.Id);

            if(acc.get('RecordTypeId') != null && accRecordTypesMap.get((Id)acc.get('RecordTypeId')).DeveloperName == 'PersonAccount'){
                member.RecordTypeId = indAccRT;
                Contact c = acc.Contacts.get(0);
                member.Contact__c = c.Id;
                member.FirstName__c = c.FirstName;
                member.LastName__c = c.LastName;
                member.Email__c = c.Email;
            }else{
                member.RecordTypeId = orgAccRT;
                member.OrganizationName__c = acc.Name;
            }
            accountIdsList.add(acc.Id);
            uow.registerNew(member);
        }

        try {
            uow.commitWork();
        } catch(DMLException e) {
            errorsMap = new Map<Id, String>();
            //Message to return error
            for(Integer i = 0; i < e.getNumDML() ; i++){
                errorsMap.put(accountIdsList.get(e.getDmlIndex(i)), accountsNameMap.get(accountIdsList.get(e.getDmlIndex(i))) + ': ' + e.getDMLMessage(i));
            }
        }

        return errorsMap;
    }

}