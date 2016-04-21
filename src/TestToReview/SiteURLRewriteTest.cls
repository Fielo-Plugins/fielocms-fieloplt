@isTest
private class SiteURLRewriteTest {

	@isTest(seeAllData=false) public static void testMenu() {
		MockUpFactory.setCustomProperties(false);
        Page__c m = new Page__c(Name = 'test', ExternalName__c = 'test');
        insert m;
        SiteURLRewrite controller = new SiteURLRewrite();

        PageReference inUrl = new PageReference('/Menu/test');
        inUrl.getParameters().put('testPar','test');
        controller.mapRequestUrl(inUrl);

        PageReference outUrl = new PageReference('/Page');
        outUrl.getParameters().put('idMenu', m.Id);
        outUrl.getParameters().put('testPar', 'test');
        controller.generateUrlFor(new List<PageReference>{outUrl});
	}

    @isTest(seeAllData=false) public static void testReward() {
        MockUpFactory.setCustomProperties(false);
        Reward__c r = new Reward__c(Name = 'test', ExternalName__c = 'test', PointsCant__c = 10);
        insert r;
        SiteURLRewrite controller = new SiteURLRewrite();

        PageReference inUrl = new PageReference('/Reward/test');
        inUrl.getParameters().put('testPar','test');
        controller.mapRequestUrl(inUrl);

        PageReference outUrl = new PageReference('/RewardView');
        outUrl.getParameters().put('id', r.Id);
        outUrl.getParameters().put('testPar', 'test');
        controller.generateUrlFor(new List<PageReference>{outUrl});
    }

    @isTest(seeAllData=false) public static void testNews() {
        MockUpFactory.setCustomProperties(false);
        News__c n = new News__c(ExternalName__c = 'test');
        insert n;
        SiteURLRewrite controller = new SiteURLRewrite();

        PageReference inUrl = new PageReference('/ContentFeed/test');
        inUrl.getParameters().put('testPar','test');
        controller.mapRequestUrl(inUrl);

        PageReference outUrl = new PageReference('/NewsView');
        outUrl.getParameters().put('id', n.Id);
        outUrl.getParameters().put('testPar', 'test');
        controller.generateUrlFor(new List<PageReference>{outUrl});
    }

    @isTest(seeAllData=false) public static void testLogout() {
        MockUpFactory.setCustomProperties(false);
        SiteURLRewrite controller = new SiteURLRewrite();
        PageReference outUrl = new PageReference('/Logout');
        List<PageReference> listas = new List<PageReference>();
        listas.add(outUrl);
        listas.add( new PageReference('/NewPage') );
        controller.generateUrlFor(listas);
    }
}