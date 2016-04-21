/**
* @author Alejandro Spinelli
* @date   5/11/2012
* @description Controller for the cms page
*/

@isTest
private class PageControllerTest {

    /**
    * @author Alejandro Spinelli
    * @date   5/11/2012
    * @description Controller for the cms page
    */

    @isTest(seeAllData=false) public static void unitTest(){

        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();

        Page__c menu = new Page__c(Name = 'test', Home__c = true);
        insert menu;

        PageController controller = new PageController();


        Section__c section1 = new Section__c(Page__c = menu.Id, Width__c = '12');
        insert section1;
        Section__c section2 = new Section__c(Page__c = menu.Id, Width__c = '12', Parent__c = section1.Id);
        insert section2;
        Section__c section3 = new Section__c(Page__c = menu.Id, Width__c = '12', Parent__c = section1.Id);
        insert section3;
        Component__c c = new Component__c(Section__c = section2.Id, Page__c = menu.Id, ComponentReference__c = 'Banner');
        c.Mobile__c = true;
        c.Tablet__c = false;
        c.Desktop__c = false;
        insert c;


        ApexPages.currentPage().getParameters().put('idMenu', menu.Id);

        PageController controller2 = new PageController();


        c.Mobile__c = false;
        c.Tablet__c = true;
        c.Desktop__c = false;
        update c;
        PageController controller3 = new PageController();

        c.Mobile__c = false;
        c.Tablet__c = false;
        c.Desktop__c = true;
        update c;
        PageController controller4 = new PageController();

        c.Mobile__c = true;
        c.Tablet__c = true;
        c.Desktop__c = false;
        update c;
        PageController controller5 = new PageController();

        c.Mobile__c = true;
        c.Tablet__c = false;
        c.Desktop__c = true;
        update c;
        PageController controller6 = new PageController();

        c.Mobile__c = false;
        c.Tablet__c = true;
        c.Desktop__c = true;
        update c;
        PageController controller7 = new PageController();

        c.Mobile__c = false;
        c.Tablet__c = false;
        c.Desktop__c = false;
        update c;
        PageController controller8 = new PageController();

    }
}