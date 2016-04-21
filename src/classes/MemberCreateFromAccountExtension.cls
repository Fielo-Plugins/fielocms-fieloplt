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
                createResults = MemberService.createFromAccounts(accountIds, programId);
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

}