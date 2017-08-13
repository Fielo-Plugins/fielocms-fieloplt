@isTest
private class ChangePasswordFieloControllerTest {

	@isTest(seeAllData=false) static void testChangePasswordController() {
        ChangePasswordFieloController controller = new ChangePasswordFieloController();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        System.assertEquals(null,controller.changePassword());


        ChangePasswordFieloController.changePassword('qwer123','qwer123', '123456' );
    }        
    
}