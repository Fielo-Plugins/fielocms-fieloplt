@isTest
private class FieloCMSPLT_OrganizationUtilTest{

	@isTest
	static void test1(){
		String fieldSet = '';
		FieloCMSPLT_OrganizationUtil.getFieldSet(fieldSet);

		FieloCMSPLT_OrganizationUtil.isPersonAccountEnabled();
	}

	@isTest
	static void insertMethods(){
		/*FieloCMS__Plugin__c plugin1 = new FieloCMS__Plugin__c( Name = 'Default', FieloCMS__Resource__c = 'www.url.com/static1', FieloCMS__ResourceContent__c = 'CSS' );
        insert new List<FieloCMS__Plugin__c> { plugin1};

        FieloCMS__ComponentLibrary__c componentLibrary1 = new FieloCMS__ComponentLibrary__c( Name = 'Default', FieloCMS__Plugin__c = plugin1.Id );
        insert new List<FieloCMS__ComponentLibrary__c> { componentLibrary1 };

    	//Crea una Pagina con un componente del plugin 1
        FieloCMS__Site__c site = new FieloCMS__Site__c(Name = 'Default');
        insert site;

        FieloCMS__Page__c page =  new FieloCMS__Page__c( Name = 'Default', FieloCMS__Site__c = site.Id);
        insert page;

        FieloCMS__Section__c section = new FieloCMS__Section__c(  FieloCMS__Page__c = page.Id);
        insert section;

        FieloCMS__Section__c subsection = new FieloCMS__Section__c( FieloCMS__Parent__c = section.Id);
        insert subsection;

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsection.Id, FieloCMS__ComponentLibrary__c = componentLibrary1.id, FieloCMS__DetailView__c = 'Modal' );
        insert component1;


        insert new FieloPLT__Program__c(Name = 'test');

        insert new FieloPLT__Reward__c(Name = 'test', FieloPLT__Points__c = 10, FieloPLT__Stock__c = 10);*/
	}
	
	@isTest
	static void itShould(){
/*
		OrganizationUtil.temporalTest1();
		OrganizationUtil.temporalTest2();
		OrganizationUtil.temporalTest3();
		OrganizationUtil.temporalTest4();
		OrganizationUtil.temporalTest5();
		OrganizationUtil.temporalTest6();
		OrganizationUtil.temporalTest7();
		OrganizationUtil.temporalTest8();
		OrganizationUtil.temporalTest9();
		OrganizationUtil.temporalTest10();
		OrganizationUtil.temporalTest11();
		OrganizationUtil.temporalTest12();
		OrganizationUtil.temporalTest13();
		OrganizationUtil.temporalTest14();
		OrganizationUtil.temporalTest15();
		OrganizationUtil.temporalTest16();
		OrganizationUtil.temporalTest17();
		OrganizationUtil.temporalTest18();
		OrganizationUtil.temporalTest19();
		OrganizationUtil.temporalTest20();
		OrganizationUtil.temporalTest21();
		OrganizationUtil.temporalTest22();
		OrganizationUtil.temporalTest23();
		OrganizationUtil.temporalTest24();
		OrganizationUtil.temporalTest25();
		OrganizationUtil.temporalTest26();
		OrganizationUtil.temporalTest27();
		OrganizationUtil.temporalTest28();
		OrganizationUtil.temporalTest29();
		OrganizationUtil.temporalTest30();*/

	}
}