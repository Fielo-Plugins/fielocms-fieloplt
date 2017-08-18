@isTest
private class FieloCMSPLT_BlockUnblockMemberControllerTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_BlockUnblockMemberController.blockUnblockMember(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_BlockUnblockMemberController.blockUnblockMember(null, 'true');
	}
}