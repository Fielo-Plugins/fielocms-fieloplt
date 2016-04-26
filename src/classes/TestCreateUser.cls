@isTest
private class TestCreateUser{
	
	@isTest
	private static void PTF_ME024_FA2(){
		//datos requeridos
		Account a = MockUpFactory.createFieloAccount(UserInfo.getUserId());
		MockUpFactory.setCustomProperties(false);
		Program__c program = new ProgramsSelector().selectByDefault();
		List<Member__c> members = RTMockUpFactory.createMembers('TestMember', 1, program.Id);
		insert members;

		//Asignar account al contacto
		Contact c = [select id, name, accountId from contact where Id In (select Contact__c from Member__c where Id =: members.get(0).Id)];
		c.AccountId = a.Id;
		update c;

		Test.startTest();
			try{
				MemberService.finishRegistration(members[0]);
			}catch(Exception e){
				system.assertEquals(Label.MemberRequired, e.getMessage());
			}

			try{
				MemberService.setPasswordAndLogin(members[0].Id, null);
			}catch(Exception e){
				system.assertEquals(Label.PasswordIsRequiered, e.getMessage());
			}

			try{
				MemberService.setPasswordAndLogin(null, 'fielo123');
			}catch(Exception e){
				system.assertEquals(Label.MemberIdRequired, e.getMessage());
			}
		Test.stopTest();
	}

}