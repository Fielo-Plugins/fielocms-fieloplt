/**
* @author Matias Trionfetti
* @date   13/07/2011
* @description  Class is used to change password in the site
*/
@isTest
private class ChangePasswordFieloControllerTest {

	/**
	* @author Matias Trionfetti
	* @date   13/07/2011
	* @description  Method to test a password change.
	*/
	@isTest(seeAllData=false) static void testChangePasswordController() {
        ChangePasswordFieloController controller = new ChangePasswordFieloController();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        System.assertEquals(null,controller.changePassword());                           
    }        
    
}