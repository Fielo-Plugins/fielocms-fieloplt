/**
* @author Alejandro Ferrante
* @date 29/05/2013
* @description Class to test the MenuViewBackEndExtensions
*/
@isTest
private class MenuViewBackEndExtensionsTest {

    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description Class to test the methods
    */
    @isTest(seeAllData=false) public static void unitTest(){
        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Page__c menu = new Page__c();
        insert menu;

        ApexPages.StandardController stdController = new ApexPages.StandardController(menu);
        MenuViewBackEndExtensions menuController = new MenuViewBackEndExtensions(stdController);

        ApexPages.currentPage().getParameters().put('section','12');
        menuController.createSection();

        Section__c s = [SELECT Id FROM Section__c WHERE Page__c =: menu.Id limit 1];
        ApexPages.currentPage().getParameters().put('sectionId',s.Id);
        menuController.deleteSection();

        ApexPages.currentPage().getParameters().put('section','12');
        menuController.createSection();
        Section__c s2 = [SELECT Id FROM Section__c WHERE Page__c =: menu.Id limit 1];

        ApexPages.currentPage().getParameters().put('sectionId',s2.Id);
        String sObjectType = OrganizationUtil.hasPrefix() ? OrganizationUtil.getPrefixUnderScore() + 'Component__c' : 'Component__c';
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE sObjectType =: sObjectType AND IsActive = true limit 1];
        ApexPages.currentPage().getParameters().put('rtName',rt.Name);
        ApexPages.CurrentPage().getParameters().put('ceName', 'Banner');
        menuController.createComponent();

        Component__c c = [SELECT Id FROM Component__c WHERE Section__c =: s2.Id limit 1];
        ApexPages.currentPage().getParameters().put('componentId',c.Id);
        ApexPages.currentPage().getParameters().put('desktopValue','false');
        menuController.changeAttributes();
        ApexPages.currentPage().getParameters().put('tabletValue','false');
        menuController.changeAttributes();
        ApexPages.currentPage().getParameters().put('mobileValue','false');
        menuController.changeAttributes();

        ApexPages.currentPage().getParameters().put('componentId',c.Id);
        menuController.deleteComponent();
    }
}