@isTest
private class SiteTemplateFieloControllerTest {
		
    @isTest(seeAllData=false) static void test(){
        MockUpFactory.setCustomProperties(false);
        Member__c member ;
            try{
                member = MockUpFactory.createMember('TestCodeTrigger','68943596790','Passport');                 
        }catch(Exception  ex){
                member = [SELECT Id, User__c FROM Member__c limit 1];
        }
        System.debug('DEBUG MEMBER: ' + member);
        User user = [SELECT Id, Name FROM User WHERE Id =: member.User__c];
        Agreement__c agreement = new Agreement__c(Status__c = 'Current');
        insert agreement;
        
        agreement = [SELECT Status__c FROM Agreement__c WHERE Id =: agreement.Id];
        agreement.Status__c = 'Current';
        update agreement;

        Site__c defaultProgram = SiteUtil.getDefaultProgram();
        defaultProgram.UseAgreement__c = true;
        update defaultProgram;
        
        system.runAs(user){
            SiteTemplateFieloController controller = new SiteTemplateFieloController();                            
            ApexPages.currentPage().getParameters().put('language','en_US');
            controller.getLanguage();
            controller.redirect();
            system.assertEquals(null,controller.getFontColor05bis());
        }
    }
    
    @isTest(seeAllData=false) static void testUserAgentSafari(){
        SiteTemplateFieloController controller = new SiteTemplateFieloController();                            
        ApexPages.currentPage().getParameters().put('language','en_US');
        controller.getLanguage();
        ApexPages.currentPage().getHeaders().put('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A');
        System.assertEquals('Safari', controller.browserName);
        System.assertEquals('Mac', controller.osName);
        //System.assertEquals('Other', controller.menuId);
    }

    @isTest(seeAllData=false) static void testUserAgentChrome(){
        SiteTemplateFieloController controller = new SiteTemplateFieloController();                            
        ApexPages.currentPage().getParameters().put('language','en_US');
        controller.getLanguage();
        ApexPages.currentPage().getHeaders().put('User-Agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36');
        System.assertEquals('Chrome', controller.browserName);
        System.assertEquals('Linux', controller.osName);
        //System.assertEquals('Other', controller.menuId);
    }

    @isTest(seeAllData=false) static void testUserAgentFirefox(){
        SiteTemplateFieloController controller = new SiteTemplateFieloController();                            
        ApexPages.currentPage().getParameters().put('language','en_US');
        controller.getLanguage();
        ApexPages.currentPage().getHeaders().put('User-Agent', 'Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0');
        System.assertEquals('Firefox', controller.browserName);
        System.assertEquals('Windows', controller.osName);
        //System.assertEquals('Other', controller.menuId);
    }

    @isTest(seeAllData=false) static void testUserAgentMSIE(){
        SiteTemplateFieloController controller = new SiteTemplateFieloController();                            
        ApexPages.currentPage().getParameters().put('language','en_US');
        controller.getLanguage();
        ApexPages.currentPage().getHeaders().put('User-Agent', 'Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko');
        System.assertEquals('MSIE', controller.browserName);
        System.assertEquals('Windows', controller.osName);
        //System.assertEquals('Other', controller.menuId);
    }

}