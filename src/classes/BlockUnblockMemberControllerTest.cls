@isTest
private class BlockUnblockMemberControllerTest {
	
	@isTest static void test_method_one() {
		BlockUnblockMemberController.blockUnblockMember(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		BlockUnblockMemberController.blockUnblockMember(null, 'true');
	}
}