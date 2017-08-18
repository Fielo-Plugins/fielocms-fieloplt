@isTest
private class FieloCMSPLT_LoginAsControllerTest {

	@isTest static void validLogin() {
		//comentado porque ahora 
		//crate new member with user
		/*MockUpFactory.setCustomProperties(false);
		Member__c member = new Member__c(LastName__c = 'test member', Email__c = 'test@fielo.com');
		insert member;
		User u = [SELECT Id, User__r.Id FROM Member__c WHERE Id =: member.Id].User__r;

		//get custom setting and set a valid hash and expiration date
		FrontEndSessionData__c fe = FrontEndSessionData__c.getInstance(u.Id);
		fe.Hash__c = 'testHash';
		fe.ExpirationDate__c = System.now().addMinutes(5);
		upsert fe;

		LoginAscontroller controller = new LoginAscontroller();
		system.currentPageReference().getParameters().put('testUser',u.Id);
		system.currentPageReference().getParameters().put('hash','testHash');
		controller.login();*/
	}

	@isTest static void invalidLogin() {
		//comentado porque ahora el usuario se crea por front end
		//crate new member with user
		/*MockUpFactory.setCustomProperties(false);
		Member__c member = new Member__c(LastName__c = 'test member', Email__c = 'test@fielo.com');
		insert member;
		User u = [SELECT Id, User__r.Id FROM Member__c WHERE Id =: member.Id].User__r;

		LoginAscontroller controller = new LoginAscontroller();
		system.currentPageReference().getParameters().put('testUser',u.Id);		
		controller.login();*/
	}
	
}