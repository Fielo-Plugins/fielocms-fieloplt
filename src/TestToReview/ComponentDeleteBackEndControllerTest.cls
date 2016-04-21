/**
* @author Agustín Gallardo
* @date 29/10/2014
* @description Class used to test ComponentDeleteBackEndController. Creates components and deletes them.
*/
@isTest
private class ComponentDeleteBackEndControllerTest
{
    /**
    * @author Agustín Gallardo
    * @date 29/10/2014
    * @description save level and criteria
    * @return PageReference
    */
    @isTest(seeAllData=false)
    static void unitTest()
    {
        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        List<Component__c> compList = [SELECT id FROM Component__c];
        Integer numberOfComponents = compList.size();

        Page__c menu = new Page__c(Name = 'test' );
        insert menu;

        Section__c section = new Section__c(Page__c = menu.Id, Width__c = '12');
        insert section;

        Component__c comp1 = new Component__c();
        comp1.Page__c = menu.Id;
        comp1.Section__c = section.Id;
        comp1.Name = 'testComponent_1';
        comp1.ComponentReference__c = 'Banner';
        insert comp1;

        Component__c comp2 = new Component__c();
        comp2.Page__c = menu.Id;
        comp2.Section__c = section.Id;
        comp2.Name = 'testComponent_2';
        comp1.ComponentReference__c = 'Banner';
        insert comp2;

        System.assert( [SELECT id FROM Component__c].size() == (numberOfComponents + 2));

        String cancelURL = comp1.Id + 'menuId' + menu.Id;
        ApexPages.currentPage().getParameters().put('cId', cancelURL);

        ComponentDeleteBackEndController controller = new ComponentDeleteBackEndController();
        controller.deleteComponents();

        ApexPages.currentPage().getParameters().put('cId', comp2.Id);
        ComponentDeleteBackEndController controller2 = new ComponentDeleteBackEndController();
        controller2.deleteComponents();

        compList = [SELECT id FROM Component__c];

        System.assert([SELECT id FROM Component__c].size() == numberOfComponents);
    }
}