@isTest
private class FieloCMSPLT_BlockUnblockMemberCtrlTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_BlockUnblockMemberCtrl.blockUnblockMember(MockUpFactory.createMember('Test', 'fielo1@fielo123.com', MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_BlockUnblockMemberCtrl.blockUnblockMember(null, 'true');
	}
}