@isTest
private class FieloCMSPLT_LoginAsCtrlTest {

    @isTest static void validLogin() {
        //comentado porque ahora 
        //crate new member with user
        // FieloCMSPLT_MockUpFactory.setCustomProperties(false);
		Profile p = [select id, name, UserType, UserLicense.Name from profile where UserType = 'Standard' limit 1];
	    User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='plugintest@fielo.com', isActive = true);
	    insert u;

        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;

        FieloPLT__Member__c member = new FieloPLT__Member__c( Name = 'test member', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.id, FieloPLT__User__c = u.id);
        insert member;

        //get custom setting and set a valid hash and expiration date
        SessionCache__c fe = SessionCache__c.getInstance(u.Id);
        fe.FieloCMSPLT_Hash__c = 'testHash';
        fe.FieloCMSPLT_ExpirationDate__c = System.now().addMinutes(5);
        upsert fe;

        FieloCMSPLT_LoginAsCtrl controller = new FieloCMSPLT_LoginAsCtrl();
        system.currentPageReference().getParameters().put('testUser',u.Id);
        system.currentPageReference().getParameters().put('hash','testHash');
        controller.login();
    }

    @isTest static void invalidLogin() {
        //comentado porque ahora el usuario se crea por front end
        //crate new member with user
        //FieloCMSPLT_MockUpFactory.setCustomProperties(false);
		Profile p = [select id, name, UserType, UserLicense.Name from profile where UserType = 'Standard' limit 1];
	    User u = new User(Alias = 'standt', Email='test@fielo.com', EmailEncodingKey='UTF-8', LastName='Testing',LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='plugintest@fielo.com', isActive = true);
	    insert u;

        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;

        FieloPLT__Member__c member = new FieloPLT__Member__c( Name = 'test member', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.id, FieloPLT__User__c = u.id);
        insert member;

        FieloCMSPLT_LoginAsCtrl controller = new FieloCMSPLT_LoginAsCtrl();
        system.currentPageReference().getParameters().put('testUser',u.Id);     
        controller.login();
    }
    
}