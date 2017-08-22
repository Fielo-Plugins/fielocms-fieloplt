@isTest


private class FieloCMSPLT_RedemptionItemAPITest{

    @isTest
    static void testGetBulk(){
        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        component1.FieloCMS__FieldSet__c= '[{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Delivery Date","apiName":"FieloPLT__DeliveredDate__c","type":"DATE"},{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Expiration Date","apiName":"FieloPLT__ExpirationDate__c","type":"DATE"},{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Reward Item","apiName":"FieloPLT__RewardItem__c","type":"REFERENCE"},{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Status","apiName":"FieloPLT__Status__c","type":"PICKLIST"},{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Unique Code","apiName":"FieloPLT__UniqueCode__c","type":"STRING"},{"linkToDetail":false,"orderBy":"disabled","showLabel":true,"label":"Voucher Link","apiName":"FieloCMSPLT_VoucherLink__c","type":"STRING"}]';
        insert component1;
        
        FieloCMSPLT_RedemptionItemAPI c = new FieloCMSPLT_RedemptionItemApi();
        try {
            c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
            c.getData( component1 , 0, null, null );
        } catch( Exception e ) {}     
    }
    
}