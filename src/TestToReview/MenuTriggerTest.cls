/**
* @author Alejandro Ferrante
* @date 29/05/2013
* @description Class to test the MenuTrigger
*/
@isTest
private class MenuTriggerTest {

    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description Class to test the Trigger Methods
    */
    @isTest(seeAllData=false) public static void unitTest(){
        MockUpFactory.setCustomProperties(false);
        Page__c parent = new Page__c();
        insert parent;
        Page__c child = new Page__c(Page__c = parent.Id);
        insert child;
        child.Home__c = true;
        update child;

        MenuTrigger.validateParentMenus(new List<Page__c>{child});
        MenuTrigger.validateChildMenus(new List<Page__c>{parent, child});
        
        Page__c oneC = new Page__c(Layout__c = 'One Column');
        insert oneC;
        Page__c twoC = new Page__c(Layout__c = 'Two Columns');
        insert twoC;
        Page__c bTwoC = new Page__c(Layout__c = 'Banner + Two Columns');
        insert bTwoC;
        Page__c adv = new Page__c(Layout__c = 'Advanced');
        insert adv;
    }
}