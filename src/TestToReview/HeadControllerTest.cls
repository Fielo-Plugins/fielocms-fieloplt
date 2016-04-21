/**
* @author Leonardo Teren
* @date 29/12/2014
* @description Test Class for HeadController
*/
@isTest
public with sharing class HeadControllerTest {
	@isTest(seeAllData=false) static void testHead1(){
		MockUpFactory.setCustomProperties(false);

		HeadController controller = new HeadController();
		controller.contentValue = 'advanced-html-general';
		String headValue = controller.head;
	}

	@isTest(seeAllData=false) static void testHead2(){
		MockUpFactory.setCustomProperties(false);
		
		HeadController controller = new HeadController();
		controller.contentValue = 'advanced-html-layout';
		String headValue = controller.head;
	}

	@isTest(seeAllData=false) static void testHead3(){
		MockUpFactory.setCustomProperties(false);
		Site__c p = [SELECT Id FROM Site__c];
		p.CustomPage__c = 'CustomPage';
		update p;
		Page__c home = new Page__c (Home__c = true);
		insert home;
		HeadController controller = new HeadController();
		controller.contentValue = 'seo-title';
		String headValue = controller.head;
	}

	@isTest(seeAllData=false) static void testHead4(){
		MockUpFactory.setCustomProperties(false);
		Page__c home = new Page__c (Home__c = true);
		insert home;
		ApexPages.currentPage().getParameters().put('idMenu', home.Id);
		HeadController controller = new HeadController();
		controller.contentValue = 'seo-description';
		String headValue = controller.head;
	}

	@isTest(seeAllData=false) static void testHead5(){
		MockUpFactory.setCustomProperties(false);

		Page__c home = new Page__c (Home__c = true);
		insert home;
		ApexPages.currentPage().getParameters().put('idMenu', home.Id);
		HeadController controller = new HeadController();
		controller.contentValue = 'seo-keywords';
		String headValue = controller.head;
	}

	@isTest(seeAllData=false) static void testHead6(){
		MockUpFactory.setCustomProperties(false);
		Site__c p = [SELECT Id FROM Site__c];
		p.CustomPage__c = 'CustomPage';
		update p;
		Page__c home = new Page__c (Home__c = true);
		insert home;
		ApexPages.currentPage().getParameters().put('idMenu', home.Id);
		HeadController controller = new HeadController();
		controller.contentValue = 'seo-title';
		String headValue = controller.head;
	}
}