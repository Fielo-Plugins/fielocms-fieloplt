@isTest
private class FieloCMSPLT_BlockUnblockMemberCtrlTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_BlockUnblockMemberCtrl.FieloCMSPLT_blockUnblockMember(FieloCMSPLT_MockUpFactory.createMember('Test', 'fielo1@fielo123.com', FieloCMSPLT_MockUpFactory.createProgram(), null), 'true');
		FieloCMSPLT_BlockUnblockMemberCtrl.FieloCMSPLT_blockUnblockMember(null, 'true');
	}
}