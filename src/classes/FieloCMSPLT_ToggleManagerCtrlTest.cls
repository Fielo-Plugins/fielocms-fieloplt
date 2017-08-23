@isTest
private class FieloCMSPLT_ToggleManagerCtrlTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_ToggleManagerCtrl.toggleManager(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_ToggleManagerCtrl.toggleManager(null, 'true');
	}
}