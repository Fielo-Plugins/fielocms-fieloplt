@isTest
private class FieloCMSPLT_BadgeServiceTest{
    @isTest
    static void itShould_1(){
    
        // Given
        FieloCMSPLT_MockupFactory.setProgramAndMember();
        
        FieloPLT__Program__c program = [SELECT Id FROM FieloPLT__Program__c];
        
        FieloPLT__Member__c member = [SELECT Id FROM FieloPLT__Member__c];
        
        FieloPLT__Badge__c badge = new FieloPLT__Badge__c(Name = 'Test', FieloPLT__Program__c = program.Id);
        insert badge;
        
        FieloPLT__BadgeMember__c badgeMember = new FieloPLT__BadgeMember__c(FieloPLT__Member__c = member.Id, FieloPLT__Badge__c = badge.Id);
        insert badgeMember;
        
        List<FieloPLT__Badge__c> badges = FieloCMSPLT_BadgeService.getBadges(new Set<String>{'Name'},program.Id,member.Id,10,0,null);    
    
    }
}