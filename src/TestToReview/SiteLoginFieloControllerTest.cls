@isTest
private class SiteLoginFieloControllerTest {

    @isTest(seeAllData=false) static void testSiteLoginController () {
        MockUpFactory.deactivateUsers();

        SiteLoginFieloController controller = new SiteLoginFieloController ();
        User u1 = MockUpFactory.createRoleUser();

        system.runAs(u1){
            //TODO corregir test con el query de profile
            MockUpFactory.setCustomProperties(false);
            ID ProfileID = [SELECT Id FROM Profile WHERE name =: SiteUtil.getDefaultProgram().SiteProfile__c].id;
            Account A1 = new Account(Name = 'Test Account');
            insert A1;
            Contact C1 = new Contact( AccountID = A1.id, FirstName = 'Test2', LastName = 'User2', email = 'test-user2@fakeemail.com' );
            insert C1;

            User u2 = new User( email='test-use2r@fakeemail.com', contactid = c1.id, profileid = profileid,
                    UserName='test-user2@fakeemail.com', alias='tuser2', CommunityNickName='tuser2',
                    TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',
                    LanguageLocaleKey='en_US', FirstName = 'Test2', LastName = 'User2', isActive = false);
            insert u2;

            //inactive the user
            u2.isActive = false;
            update u2;

            //Test case user inactive
            controller.username = 'test-user2@fakeemail.com';
            controller.login();
            //system.assertNotEquals(null,controller.login());

            //Test case usuario active
            controller.username = 'test-user2@fakeemail.com';
            controller.password = '123456';
            //system.assertEquals(null,controller.login());
        }
    }

    //CASO REDIRECT DEPRECATED
    @isTest(seeAllData=false) static void testSiteLoginController2 () {
        PageReference pageRef = new PageReference('http://loyalty-developer-edition.na7.force.com/');
        System.Test.setCurrentPage(pageRef);

        SiteLoginFieloController controller = new SiteLoginFieloController ();
        system.assertEquals(null, controller.redirect());
    }
}