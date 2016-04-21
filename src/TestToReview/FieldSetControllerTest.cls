/**
* @author Agustín Gallardo
* @date 28/01/2015
* @description Test para la clase FieldSetController
*/
@isTest
private class FieldSetControllerTest {


    @isTest(SeeAllData=False) static void unitTest() {
        MockUpFactory.setCustomProperties(false);

        Page__c menu = new Page__c(Name = 'test');
        insert menu;
        Component__c component = new Component__c(Fieldset__c = '[{"label":"Reward Name","apiName":"Name","type":"Text","maxLength":"80","readOnly":"false","isCalculated":"false","required":"false","isNillable":"true","multiLanguage":"false","linkToDetail":"false"}]', ComponentReference__c = 'Catalog', Page__c = menu.Id);
        insert component;

        FieldSetController controller = new FieldSetController();

        controller.componentId = component.Id;
		controller.objectName = OrganizationUtil.getPrefixUnderScore()+'Component__c';

        List<Field> activeFields = controller.activeFields;

        controller.saveAndExit();

    }
}