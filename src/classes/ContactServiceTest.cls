@isTest
private class ContactServiceTest{
    @isTest
    static void itShould_1(){
    
        Account acc = new Account(Name = 'Test');
        insert acc;
        
        ContactService.getUnregisteredContacts(acc.Id, 0, 1,null);
        
    
    }
}