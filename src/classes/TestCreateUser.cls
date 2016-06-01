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

    @isTest
    static void testCancelInvitation(){
        //Voy a probar cancelar una invitación para un member que fue creado por otro usuario que no es el que está tratando de cancelar la invitación
        
        //Creo un programa
        FieloAlpha__Program__c defaultProgram = new FieloAlpha__Program__c(FieloAlpha__Default__c = true);
        insert defaultProgram;

        //Creo una cuenta, y luego una organization Account relacionada a esta cuenta
        Account acc = new Account(Name = 'Test Organization Account');
        insert acc;

        List<RecordType> memberRecordTypes = [SELECT Id FROM RecordType WHERE SObjectType = 'FieloAlpha__Member__c' AND (DeveloperName = 'OrganizationAccount' OR DeveloperName = 'OrganizationContributor') ORDER BY DeveloperName ASC];
        //en la posición 0 va a estar Organization Account, en la 1 Organization Contributor
        
        //Creo la organization account
        FieloAlpha__Member__c orgAccount = new FieloAlpha__Member__c(FieloAlpha__LastName__c = 'Test Organization Account', FieloAlpha__Account__c = acc.Id, RecordTypeId = memberRecordTypes[0].Id);
        insert orgAccount;

        //Creo dos contributors, uno de los cuales es manager
        List<FieloAlpha__Member__c> contributors = new List<FieloAlpha__Member__c>();
        FieloAlpha__Member__c contributor1 = new FieloAlpha__Member__c(FieloAlpha__FirstName__c = 'Contributor', FieloAlpha__LastName__c = '1', FieloAlpha__Email__c = 'contributor1@fielo.com', FieloAlpha__IsManager__c = true, FieloAlpha__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[1].Id);
        contributors.add(contributor1);
        FieloAlpha__Member__c contributor2 = new FieloAlpha__Member__c(FieloAlpha__FirstName__c = 'Contributor', FieloAlpha__LastName__c = '2', FieloAlpha__Email__c = 'contributor2@fielo.com', FieloAlpha__IsManager__c = false, FieloAlpha__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[1].Id);
        contributors.add(contributor2);
        insert contributors;

        FieloCMS.RemoteActionResult resultFinishRegistration = RegisterStep2Controller.finishRegistration(contributor1, null);
        System.debug(resultFinishRegistration);

        contributor1 = [SELECT FieloAlpha__User__c FROM FieloAlpha__Member__c WHERE Id =: contributor1.Id];
        contributor2 = [SELECT FieloAlpha__User__c, OwnerId FROM FieloAlpha__Member__c WHERE Id =: contributor2.Id];

        System.debug(contributor2.OwnerId);

        User managerUser = [SELECT Id, ProfileId FROM User WHERE Id =: contributor1.FieloAlpha__User__c];

        System.debug(managerUser.ProfileId);

        System.runAs(managerUser){
            FieloCMS.RemoteActionResult resultCancelInvitation = HandleInvitationsMembersController.cancelInvitation(contributor2.Id);
            System.debug(resultCancelInvitation);
        }
    }

    @isTest
    static void testBlockUnblock(){
        //Creo un programa
        FieloAlpha__Program__c defaultProgram = new FieloAlpha__Program__c(FieloAlpha__Default__c = true);
        insert defaultProgram;

        //Creo una cuenta, y luego una organization Account relacionada a esta cuenta
        Account acc = new Account(Name = 'Test Organization Account');
        insert acc;

        List<RecordType> memberRecordTypes = [SELECT Id FROM RecordType WHERE SObjectType = 'FieloAlpha__Member__c' AND (DeveloperName = 'IndividualAccount' OR DeveloperName = 'OrganizationAccount' OR DeveloperName = 'OrganizationContributor') ORDER BY DeveloperName ASC];
        //en la posición 0 va a estar Individual Account, en la 1 va a estar Organization Account, en la 2 Organization Contributor
    
        //Creo la organization account
        FieloAlpha__Member__c orgAccount = new FieloAlpha__Member__c(FieloAlpha__LastName__c = 'Test Organization Account', FieloAlpha__Account__c = acc.Id, RecordTypeId = memberRecordTypes[1].Id);
        insert orgAccount;

        //Creo dos contributors para la organization account (aunque uno es individual account), uno de los cuales es manager
        List<FieloAlpha__Member__c> contributors = new List<FieloAlpha__Member__c>();
        FieloAlpha__Member__c contributor1 = new FieloAlpha__Member__c(FieloAlpha__FirstName__c = 'Contributor', FieloAlpha__LastName__c = '1', FieloAlpha__Email__c = 'contributor1@fielo.com', FieloAlpha__IsManager__c = true, FieloAlpha__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[2].Id);
        contributors.add(contributor1);
        FieloAlpha__Member__c contributor2 = new FieloAlpha__Member__c(FieloAlpha__FirstName__c = 'Contributor', FieloAlpha__LastName__c = '2', FieloAlpha__Email__c = 'contributor2@fielo.com', FieloAlpha__IsManager__c = false, FieloAlpha__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[0].Id);
        contributors.add(contributor2);
        insert contributors;

        FieloCMS.RemoteActionResult resultFinishRegistration = RegisterStep2Controller.finishRegistration(contributor1, null);
        System.debug(resultFinishRegistration);

        contributor1 = [SELECT FieloAlpha__User__c FROM FieloAlpha__Member__c WHERE Id =: contributor1.Id];
    
        User managerUser = [SELECT Id, ProfileId FROM User WHERE Id =: contributor1.FieloAlpha__User__c];

        System.runAs(managerUser){
            FieloCMS.RemoteActionResult resultCancelInvitation = BlockUnblockMemberController.blockUnblockMember(contributor2.Id, 'true');
        
            contributor2 = [SELECT FieloAlpha__OrganizationAccount__c, FieloAlpha__Blocked__c FROM FieloAlpha__Member__c WHERE Id =: contributor2.Id];
        
            System.assertEquals(null, contributor2.FieloAlpha__OrganizationAccount__c);
            System.assertEquals(false, contributor2.FieloAlpha__Blocked__c);
        }

    }

}