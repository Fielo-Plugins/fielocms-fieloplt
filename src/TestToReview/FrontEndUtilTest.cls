/**
* @author Leonardo Teren
* @date Fecha de creacion
* @description description of the class
*/
@isTest
private class FrontEndUtilTest {

    @isTest(seeAllData=false) static void testCategories(){
        //creates a member
        MockUpFactory.setcustomProperties(false);
        Member__c member ;
        try{
            member = MockUpFactory.createMember('Test', 'Passport', '445364565');
        }catch(Exception  ex){
            member = [SELECT Id, User__c FROM Member__c limit 1];
        }

        Category__c cat = new Category__c(Name = 'cat', Order__c = 0);
        Category__c cat1 = new Category__c(Name = 'cat1', Order__c = 1);
        Category__c cat2 = new Category__c(Name = 'cat2', Order__c = 2);
        insert new List<Category__c>{cat, cat1, cat2};

        Category__c cat3 = new Category__c(Name = 'cat3', Order__c = 3, Category__c = cat2.Id);
        insert cat3;

        List<String> fieldSet = new List<String>{'Id', 'Name', 'Category__c', 'Order__c'};
        Id parentId = cat2.Id;

        CategoriesController controller = new CategoriesController();

        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});

        /*User user = [SELECT Id FROM User WHERE Id =: member.User__c];
        system.runAs(user){
            System.assertEquals(4, FrontEndUtil.getCategories(fieldSet, null, program.Id).size());

            System.assertEquals(1, FrontEndUtil.getCategories(fieldSet, parentId, program.Id).size());
        }*/
    }

    @isTest(seeAllData=false) static void testBanners(){
        MockUpFactory.setcustomProperties(false);
        MockUpFactory.setupComponentLibrary();

        //define fieldset
        List<String> fieldSet = new List<String>{'Id', 'Name', 'Placement__c'};

        //creates a category
        Category__c cat = new Category__c(Name = 'cat', Order__c = 0);
        insert cat;

        //creates a member
        Member__c member ;
        try{
            member = MockUpFactory.createMember('Test', 'Passport', '445364565');
        }catch(Exception  ex){
            member = [SELECT Id, User__c FROM Member__c limit 1];
        }

        //creates a menu
        Page__c menu = new Page__c(Name = 'test');
        insert menu;

        //creates a component
        RecordType rt = [SELECT ID FROM RecordType WHERE DeveloperName = 'Banner'];
        Component__c comp = new Component__c(RecordTypeId = rt.Id, Page__c = menu.Id, ComponentReference__c = 'Banner');
        insert comp;

        //creates a banner
        Banner__c ban = new Banner__c(Name = 'testBanner', Placement__c = 'Home', Component__c = comp.Id, Category__c = cat.Id);
        insert ban;

        //creates a tag
        Tag__c tag = new Tag__c(Name = 'testTag');
        insert tag;
        TagItem__c tagItem = new TagItem__c(Tag__c = tag.Id , Banner__c = ban.Id);
        insert tagItem;

        //attachs an image to the banner
        Attachment attachment = new Attachment();
        attachment.body = Blob.valueOf( 'this is an attachment test' );
        attachment.name = 'fake attachment';
        attachment.parentId = ban.id;
        insert attachment;

        //activate the banner
        ban.AttachmentId__c = attachment.Id;
        ban.IsActive__c = true;
        update ban;

        /*User user = [SELECT Id FROM User WHERE Id =: member.User__c];

        system.runAs(user){
            FrontEndUtil.getBanners(fieldSet, null, null, null, null, null, null, null);

            FrontEndUtil.getBanners(fieldSet, null, comp.Id, cat.Id, tag.Id, 1, null, null);
        }*/
    }

    @isTest(seeAllData=false) static void testNews(){
        //creates a member
        MockUpFactory.setcustomProperties(false);
        MockUpFactory.setupComponentLibrary();
        Member__c member ;
        try{
            member = MockUpFactory.createMember('Test', 'Passport', '445364565');
        }catch(Exception  ex){
            member = [SELECT Id, User__c FROM Member__c limit 1];
        }

        List<String> fieldSet = new List<String>{'Id', 'Name', 'Body__c'};

        //creates a menu
        Page__c menu = new Page__c(Name = 'test');
        insert menu;

        Category__c cat3 = new Category__c(Name = 'cat3', Order__c = 3);
        insert cat3;

        //creates a component
        RecordType rt = [SELECT ID FROM RecordType WHERE DeveloperName = 'ContentFeed'];
        Component__c comp = new Component__c(RecordTypeId = rt.Id, Page__c = menu.Id, ComponentReference__c = 'ContentFeed');
        insert comp;

        News__c news = new News__c(isActive__c = true, Component__c = comp.Id, Order__c = 1);
        insert news;

        //creates a tag
        Tag__c tag = new Tag__c(Name = 'testTag');
        insert tag;
        TagItem__c tagItem = new TagItem__c(Tag__c = tag.Id , News__c = news.Id);
        insert tagItem;

        /*User user = [SELECT Id FROM User WHERE Id =: member.User__c];
        system.runAs(user){
            FrontEndUtil.getNews(fieldSet, comp.Id, null, tag.Id, cat3.Id, null, null, ' Order__c ASC, PublishDate__c ASC ');
        }*/
    }

}