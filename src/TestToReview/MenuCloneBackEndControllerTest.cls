/**
* @author Agustín Gallardo
* @date 11/10/2014
* @description Class to test the menuCloneBackEndController
*/
@isTest
private class MenuCloneBackEndControllerTest {

        @isTest static void test_method_one() {

        //Create a member, a menu, subMenu, Sections and some components

        MockUpFactory.setCustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Apexpages.currentPage().getParameters().put('parameterMenuTest', 'test');
        //first menu creation
        Page__c menu1 = new Page__c(Name = 'test menu 1', Home__c = true, Visibility__c ='Both', Placement__c = 'Main');
        insert menu1;

        //second menu creation
        Page__c menu2 = new Page__c(Name = 'test menu 2', Home__c = true, Visibility__c ='Both', Placement__c = 'Main');
        insert menu2;

        //first subMenu creation
        Page__c subMenu1 = new Page__c(Name = 'test subMenu 1', Home__c = true, Visibility__c ='Both', Placement__c = 'Main', Page__c = menu1.Id);
        insert subMenu1;

        //second subMenu creation
        Page__c subMenu2 = new Page__c(Name = 'test subMenu 2', Home__c = true, Visibility__c ='Both', Placement__c = 'Main', Page__c = menu2.Id);
        insert subMenu2;

        //first menu sections
        Section__c section1 = new Section__c(Page__c = menu1.Id, Width__c = '12');
        insert section1;
        Section__c section2 = new Section__c(Page__c = menu1.Id, Width__c = '12', Parent__c = section1.Id);
        insert section2;
        Section__c section3 = new Section__c(Page__c = menu1.Id, Width__c = '12', Parent__c = section1.Id);
        insert section3;
        Component__c compBanner1 = new Component__c(Section__c = section2.Id, Page__c = menu1.Id);

        //second menu sections
        Section__c section4 = new Section__c(Page__c = menu2.Id, Width__c = '12');
        insert section4;
        Section__c section5 = new Section__c(Page__c = menu2.Id, Width__c = '12', Parent__c = section4.Id);
        insert section5;
        Section__c section6 = new Section__c(Page__c = menu2.Id, Width__c = '12', Parent__c = section4.Id);
        insert section6;
        Component__c compBanner2 = new Component__c(Section__c = section5.Id, Page__c = menu2.Id, ComponentReference__c = 'Banner');

        //first menu components settings
        compBanner1.Mobile__c = true;
        compBanner1.Tablet__c = false;
        compBanner1.Desktop__c = false;
        insert compBanner1;

        Component__c compNews1 = new Component__c(Section__c = section3.Id, Page__c = menu1.Id, ComponentReference__c = 'ContentFeed');

        compNews1.Mobile__c = true;
        compNews1.Tablet__c = false;
        compNews1.Desktop__c = false;
        insert compNews1;

        //creates a content feed
        News__c news1 = new News__c(isActive__c = true, Component__c = compNews1.Id);
        insert news1;

        //creates a banner
        Banner__c ban1 = new Banner__c(Name = 'testBanner1', Placement__c = 'Home', Component__c = compBanner1.Id);
        insert ban1;

        //creates a banner with the /banner/top.jpg attachment, to simulate mockupBanner
        /*Banner__c ban2 = new Banner__c(Name = 'testBanner2', Placement__c = 'Home', Component__c = compBanner1.Id, attachmentId__c = '/banner/top.jpg', IsActive__c = true);
        insert ban2;*/

        //attachs an image to the banner
        Attachment attachment1 = new Attachment();
        attachment1.body = Blob.valueOf( 'this is an attachment test' );
        attachment1.name = 'fake attachment';
        attachment1.parentId = ban1.id;
        insert attachment1;

        //activate the banner
        ban1.AttachmentId__c = attachment1.Id;
        ban1.IsActive__c = true;
        update ban1;

        //second menu components settings
        compBanner2.Mobile__c = true;
        compBanner2.Tablet__c = false;
        compBanner2.Desktop__c = false;
        insert compBanner2;

        Component__c compNews2 = new Component__c(Section__c = section3.Id, Page__c = menu1.Id, ComponentReference__c = 'ContentFeed');

        compNews2.Mobile__c = true;
        compNews2.Tablet__c = false;
        compNews2.Desktop__c = false;
        insert compNews2;

        //creates a content feed
        News__c news2 = new News__c(isActive__c = true, Component__c = compNews2.Id);
        insert news2;

        //creates a banner
        Banner__c ban3 = new Banner__c(Name = 'testBanner3', Placement__c = 'Home', Component__c = compBanner2.Id);
        insert ban3;

        //creates a banner with the /banner/top.jpg attachment, to simulate mockupBanner
        /*Banner__c ban4 = new Banner__c(Name = 'testBanner4', Placement__c = 'Home', Component__c = compBanner2.Id, attachmentId__c = '/banner/top.jpg', IsActive__c = true);
        insert ban4;*/

        //attachs an image to the banner
        Attachment attachment2 = new Attachment();
        attachment2.body = Blob.valueOf( 'this is an attachment test' );
        attachment2.name = 'fake attachment';
        attachment2.parentId = ban3.id;
        insert attachment2;

        //activate the banner
        ban3.AttachmentId__c = attachment2.Id;
        ban3.IsActive__c = true;
        update ban3;

        //create a memory clone of the first menu
        Page__c menu1Clone = menu1.clone(false, true, false, false);

        //insert the clone
        insert menu1Clone;

                ApexPages.currentPage().getParameters().put('newId', menu1Clone.Id);
                ApexPages.currentPage().getParameters().put('menuId', menu1.Id);

                MenuCloneBackEndController controller = new MenuCloneBackEndController();

                controller.cloneMenuChilds();
        }

}