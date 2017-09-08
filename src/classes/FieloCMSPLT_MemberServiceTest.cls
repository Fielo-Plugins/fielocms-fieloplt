@isTest
private class FieloCMSPLT_MemberServiceTest{

	@isTest
	static void itShould1(){
		
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;
		
		FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'Id','Name'});


		FieloCMSPLT_MemberService.setCurrentMemberId(member.Id);


		try{
			FieloCMSPLT_MemberService.setPasswordAndLogin(null, null);
		}catch(Exception e){}

		try{
			FieloCMSPLT_MemberService.setPasswordAndLogin(member.Id, null);
		}catch(Exception e){}
		FieloCMSPLT_MemberService.setPasswordAndLogin(member.Id, 'qwer1234');

		try{
			FieloCMSPLT_MemberService.login(null, null);
		}catch(Exception e){}

		try{
			FieloCMSPLT_MemberService.login(member.Id, null);
		}catch(Exception e){}
		FieloCMSPLT_MemberService.login(member.Id, 'qwer1234');

		try{
			FieloCMSPLT_MemberService.setPassword(null, null);
		}catch(Exception e){}

		try{
			FieloCMSPLT_MemberService.setPassword(member.Id, null);
		}catch(Exception e){}
		FieloCMSPLT_MemberService.setPassword(member.Id, '1234qwer');
	}

	@isTest
	static void itShould2(){
		
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Program__c program2 = new FieloPLT__Program__c(Name = 'test');
		insert program2;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;
		FieloPLT__Member__c member2 = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program2.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member2;
		FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'Id','Name'});


	}
}