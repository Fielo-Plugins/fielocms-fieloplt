@isTest
private class FieloCMSPLT_ToggleManagerControllerTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_ToggleManagerController.toggleManager(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_ToggleManagerController.toggleManager(null, 'true');
	}
}