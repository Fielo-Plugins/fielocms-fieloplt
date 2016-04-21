/**
* @author Alejandro Ferrante
* @date 29/05/2013
* @description Class to test the MenuPhotoUploadBackEndExtension
*/
@isTest
private class MenuPhotoUploadBackEndExtensionTest {

	/**
	* @author Alejandro Ferrante
	* @date 29/05/2013
	* @description Class to test the 
	*/
    @isTest(seeAllData=false) public static void unitTest(){
        Page__c m = new Page__c();
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(m);
        MenuPhotoUploadBackEndExtension controller = new MenuPhotoUploadBackEndExtension(sc);
        
        controller.getImagePositions();
        system.assertEquals(null, controller.doSave());
    }
}