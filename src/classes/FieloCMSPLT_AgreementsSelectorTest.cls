@isTest
private class FieloCMSPLT_AgreementsSelectorTest{
    @isTest
    static void itShould_1(){
        // Given
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'Test', FieloCMSPLT_SiteDomain__c = 'www.fielo.com');
        insert program;
        
        FieloPLT__Agreement__c agreement = new FieloPLT__Agreement__c(
            FieloPLT__Agreement__c = 'test',
            FieloPLT__Program__c = program.Id,
            FieloPLT__Status__c = 'Current'
        );
        insert agreement;
        
        List<FieloPLT__Agreement__c> agreements1 = new FieloCMSPLT_AgreementsSelector().selectById(new Set<Id>{agreement.Id});
        List<FieloPLT__Agreement__c> agreements2 = new FieloCMSPLT_AgreementsSelector(new Set<String>{'Name'}).selectById(new Set<Id>{agreement.Id});
        List<FieloPLT__Agreement__c> agreements3 = new FieloCMSPLT_AgreementsSelector().selectCurrentByProgram(program.Id);
    
    }
}