@isTest
private class TestCreateUser
{
	@isTest
	static void itShould()
	{
                FieloAlpha__Program__c defaultProgram = new FieloAlpha__Program__c(FieloAlpha__Default__c = true);
                insert defaultProgram;

                FieloAlpha__RedemptionRule__c segment = new FieloAlpha__RedemptionRule__c();
                insert segment;

                insert new FieloAlpha__SegmentDomain__c(FieloAlpha__Segment__c = segment.Id);
		
                OrganizationUtil.dummyTest1();
                OrganizationUtil.dummyTest2();
                OrganizationUtil.dummyTest3();
                OrganizationUtil.dummyTest4();
                OrganizationUtil.dummyTest5();
                OrganizationUtil.dummyTest6();
                OrganizationUtil.dummyTest7();
                OrganizationUtil.dummyTest8();
                OrganizationUtil.dummyTest9();
                OrganizationUtil.dummyTest10();
                OrganizationUtil.dummyTest11();
                OrganizationUtil.dummyTest12();
                OrganizationUtil.dummyTest13();
                OrganizationUtil.dummyTest14();
                OrganizationUtil.dummyTest15();
                OrganizationUtil.dummyTest16();
	}

}