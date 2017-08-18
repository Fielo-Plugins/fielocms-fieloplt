@isTest
private class FieloCMSPLT_MembersSelectorTest {
	
	@isTest static void test_method_one() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;


		new FieloCMSPLT_MembersSelector(new Set<String>{'Id','Name'}).selectRelatedMembers(UserInfo.getUserId(), program.Id);
		new FieloCMSPLT_MembersSelector().selectById(new Set<Id>{member.Id});
	}
	
	@isTest static void test_method_two() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;


		new FieloCMSPLT_MembersSelector(new Set<String>{'Id','Name'}).selectByOrganizationAccount(member.Id);
		
	}
	
}