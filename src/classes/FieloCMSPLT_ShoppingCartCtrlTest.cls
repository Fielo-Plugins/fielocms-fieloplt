@isTest
private class FieloCMSPLT_ShoppingCartCtrlTest {
	
	@isTest static void test_method_one() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;

		FieloCMSPLT_MockUpFactory.createRewards('Test', 10,  program.Id, 10);

		FieloCMSPLT_ShoppingCartCtrl sc = new FieloCMSPLT_ShoppingCartCtrl();
		List<FieloPLT__Reward__c> rewards = sc.rewards;

		Integer qant = sc.totalItems;

		Map<Id, Integer> mapa = sc.totalPointsMap;




		FieloCMS__Plugin__c plugin1 = new FieloCMS__Plugin__c( Name = 'Default', FieloCMS__Resource__c = 'www.url.com/static1', FieloCMS__ResourceContent__c = 'CSS' );
        FieloCMS__Plugin__c plugin2 = new  FieloCMS__Plugin__c( Name = 'Default', FieloCMS__Resource__c = 'www.url.com/static2', FieloCMS__ResourceContent__c = 'Both' );
        insert new List<FieloCMS__Plugin__c> { plugin1, plugin2 };

        FieloCMS__ComponentLibrary__c componentLibrary1 = new FieloCMS__ComponentLibrary__c( Name = 'Default', FieloCMS__Plugin__c = plugin1.Id );
        FieloCMS__ComponentLibrary__c componentLibrary2 = new FieloCMS__ComponentLibrary__c( Name = 'Default', FieloCMS__Plugin__c = plugin2.Id );
        insert new List<FieloCMS__ComponentLibrary__c> { componentLibrary1, componentLibrary2 };

    //Crea una Pagina con un componente del plugin 1
        FieloCMS__Site__c site = new FieloCMS__Site__c(Name = 'Default');
        insert site;

        FieloCMS__Page__c page =  new FieloCMS__Page__c( Name = 'Default', FieloCMS__Site__c = site.Id);
        insert page;

        FieloCMS__Section__c section = new FieloCMS__Section__c(  FieloCMS__Page__c = page.Id);
        insert section;

        FieloCMS__Section__c subsection = new FieloCMS__Section__c( FieloCMS__Parent__c = section.Id);
        insert subsection;

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsection.Id, FieloCMS__ComponentLibrary__c = componentLibrary1.id );
        insert component1;

        try{
			FieloCMSPLT_ShoppingCartCtrl.checkout(component1.Id, '{}');
        }catch(Exception e){}
	}
	
}