@isTest
private class ToggleManagerControllerTest {
	
	@isTest static void test_method_one() {
		ToggleManagerController.toggleManager(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		ToggleManagerController.toggleManager(null, 'true');
	}
}