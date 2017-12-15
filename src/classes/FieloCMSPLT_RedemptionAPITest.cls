@isTest

private class FieloCMSPLT_RedemptionAPITest {

    @isTest
    static void testGetComponent(){
        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert component1;
        
        FieloCMSPLT_RedemptionAPI c = new FieloCMSPLT_RedemptionAPI();
        System.assertNotEquals(c.getComponent(component1), null);
    }
}