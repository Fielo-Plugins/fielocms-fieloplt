@isTest
private class FieloCMSPLT_NavigationServiceTest{
    @isTest
    static void itShould_1(){
        
        // Given
        FieloCMSPLT_MockupFactory.setProgramAndMember();
        
        FieloCMS__Site__c site = new FieloCMS__Site__c(Name = 'Default');
        insert site;
        
        FieloPLT__Member__c member = [SELECT Id FROM FieloPLT__Member__c];
               
        try{
            FieloCMSPLT_NavigationService.getNavigations(null, new Set<String>{'Name'},site.Id,member.Id);
        }catch(Exception e){
        }
    
    }
}