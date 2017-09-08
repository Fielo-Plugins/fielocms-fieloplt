@isTest
private class FieloCMSPLT_LoginServiceTest {
	
	@isTest static void test_method_one() {
		
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'plugintest@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;

		//Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
		Profile p = [select id, name, UserType, UserLicense.Name from profile where UserType = 'Standard' limit 1];
		User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='plugintest@fielo.com', isActive = false);
		insert u;

		Test.startTest();
			try{
				FieloCMSPLT_LoginService.login('plugintest1@fielo.com', 'qwer1235', 'www.google.com');
			}catch(Exception e){}
			
		Test.stopTest();
		//FieloCMSPLT_LoginService.login('plugintest@fielo.com', 'qwer1235', 'www.google.com');
	}
	
	@isTest static void test_method_two() {

		try{
			FieloCMSPLT_LoginService.forgotPassword('');
		}catch(Exception e){

		}
		
		try{
			FieloCMSPLT_LoginService.forgotPassword('test@fielo.com');
		}catch(Exception e){

		}

        //Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
		Profile p = [select id, name, UserType, UserLicense.Name from profile where UserType = 'Standard' limit 1];
		User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='test1plugin@fielo.com');
		insert u;

		FieloCMSPLT_LoginService.forgotPassword('test1plugin@fielo.com');
	}
	
}