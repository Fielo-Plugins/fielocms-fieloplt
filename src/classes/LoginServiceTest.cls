@isTest
private class LoginServiceTest {
	
	@isTest static void test_method_one() {
		
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'plugintest@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;

		Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
		User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='plugintest@fielo.com', isActive = false);
		insert u;

		Test.startTest();
			try{
				LoginService.login('plugintest1@fielo.com', 'qwer1235', 'www.google.com');
			}catch(Exception e){}
			
		Test.stopTest();
		//LoginService.login('plugintest@fielo.com', 'qwer1235', 'www.google.com');
	}
	
	@isTest static void test_method_two() {

		try{
			LoginService.forgotPassword('');
		}catch(Exception e){

		}
		
		try{
			LoginService.forgotPassword('test@fielo.com');
		}catch(Exception e){

		}


        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
		User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='test1plugin@fielo.com');
		insert u;

		LoginService.forgotPassword('test1plugin@fielo.com');
	}
	
}