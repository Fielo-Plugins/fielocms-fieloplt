@isTest
private class UserCreationFieloTest {
	
	@isTest static void test_method_one() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
			
		Contact contact = new Contact(FirstName = 'test1', LastName = 'treqwe', Email = 'test123@fielo.com');
		insert contact;

		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;


		UserCreationFielo uc = new UserCreationFielo();
		uc.getUser(member, contact.Id);
	}
	
	
}