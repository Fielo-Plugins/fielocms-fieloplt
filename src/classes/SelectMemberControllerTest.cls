@isTest
private class SelectMemberControllerTest {
	
	@isTest static void test_method_one() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;


		SelectMemberController.selectMember(member.Id, 'Member');

		SelectMemberController.selectMember(member.Id, 'Organization Account');
		
		SelectMemberController.selectMember(member.Id, null);

	}
	
}