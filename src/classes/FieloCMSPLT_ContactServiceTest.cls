@isTest
private class FieloCMSPLT_ContactServiceTest{
    @isTest
    static void itShould_1(){
    
        Account acc = new Account(Name = 'Test');
        insert acc;
        
        FieloCMSPLT_ContactService.getUnregisteredContacts(acc.Id, 0, 1,null);
        
    
    }
}