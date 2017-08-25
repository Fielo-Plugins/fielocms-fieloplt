@isTest
private class FieloCMSPLT_HandleInvitationsMbrCtrlTest {
	
	@isTest static void test_method_one() {
		FieloCMSPLT_MockupFactory.setProgramAndMember();

		FieloPLT__Member__c member = [SElect id, name from FieloPLT__Member__c limit 1];

		FieloCMSPLT_HandleInvitationsMbrCtrl.resendInvitation(member.Id);
		FieloCMSPLT_HandleInvitationsMbrCtrl.cancelInvitation(member.Id);
	}
	
	@isTest static void test_method_two() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		Account a = new Account(Name = 'test');
		insert a;
		FieloPLT__Member__c orgaAccount = new FieloPLT__Member__c(Name = 'test', FieloPLT__Account__c = a.Id, FieloPLT__Program__c = program.Id, FieloPLT__Status__c = 'Active', FieloPLT__Email__c = 'test1@fielo.com', FieloPLT__Type__c = 'Organization Account');
		insert orgaAccount;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId(), FieloPLT__OrganizationAccount__c = orgaAccount.Id, FieloPLT__Type__c = 'Organization Contributor');
		insert member;

		


		FieloCMSPLT_HandleInvitationsMbrCtrl.cancelInvitation(member.Id);
	}
	
}