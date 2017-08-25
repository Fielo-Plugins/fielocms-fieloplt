@isTest


private class FieloCMSPLT_MemberAPITest{

    @isTest
    static void testGetBulk(){
        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert component1;
        
        FieloCMSPLT_MemberAPI c = new FieloCMSPLT_MemberApi();
        c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
        c.getData( component1 , 0, null, null );
    }

    @isTest
    static void test2(){
        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert component1;
        
        FieloCMSPLT_MemberAPI c = new FieloCMSPLT_MemberApi();
        c.getComponent(component1);


        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = programId, FieloPLT__User__c = UserInfo.getUserId());
        insert member;
        c.remoteComponentAction(component1, member, '');

        Account a = new Account(Name = 'Fielo');
        insert a;
        FieloPLT__Member__c orgAccount = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = programId, FieloPLT__Type__c = 'Organization Account', FieloPLT__Account__c = a.Id);
        insert orgAccount;
        FieloPLT__Member__c contributor = new FieloPLT__Member__c(Name = 'test123', FieloPLT__Email__c = 'test123@fielo.com', FieloPLT__Program__c = programId, FieloPLT__Type__c = 'Organization contributor', FieloPLT__OrganizationAccount__c = orgAccount.Id);
        insert contributor;
        c.remoteComponentAction(component1, contributor, '');
    }
    
}