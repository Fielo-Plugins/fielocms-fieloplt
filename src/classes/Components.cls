public without sharing class Components extends SObjectDomain {

    public Components(List<FieloCMS__Component__c> records) {
        super(records);
    }

    public override void onApplyDefaults() {
        List<User> users = [SELECT UserRole.Name, profile.name FROM User where UserRole.Name != null AND profile.Name = 'System Administrator' limit 1];
        List<FieloPLT__Program__c> programs = [SELECT Id, name, CreatedDate FROM FieloPLT__Program__c order by CreatedDate ASC limit 1];
        for(FieloCMS__Component__c record : (List<FieloCMS__Component__c>) records){
            if( record.AccountCRMMode__c == null || record.AccountCRMMode__c == '' ){
                record.AccountCRMMode__c = 'Standard Account';
            }
            //Owner -> Admin con Role
            if(record.AccountOwner__c == null ){
               record.AccountOwner__c = users.get(0).Id;
            }
            //Program -> el primer program creado
            if(record.Program__c == null ){
                record.Program__c = programs.get(0).Id;
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