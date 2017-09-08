@isTest
private class FieloCMSPLT_ToggleManagerCtrlTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_ToggleManagerCtrl.toggleManager(FieloCMSPLT_MockUpFactory.createMember('Test', 'fielo1@fielo123.com', FieloCMSPLT_MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_ToggleManagerCtrl.toggleManager(null, 'true');
	}
}