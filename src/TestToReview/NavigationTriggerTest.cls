/**
* @author Diego Amarante
* @date   09/09/2015
* @description
*/
@isTest
private class NavigationTriggerTest {

	/**
    * @author Diego Amarante
    * @date   09/09/2015
    * @description
    */
    @isTest(seeAllData=false) public static void unitTest(){
		MockUpFactory.setCustomProperties(false);
        insert new Navigation__c(Name='Test');
	}

}