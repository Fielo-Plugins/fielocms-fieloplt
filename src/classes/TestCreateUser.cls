@isTest
private class TestCreateUser
{
	@isTest
	static void itShould(){
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

    @isTest
    static void testInstallScript(){
        //Inserto un par de programas
        List<FieloAlpha__Program__c> programs = new List<FieloAlpha__Program__c>();
        programs.add(new FieloAlpha__Program__c(Name = 'Test Program 1', FieloAlpha__Default__c = true));
        programs.add(new FieloAlpha__Program__c(Name = 'Test Program 2', FieloAlpha__Default__c = false));
        insert programs;
        //Corro al script de instalación
        PackageInstallation installScript = new PackageInstallation();
        Test.testInstall(installScript, null);

        //Ahora verifico que se hayan creado los segmentos públicos y privados
        List<FieloAlpha__RedemptionRule__c> segments = [SELECT RecordType.DeveloperName, FieloAlpha__Program__c FROM FieloAlpha__RedemptionRule__c WHERE FieloAlpha__Program__c IN : programs AND (RecordType.DeveloperName = 'Private' OR RecordType.DeveloperName = 'Public') ORDER BY FieloAlpha__Program__r.Name, RecordType.DeveloperName];

        System.assertEquals(segments[0].FieloAlpha__Program__c, programs[0].Id);//que pertenezca al primer programa
        System.assertEquals(segments[1].FieloAlpha__Program__c, programs[0].Id);//que pertenezca al primer programa
        System.assertEquals(segments[0].RecordType.DeveloperName, 'Private');//que sea el segmento Private
        System.assertEquals(segments[1].RecordType.DeveloperName, 'Public');//que sea el segmento Public
        System.assertEquals(segments[2].FieloAlpha__Program__c, programs[1].Id);//que pertenezca al primer programa
        System.assertEquals(segments[3].FieloAlpha__Program__c, programs[1].Id);//que pertenezca al primer programa
        System.assertEquals(segments[2].RecordType.DeveloperName, 'Private');//que sea el segmento Private
        System.assertEquals(segments[3].RecordType.DeveloperName, 'Public');//que sea el segmento Public

    }

}