/**
* @author Leonardo Teren
* @date 29/12/2014
* @description Class to test the ProgramFieldSetMenuExtension
*/
@isTest
public with sharing class ProgramFieldSetMenuExtensionTest {
	/**
	* @author Leonardo Teren
	* @date 29/12/2014
	* @description Class to test the methods
	*/
    @isTest(seeAllData=false) public static void unitTest(){
    	MockUpFactory.setCustomProperties(false);
    	Site__c program = [SELECT Id FROM Site__c];
    	ApexPages.StandardController stdController = new ApexPages.StandardController(program);
		ProgramFieldSetMenuExtension controller = new ProgramFieldSetMenuExtension(stdController);
		controller.doCancel();
		controller.doSave();
    }
}