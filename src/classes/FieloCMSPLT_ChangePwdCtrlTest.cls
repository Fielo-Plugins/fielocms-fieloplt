@isTest
private class FieloCMSPLT_ChangePwdCtrlTest {

	@isTest(seeAllData=false) static void testChangePasswordController() {
        FieloCMSPLT_ChangePwdCtrl controller = new FieloCMSPLT_ChangePwdCtrl();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        System.assertEquals(null,controller.changePassword());


        FieloCMSPLT_ChangePwdCtrl.changePassword('qwer123','qwer123', '123456' );
    }        
    
}