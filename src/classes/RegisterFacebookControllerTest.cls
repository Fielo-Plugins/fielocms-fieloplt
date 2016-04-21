/**
* @author Leonardo Teren
* @date   06/01/2015
* @description 
*/
@isTest
private class RegisterFacebookControllerTest {
	/**
	* @author Leonardo Teren
	* @date   06/01/2015
	* @description 
	*/
	@isTest static void test1() {
		MockUpFactory.setCustomProperties(false);
		RegisterFacebookController rfc = new RegisterFacebookController();
		Site__c p = rfc.program;
	}
	
}