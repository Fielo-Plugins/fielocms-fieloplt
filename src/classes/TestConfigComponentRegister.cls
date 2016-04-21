@isTest
private class TestConfigComponentRegister{
	
	@isTest
	private static void PTF_FE013_FB(){
		//preconditions
		MockUpFactory.setCustomProperties(false);
		OrganizationUtil.testPersonAccountEnabled = true;
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Person Account';
		registerComponent.AccountOwner__c = adminUser.Id;
		update registerComponent;

		Component__c registerComponentQuery = [SELECT AccountCRMMode__c, AccountOwner__c FROM Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Person Account', registerComponentQuery.AccountCRMMode__c);
		system.assertEquals(adminUser.Id, registerComponentQuery.AccountOwner__c);
	}
	
	@isTest
	private static void PTF_FE013_FA1(){
		//preconditions
		MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Standard Account';
		registerComponent.AccountOwner__c = adminUser.Id;
		update registerComponent;

		Component__c registerComponentQuery = [SELECT AccountCRMMode__c, AccountOwner__c FROM Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Standard Account', registerComponentQuery.AccountCRMMode__c);
		system.assertEquals(adminUser.Id, registerComponentQuery.AccountOwner__c);
	}

	@isTest
	private static void PTF_FE013_FA2(){
		//preconditions
		MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}
		Account defaultAccount = new Account(Name = 'TestAccount');
		insert defaultAccount;

		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Defined Account';
		registerComponent.Account__c = defaultAccount.Id;
		update registerComponent;

		Component__c registerComponentQuery = [SELECT AccountCRMMode__c, Account__c FROM Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Defined Account', registerComponentQuery.AccountCRMMode__c);
		system.assertEquals(defaultAccount.Id, registerComponentQuery.Account__c);
	}
	
	@isTest
	private static void PTF_FE013_FA3(){
		//preconditions
		MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}
		
		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Defined Account';
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals('You have to select the account', e.getDMLMessage(0));
		}
	}

	@isTest
	private static void PTF_FE013_FA4(){
		//preconditions
		MockUpFactory.setCustomProperties(false);
		OrganizationUtil.testPersonAccountEnabled = false;
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Person Account';
		registerComponent.AccountOwner__c = adminUser.Id;
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals(Label.PersonAccountNotEnabled, e.getDMLMessage(0));
		}
	}

	@isTest
	private static void PTF_FE013_FA5(){
		//preconditions
		MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		Account defaultAccount = new Account(Name = 'TestAccount');
		insert defaultAccount;
		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Standard Account';
		registerComponent.Account__c = defaultAccount.Id;
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals('You have to select the owner', e.getDMLMessage(0));
		}
	}

	@isTest
	private static void PTF_FE013_FA6(){
		//preconditions
		MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE UserRoleId = null LIMIT 1];
		
		RecordType rtRegister = [SELECT Id FROM RecordType WHERE DeveloperName = 'Register'];

		Page__c registerPage = new Page__c();
		insert registerPage;
		Component__c registerComponent = new Component__c(Page__c = registerPage.Id, RecordTypeId = rtRegister.Id);
		insert registerComponent;

		registerComponent.AccountCRMMode__c = 'Standard Account';
		registerComponent.AccountOwner__c = adminUser.Id;		
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals('The owner selected has no role', e.getDMLMessage(0));
		}
	}
}