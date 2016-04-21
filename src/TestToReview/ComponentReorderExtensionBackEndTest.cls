/** 
* @author Alejandro Ferrante
* @date 28/05/2013
* @description Class used to test ComponentReorderExtension
*/
@isTest
private class ComponentReorderExtensionBackEndTest {

	/** 
	* @author Alejandro Ferrante
	* @date 28/05/2013
	* @description Tests the constructor of the class
	*/ 
    @isTest(seeAllData=false) public static void unitTest(){
    	// create menu
        Page__c m = new Page__c();
        // create standard controllercontroller
        ApexPages.StandardController standardController = new ApexPages.StandardController(m);
        // create extension
        ComponentReorderExtensionBackend controller = new ComponentReorderExtensionBackend(standardController);        
    
    }

}