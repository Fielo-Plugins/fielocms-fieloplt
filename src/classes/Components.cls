public without sharing class Components extends SObjectDomain {

    public Components(List<FieloCMS__Component__c> records) {
        super(records);
    }

    public override void onBeforeInsert() {
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
        List<User> users = [SELECT UserRole.Name, profile.name FROM User where UserRole.Name != null AND profile.Name = 'System Administrator' limit 1];
        List<FieloPLT__Program__c> programs = [SELECT Id, name, CreatedDate FROM FieloPLT__Program__c order by CreatedDate ASC limit 1];
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            if( record.AccountCRMMode__c == null || record.AccountCRMMode__c == '' ){
                record.AccountCRMMode__c = 'Standard Account';
            } else if(record.AccountCRMMode__c == 'Person Account' && !OrganizationUtil.isPersonAccountEnabled()) {
                record.addError('Must activate Person Account feature.');
            } else if(record.AccountCRMMode__c == 'Defined Account' && record.Account__c == null) {
                record.addError('Must select an Account.');
            }
            //Owner -> Admin con Role
            if(record.AccountOwner__c == null ){
               record.AccountOwner__c = users.get(0).Id;
            } else if(usersMap.containsKey(record.AccountOwner__c) && usersMap.get(record.AccountOwner__c).UserRoleId == null){
                record.addError('Owner must have a Role.');
            }

            //Program -> el primer program creado
            if(record.Program__c == null ){
                record.Program__c = programs.get(0).Id;
            }
        }
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {
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
        List<User> users = [SELECT UserRole.Name, profile.name FROM User where UserRole.Name != null AND profile.Name = 'System Administrator' limit 1];
        List<FieloPLT__Program__c> programs = [SELECT Id, name, CreatedDate FROM FieloPLT__Program__c order by CreatedDate ASC limit 1];
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            if( record.AccountCRMMode__c == null || record.AccountCRMMode__c == '' ){
                record.AccountCRMMode__c = 'Standard Account';
            } else if(record.AccountCRMMode__c == 'Person Account' && !OrganizationUtil.isPersonAccountEnabled()) {
                record.addError('Must activate Person Account feature.');
            } else if(record.AccountCRMMode__c == 'Defined Account' && record.Account__c == null) {
                record.addError('Must select an Account.');
            }
            //Owner -> Admin con Role
            if(record.AccountOwner__c == null ){
               record.AccountOwner__c = users.get(0).Id;
            } else if(usersMap.containsKey(record.AccountOwner__c) && usersMap.get(record.AccountOwner__c).UserRoleId == null){
                record.addError('Owner must have a Role.');
            }

            //Program -> el primer program creado
            if(record.Program__c == null ){
                record.Program__c = programs.get(0).Id;
            }
        }
    }

    public class Constructor implements SObjectDomain.IConstructable {
        public SObjectDomain construct(List<SObject> sObjectList) {
            return new Components(sObjectList);
        }
    }
}