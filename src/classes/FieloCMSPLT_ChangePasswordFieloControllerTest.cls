@isTest
private class FieloCMSPLT_ChangePasswordFieloControllerTest {

	@isTest(seeAllData=false) static void testChangePasswordController() {
        FieloCMSPLT_ChangePasswordFieloController controller = new FieloCMSPLT_ChangePasswordFieloController();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        System.assertEquals(null,controller.changePassword());


        FieloCMSPLT_ChangePasswordFieloController.changePassword('qwer123','qwer123', '123456' );
    }        
    
}