@isTest


private class FieloCMSPLT_RewardAPITest{

    @isTest
    static void testGetBulk(){
        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        component1.FieloCMS__FieldSet__c= '[{"showLabel":true,"label":"Code","apiName":"Name","type":"STRING"}]';        
        insert component1;
        
        FieloCMSPLT_RewardAPI c = new FieloCMSPLT_RewardApi();
        try { 
            c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
            c.getData( component1 , 0, null, null );
        } catch( Exception e ) {}     
    }
    
}