/**
* @author Agustín Gallardo
* @date 28/05/2013
* @description Class to test the Component Trigger
**/
@isTest
private class ComponentTriggerTest{

    /**
    * @author Agustín Gallardo
    * @date 28/05/2013
    * @description Method that tests the order assignment of the components.
    **/
    @isTest(seeAllData=false) static void orderTest(){
        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Page__c menu = new Page__c(name = 'test');
        insert menu;

        List<Component__c> components = new List<Component__c>();
        for(Integer i = 0; i < 5; i++){
            Component__c comp = new Component__c(Page__c = menu.id, ComponentReference__c = 'Banner');
            components.add(comp);
        }
        insert components;

        components = [SELECT id, Order__c FROM Component__c ORDER BY Order__c];
        for(Integer i = 0; i < 5; i++){
            //system.assertEquals(i, components[i].Order__c);TODO: chequear el orden de los componentes
        }
    }

    /**
    * @author Agustín Gallardo
    * @date 28/05/2013
    * @description Method to test the fieldSet assignment of the components.
    **/
    @isTest(seeAllData=false) static void fieldSetTest(){
        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Page__c menu = new Page__c(name = 'test');
        insert menu;

        Schema.DescribeSObjectResult r = Component__c.sObjectType.getDescribe();
        Map<Id,Schema.RecordTypeInfo> recordTypesMap = r.getRecordTypeInfosById();
        RecordType rtProfile = [SELECT Id FROM RecordType WHERE DeveloperName = 'DetailForm'];
        RecordType rtNews = [SELECT Id FROM RecordType WHERE DeveloperName = 'ContentFeed'];

        List<Component__c> components = new List<Component__c>();
        components.add(new Component__c(Page__c = menu.id, RecordTypeId = rtProfile.Id, ComponentReference__c = 'Account'));
        components.add(new Component__c(Page__c = menu.id, RecordTypeId = rtNews.Id, ComponentReference__c = 'ContentFeed'));
        insert components;

        Map<Id,Component__c> componentsMap = new Map<Id,Component__c>([SELECT Id, FieldSet__c, FieldSet2__c FROM Component__c WHERE Page__c =: menu.Id]);

        /*system.assertEquals('FirstName__c,LastName__c,LevelReadOnly__c,Street__c,City__c,State__c,Country__c,Phone__c', componentsMap.get(components[0].Id).FieldSet__c);
        system.assertEquals('Title__c,PublishDate__c', componentsMap.get(components[1].Id).FieldSet__c);
        system.assertEquals('Title__c,Body__c', componentsMap.get(components[1].Id).FieldSet2__c);*/
    }
}