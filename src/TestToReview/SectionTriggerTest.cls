/**
* @author Alejandro Ferrante
* @date 29/05/2013
* @description Class to test the SectionTrigger
*/
@isTest
private class SectionTriggerTest {
    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description 
    */
     @isTest(seeAllData=false) static void unitTest(){        
        /*MockUpFactory.setCustomProperties(false);
        Section__c s = new Section__c(Type__c = '3-6-3');
        insert s;
        Page__c menu = new Page__c(Name = 'test');
        insert menu;
        Component__c c = new Component__c(Section__c = s.Id, Page__c = menu.Id);
        insert c;
        system.assertEquals(3,[SELECT Id FROM Section__c WHERE Parent__c =: s.Id].size());
        
        delete s;
        system.assertEquals(0,[SELECT Id FROM Section__c WHERE Parent__c =: s.Id].size()); */       
    }
}