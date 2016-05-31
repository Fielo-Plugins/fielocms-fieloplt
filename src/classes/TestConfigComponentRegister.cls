@isTest
private class TestConfigComponentRegister{
	
	@isTest
	private static void PTF_FE013_FB(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);
		//OrganizationUtil.testPersonAccountEnabled = true;
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Person Account';
		registerComponent.FieloCMS_EE__AccountOwner__c = adminUser.Id;
		update registerComponent;

		FieloCMS__Component__c registerComponentQuery = [SELECT FieloCMS_EE__AccountCRMMode__c, FieloCMS_EE__AccountOwner__c FROM FieloCMS__Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Person Account', registerComponentQuery.FieloCMS_EE__AccountCRMMode__c);
		system.assertEquals(adminUser.Id, registerComponentQuery.FieloCMS_EE__AccountOwner__c);
	}
	
	@isTest
	private static void PTF_FE013_FA1(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Standard Account';
		registerComponent.FieloCMS_EE__AccountOwner__c = adminUser.Id;
		update registerComponent;

		FieloCMS__Component__c registerComponentQuery = [SELECT FieloCMS_EE__AccountCRMMode__c, FieloCMS_EE__AccountOwner__c FROM FieloCMS__Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Standard Account', registerComponentQuery.FieloCMS_EE__AccountCRMMode__c);
		system.assertEquals(adminUser.Id, registerComponentQuery.FieloCMS_EE__AccountOwner__c);
	}

	@isTest
	private static void PTF_FE013_FA2(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}
		Account defaultAccount = new Account(Name = 'TestAccount');
		insert defaultAccount;

		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Defined Account';
		registerComponent.Account__c = defaultAccount.Id;
		update registerComponent;

		FieloCMS__Component__c registerComponentQuery = [SELECT FieloCMS_EE__AccountCRMMode__c, Account__c FROM FieloCMS__Component__c WHERE Id =: registerComponent.Id];
		system.assertEquals('Defined Account', registerComponentQuery.FieloCMS_EE__AccountCRMMode__c);
		system.assertEquals(defaultAccount.Id, registerComponentQuery.Account__c);
	}
	
	@isTest
	private static void PTF_FE013_FA3(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}
		
		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Defined Account';
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals('You have to select the Account', e.getDMLMessage(0));
		}
	}

	@isTest
	private static void PTF_FE013_FA4(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);
		//OrganizationUtil.testPersonAccountEnabled = false;
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		if(adminUser.UserRoleId == null){
			UserRole role = [SELECT Id FROM UserRole LIMIT 1];
			adminUser.UserRoleId = role.Id;
			update adminUser;
		}

		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Person Account';
		registerComponent.FieloCMS_EE__AccountOwner__c = adminUser.Id;
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals(Label.FieloAlpha.PersonAccountNotEnabled, e.getDMLMessage(0));
		}
	}

	@isTest
	private static void PTF_FE013_FA5(){
		//preconditions
		FieloAlpha.MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE Id =: UserInfo.getUserId()];
		Account defaultAccount = new Account(Name = 'TestAccount');
		insert defaultAccount;
		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Standard Account';
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
		FieloAlpha.MockUpFactory.setCustomProperties(false);		
		User adminUser = [SELECT Id, UserRoleId FROM User WHERE UserRoleId = null LIMIT 1];
		
		FieloCMS__ComponentLibrary__c registerCL = new FieloCMS__ComponentLibrary__c(Name = 'Register');
		insert registerCL;

		//Creo la página
		FieloCMS__Page__c page = new FieloCMS__Page__c();
		insert page;

		FieloCMS__Section__c section = new FieloCMS__Section__c(FieloCMS__Page__c = page.Id);
		insert section;

		FieloCMS__Section__c subSection = new FieloCMS__Section__c(FieloCMS__Parent__c = section.Id);
		insert subSection;

		FieloCMS__Component__c registerComponent = new FieloCMS__Component__c(FieloCMS__ComponentLibrary__c = registerCL.Id, FieloCMS__Section__c = subSection.Id);
		insert registerComponent;

		registerComponent.FieloCMS_EE__AccountCRMMode__c = 'Standard Account';
		registerComponent.FieloCMS_EE__AccountOwner__c = adminUser.Id;		
		try{
			update registerComponent;
		}catch(DMLException e){
			system.assertEquals('The owner selected has no role', e.getDMLMessage(0));
		}
	}
}