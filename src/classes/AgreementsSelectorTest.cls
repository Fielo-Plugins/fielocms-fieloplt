@isTest
private class AgreementsSelectorTest{
    @isTest
    static void itShould_1(){
        // Given
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'Test', SiteDomain__c = 'www.fielo.com');
        insert program;
        
        FieloPLT__Agreement__c agreement = new FieloPLT__Agreement__c(
            FieloPLT__Agreement__c = 'test',
            FieloPLT__Program__c = program.Id,
            FieloPLT__Status__c = 'Current'
        );
        insert agreement;
        
        List<FieloPLT__Agreement__c> agreements1 = new AgreementsSelector().selectById(new Set<Id>{agreement.Id});
        List<FieloPLT__Agreement__c> agreements2 = new AgreementsSelector(new Set<String>{'Name'}).selectById(new Set<Id>{agreement.Id});
        List<FieloPLT__Agreement__c> agreements3 = new AgreementsSelector().selectCurrentByProgram(program.Id);
    
    }
}