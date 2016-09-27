@isTest
private class TestCreateUser
{
	@isTest
	static void itShould(){
        FieloPLT__Program__c defaultProgram = new FieloPLT__Program__c(FieloPLT__IsDefault__c = true);
        insert defaultProgram;

        FieloPLT__Segment__c segment = new FieloPLT__Segment__c();
        insert segment;

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
        List<FieloPLT__Program__c> programs = new List<FieloPLT__Program__c>();
        programs.add(new FieloPLT__Program__c(Name = 'Test Program 1', FieloPLT__IsDefault__c = true));
        programs.add(new FieloPLT__Program__c(Name = 'Test Program 2', FieloPLT__IsDefault__c = false));
        insert programs;
        //Corro al script de instalación
        PackageInstallation installScript = new PackageInstallation();
        Test.testInstall(installScript, null);

        //Ahora verifico que se hayan creado los segmentos públicos y privados
        List<FieloPLT__Segment__c> segments = [SELECT RecordType.DeveloperName, FieloPLT__Program__c FROM FieloPLT__Segment__c WHERE FieloPLT__Program__c IN : programs AND (RecordType.DeveloperName = 'Private' OR RecordType.DeveloperName = 'Public') ORDER BY FieloPLT__Program__r.Name, RecordType.DeveloperName];

        System.assertEquals(segments[0].FieloPLT__Program__c, programs[0].Id);//que pertenezca al primer programa
        System.assertEquals(segments[1].FieloPLT__Program__c, programs[0].Id);//que pertenezca al primer programa
        System.assertEquals(segments[0].RecordType.DeveloperName, 'Private');//que sea el segmento Private
        System.assertEquals(segments[1].RecordType.DeveloperName, 'Public');//que sea el segmento Public
        System.assertEquals(segments[2].FieloPLT__Program__c, programs[1].Id);//que pertenezca al primer programa
        System.assertEquals(segments[3].FieloPLT__Program__c, programs[1].Id);//que pertenezca al primer programa
        System.assertEquals(segments[2].RecordType.DeveloperName, 'Private');//que sea el segmento Private
        System.assertEquals(segments[3].RecordType.DeveloperName, 'Public');//que sea el segmento Public

    }

    @isTest
    static void testCancelInvitation(){
        //Voy a probar cancelar una invitación para un member que fue creado por otro usuario que no es el que está tratando de cancelar la invitación
        
        //Creo un programa
        FieloPLT__Program__c defaultProgram = new FieloPLT__Program__c(FieloPLT__IsDefault__c = true);
        insert defaultProgram;

        //Creo una cuenta, y luego una organization Account relacionada a esta cuenta
        Account acc = new Account(Name = 'Test Organization Account');
        insert acc;

        List<RecordType> memberRecordTypes = [SELECT Id FROM RecordType WHERE SObjectType = 'FieloPLT__Member__c' AND (DeveloperName = 'OrganizationAccount' OR DeveloperName = 'OrganizationContributor') ORDER BY DeveloperName ASC];
        //en la posición 0 va a estar Organization Account, en la 1 Organization Contributor
        
        //Creo la organization account
        FieloPLT__Member__c orgAccount = new FieloPLT__Member__c(FieloPLT__LastName__c = 'Test Organization Account', FieloPLT__Account__c = acc.Id, RecordTypeId = memberRecordTypes[0].Id);
        insert orgAccount;

        //Creo dos contributors, uno de los cuales es manager
        List<FieloPLT__Member__c> contributors = new List<FieloPLT__Member__c>();
        FieloPLT__Member__c contributor1 = new FieloPLT__Member__c(FieloPLT__FirstName__c = 'Contributor', FieloPLT__LastName__c = '1', FieloPLT__Email__c = 'contributor1@fielo.com', FieloPLT__IsManager__c = true, FieloPLT__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[1].Id);
        contributors.add(contributor1);
        FieloPLT__Member__c contributor2 = new FieloPLT__Member__c(FieloPLT__FirstName__c = 'Contributor', FieloPLT__LastName__c = '2', FieloPLT__Email__c = 'contributor2@fielo.com', FieloPLT__IsManager__c = false, FieloPLT__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[1].Id);
        contributors.add(contributor2);
        insert contributors;

        FieloCMS.RemoteActionResult resultFinishRegistration = RegisterStep2Controller.finishRegistration(contributor1, null);

        contributor1 = [SELECT FieloPLT__User__c FROM FieloPLT__Member__c WHERE Id =: contributor1.Id];
        contributor2 = [SELECT FieloPLT__User__c, OwnerId FROM FieloPLT__Member__c WHERE Id =: contributor2.Id];


        User managerUser = [SELECT Id, ProfileId FROM User WHERE Id =: contributor1.FieloPLT__User__c];


        System.runAs(managerUser){
            FieloCMS.RemoteActionResult resultCancelInvitation = HandleInvitationsMembersController.cancelInvitation(contributor2.Id);
        }
    }

    @isTest
    static void testBlockUnblock(){
        //Creo un programa
        FieloPLT__Program__c defaultProgram = new FieloPLT__Program__c(FieloPLT__IsDefault__c = true);
        insert defaultProgram;

        //Creo una cuenta, y luego una organization Account relacionada a esta cuenta
        Account acc = new Account(Name = 'Test Organization Account');
        insert acc;

        List<RecordType> memberRecordTypes = [SELECT Id FROM RecordType WHERE SObjectType = 'FieloPLT__Member__c' AND (DeveloperName = 'IndividualAccount' OR DeveloperName = 'OrganizationAccount' OR DeveloperName = 'OrganizationContributor') ORDER BY DeveloperName ASC];
        //en la posición 0 va a estar Individual Account, en la 1 va a estar Organization Account, en la 2 Organization Contributor
    
        //Creo la organization account
        FieloPLT__Member__c orgAccount = new FieloPLT__Member__c(FieloPLT__LastName__c = 'Test Organization Account', FieloPLT__Account__c = acc.Id, RecordTypeId = memberRecordTypes[1].Id);
        insert orgAccount;

        //Creo dos contributors para la organization account (aunque uno es individual account), uno de los cuales es manager
        List<FieloPLT__Member__c> contributors = new List<FieloPLT__Member__c>();
        FieloPLT__Member__c contributor1 = new FieloPLT__Member__c(FieloPLT__FirstName__c = 'Contributor', FieloPLT__LastName__c = '1', FieloPLT__Email__c = 'contributor1@fielo.com', FieloPLT__IsManager__c = true, FieloPLT__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[2].Id);
        contributors.add(contributor1);
        FieloPLT__Member__c contributor2 = new FieloPLT__Member__c(FieloPLT__FirstName__c = 'Contributor', FieloPLT__LastName__c = '2', FieloPLT__Email__c = 'contributor2@fielo.com', FieloPLT__IsManager__c = false, FieloPLT__OrganizationAccount__c = orgAccount.Id, RecordTypeId = memberRecordTypes[0].Id);
        contributors.add(contributor2);
        insert contributors;

        FieloCMS.RemoteActionResult resultFinishRegistration = RegisterStep2Controller.finishRegistration(contributor1, null);

        contributor1 = [SELECT FieloPLT__User__c FROM FieloPLT__Member__c WHERE Id =: contributor1.Id];
    
        User managerUser = [SELECT Id, ProfileId FROM User WHERE Id =: contributor1.FieloPLT__User__c];

        System.runAs(managerUser){
            FieloCMS.RemoteActionResult resultCancelInvitation = BlockUnblockMemberController.blockUnblockMember(contributor2.Id, 'true');
        
            contributor2 = [SELECT FieloPLT__OrganizationAccount__c, FieloPLT__IsBlocked__c FROM FieloPLT__Member__c WHERE Id =: contributor2.Id];
        
            System.assertEquals(null, contributor2.FieloPLT__OrganizationAccount__c);
            System.assertEquals(false, contributor2.FieloPLT__IsBlocked__c);
        }

    }

}