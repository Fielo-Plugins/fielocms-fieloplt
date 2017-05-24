public without sharing class Components extends SObjectDomain {

    public Components(List<FieloCMS__Component__c> records) {
        super(records);
    }

    public override void onValidate() {
        Set<Id> componentLibraryIds = new Set<Id>();
        Set<Id> ownerIds = new Set<Id>();
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            componentLibraryIds.add(record.FieloCMS__ComponentLibrary__c);

            if(record.AccountOwner__c != null){
                ownerIds.add(record.AccountOwner__c);
            }
        }
        Map<Id, FieloCMS__ComponentLibrary__c> componentLibraryMap = new Map<Id, FieloCMS__ComponentLibrary__c>( new ComponentsLibrariesSelector(new Set<String>{'FieloCMS__DeveloperName__c'}).selectById(componentLibraryIds) );
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id, Name, UserRoleId FROM User WHERE Id In: ownerIds]);
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            if( componentLibraryMap.containsKey(record.FieloCMS__ComponentLibrary__c) && componentLibraryMap.get(record.FieloCMS__ComponentLibrary__c).FieloCMS__DeveloperName__c == 'PlatformPlugin.Register'){
                if(record.AccountCRMMode__c == '' || record.AccountCRMMode__c == null ){
                    record.addError('Must Select a Mode.');
                } else if(record.AccountCRMMode__c == 'Person Account' && !OrganizationUtil.isPersonAccountEnabled()) {
                    record.addError('Must activate Person Account feature.');
                } else if(record.AccountCRMMode__c == 'Defined Account' && record.Account__c == null) {
                    record.addError('Must select an Account.');
                }
                if(record.AccountOwner__c == null ){
                    record.addError('Must Select a Owner.');
                } else if(usersMap.containsKey(record.AccountOwner__c) && usersMap.get(record.AccountOwner__c).UserRoleId == null){
                    record.addError('Owner must have a Role.');
                }
                if(record.Program__c == '' || record.Program__c == null ){
                    record.addError('Must Select a Program.');
                }
            }
        }
    }



    public override void onValidate(Map<Id,SObject> existingRecords){
        Set<Id> componentLibraryIds = new Set<Id>();
        Set<Id> ownerIds = new Set<Id>();
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            componentLibraryIds.add(record.FieloCMS__ComponentLibrary__c);

            if(record.AccountOwner__c != null){
                ownerIds.add(record.AccountOwner__c);
            }
        }
        Map<Id, FieloCMS__ComponentLibrary__c> componentLibraryMap = new Map<Id, FieloCMS__ComponentLibrary__c>( new ComponentsLibrariesSelector(new Set<String>{'FieloCMS__DeveloperName__c'}).selectById(componentLibraryIds) );
        Map<Id, User> usersMap = new Map<Id, User>([SELECT Id, Name, UserRoleId FROM User WHERE Id In: ownerIds]);
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            if( componentLibraryMap.containsKey(record.FieloCMS__ComponentLibrary__c) && componentLibraryMap.get(record.FieloCMS__ComponentLibrary__c).FieloCMS__DeveloperName__c == 'PlatformPlugin.Register'){
                if(record.AccountCRMMode__c == '' || record.AccountCRMMode__c == null ){
                    record.addError('Must Select a Mode.');
                } else if(record.AccountCRMMode__c == 'Person Account' && !OrganizationUtil.isPersonAccountEnabled()) {
                    record.addError('Must activate Person Account feature.');
                } else if(record.AccountCRMMode__c == 'Defined Account' && record.Account__c == null) {
                    record.addError('Must select an Account.');
                }
                if(record.AccountOwner__c == null ){
                    record.addError('Must Select a Owner.');
                } else if(usersMap.containsKey(record.AccountOwner__c) && usersMap.get(record.AccountOwner__c).UserRoleId == null){
                    record.addError('Owner must have a Role.');
                }
                if(record.Program__c == '' || record.Program__c == null ){
                    record.addError('Must Select a Program.');
                }
            }
        }
    }

    public override void onBeforeInsert() {
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {

    }

    public class Constructor implements SObjectDomain.IConstructable {
        public SObjectDomain construct(List<SObject> sObjectList) {
            return new Components(sObjectList);
        }
    }
}