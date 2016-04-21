/**
* @author Alejandro Ferrante
* @date 29/05/2013
* @description Class to test the RegisterStep2Controller
*/
@isTest
private class RegisterStep2ControllerTest {
    
    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description 
    */
    /*@isTest(seeAllData=false) static void createMemberStep2With2StepsWithoutAutorization(){
        MockUpFactory.setCustomProperties(false);
        
        //without cpf validation
        Site__c prop = SiteUtil.getDefaultProgram();        
        prop.RegistrationTransaction__c = false;
        prop.ReferalTransactionStep1__c = true;
        prop.ReferalTransactionStep2__c = true;
        prop.RequestAutorization__c = false;
        upsert prop;
        
        Member__c referalParticipant ;
        try{
            referalParticipant = MockUpFactory.createMember('referPart' , '169.826.534-47', 'Passport'); 
        }catch(Exception  ex){
            referalParticipant = [SELECT Id, User__c FROM Member__c limit 1];
        }
        
        Member__c participant = new Member__c();
        participant.FirstName__c = 'testNameParticipant';
        participant.LastName__c = 'testLastNameParticipant';
        participant.Email__c = 't1111111114@test.com';
        participant.Type__c='Operator';
        participant.OperatorPassword__c='1234';
        participant.OperatorCode__c='1';
        participant.IdentificationCode__c = '158.316.577-11';
        participant.IdentificationType__c = 'Passaport';
        participant.ReferalMember__c= referalParticipant.id;
        
        participant.ReferalMember__c= referalParticipant.id;
        //MemberTrigger.isSite = true;
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert participant;
        Contact contact = [SELECT id, Member__c FROM Contact WHERE Member__c =:participant.id];
        
        system.currentPageReference().getParameters().put('mId',participant.id);
        
        RegisterStep2Controller controller = New RegisterStep2Controller();
        controller.confirmOneStepRegistration();
        controller.password = '12345678';
        controller.confirmPassword = '12345679';
        system.assertEquals(controller.registerUser2(), null);
        controller.password = '12345678';
        controller.confirmPassword = '12345678';
        
        controller.registerUser2();
        
        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        
        system.assertNotEquals(participant.User__c, null);
        system.assertNotEquals(participant.Approved__c, false);
        
        List<Transaction__c> tReferal= [SELECT id FROM Transaction__c WHERE Member__c=:referalParticipant.id];
        System.assertNotEquals(tReferal, null);
        
        system.assertNotEquals(controller.cancelar(), null);

    }
    
    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description 
    */
    /*@isTest(seeAllData=false) static void createMemberStep2With2StepsWithtAutorization(){
        MockUpFactory.setCustomProperties(false);

        Document doc= new Document();
        doc.Body = Blob.valueOf('doc 2');
        doc.Name = 'doc2';
        Folder fieloFolder = [SELECT Id FROM Folder WHERE Name = 'Fielo Docs'];
        doc.FolderId = fieloFolder.Id;
        insert doc;
     
        Site__c prop = SiteUtil.getDefaultProgram();        
        prop.RegistrationTransaction__c=true;
        prop.ReferalTransactionStep1__c=true;
        prop.ReferalTransactionStep2__c=true;
        prop.RequestAutorization__c = true;
        prop.Step2RegistrationMessage__c = doc.id;

        
        upsert prop;
        
        Member__c referalParticipant ;
        try{
            referalParticipant = MockUpFactory.createMember('referalParticipantParticipant' , '169.826.534-47', 'Passport'); 
            referalParticipant =  [SELECT Id, User__c FROM Member__c where id =:referalParticipant.id];
        }catch(Exception  ex){
            referalParticipant = [SELECT Id, User__c FROM Member__c limit 1];
        }
        Member__c participant = new Member__c();
        participant.FirstName__c = 'testNameParticipant';
        participant.LastName__c = 'testLastNameParticipant';
        participant.Email__c = 't1111111114@test.com';
        participant.Type__c='Operator';
        participant.OperatorPassword__c='1234';
        participant.OperatorCode__c='1';
        participant.IdentificationCode__c = '158.316.577-11';
        participant.IdentificationType__c = 'Passaport';
        participant.ReferalMember__c= referalParticipant.id;
        
        //MemberTrigger.isSite = true;
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert participant;
        Contact contact = [SELECT id, Member__c FROM Contact WHERE Member__c =:participant.id];
        
        system.currentPageReference().getParameters().put('mId',participant.id);
        
        RegisterStep2Controller controller = New RegisterStep2Controller();
        controller.confirmOneStepRegistration();
        controller.password = '12345678';
        controller.confirmPassword = '12345679';
        system.assertEquals(controller.registerUser2(), null);
        controller.password = '12345678';
        controller.confirmPassword = '12345678';
        
        controller.registerUser2();
        
        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        
        system.assertEquals(participant.User__c, null);
        system.assertEquals(participant.Approved__c, false);
        
        
        //aprobar member
        //MemberTrigger.isSite = false;
        participant.Approved__c = true;
        //allows to edit read only fields        
        MemberTrigger.validateReadOnlyFields = false;
        update participant;
        
        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        system.assertNotEquals(participant.User__c, null);
        system.assertNotEquals(participant.Approved__c, false);
                
        List<Transaction__c> tReferal= [SELECT id FROM Transaction__c WHERE Member__c=:referalParticipant.id];
        System.assertNotEquals(tReferal, null);
        
        system.assertNotEquals(controller.cancelar(), null);

    }
    
    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description 
    */
    /*@isTest(seeAllData=false) static void createMemberStep2With1StepsWithtAutorization(){
        MockUpFactory.setCustomProperties(false);

        //without cpf validation
        Site__c prop = SiteUtil.getDefaultProgram();        
        prop.RegistrationTransaction__c=true;
        prop.ReferalTransactionStep1__c=true;
        prop.ReferalTransactionStep2__c=true;
        prop.RequestAutorization__c = true;
        prop.OneStepRegistration__c = true;
        upsert prop;
        
        Member__c referalParticipant ;
        try{
            referalParticipant = MockUpFactory.createMember('referalParticipantParticipant' , '169.826.534-47', 'Passport'); 
            referalParticipant =  [SELECT Id, User__c FROM Member__c where id =:referalParticipant.id];
        }catch(Exception  ex){
            referalParticipant = [SELECT Id, User__c FROM Member__c limit 1];
        }
        
        Member__c participant = new Member__c();
        participant.FirstName__c = 'testNameParticipant';
        participant.LastName__c = 'testLastNameParticipant';
        participant.Email__c = 't1111111114@test.com';
        participant.Type__c='Operator';
        participant.OperatorPassword__c='1234';
        participant.OperatorCode__c='1';
        participant.IdentificationCode__c = '158.316.577-11';
        participant.IdentificationType__c = 'Passaport';
        participant.ReferalMember__c= referalParticipant.id;
        
        //MemberTrigger.isSite = true;
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert participant;
        Contact contact = [SELECT id, Member__c FROM Contact WHERE Member__c =:participant.id];
        
        system.currentPageReference().getParameters().put('mId',participant.id);
        
        RegisterStep2Controller controller = New RegisterStep2Controller();
        controller.confirmOneStepRegistration();

        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        
        system.assertEquals(participant.User__c, null);
        system.assertEquals(participant.Approved__c, false);
        system.assertEquals(participant.Registered__c, true);
        
        
        //aprobar member
        //MemberTrigger.isSite = false;
        participant.Approved__c = true;
        //allows to edit read only fields        
        MemberTrigger.validateReadOnlyFields = false;
        update participant;
        
        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        system.assertNotEquals(participant.User__c, null);
        system.assertNotEquals(participant.Approved__c, false);
  

    }
    
    /**
    * @author Alejandro Ferrante
    * @date 29/05/2013
    * @description 
    */
    /*@isTest(seeAllData=false) static void createMemberStep2With1StepsWithtoutAutorization(){
        MockUpFactory.setCustomProperties(false);
        
        //without cpf validation
        Site__c prop = SiteUtil.getDefaultProgram();        
        prop.RegistrationTransaction__c = true;
        prop.ReferalTransactionStep1__c = true;
        prop.ReferalTransactionStep2__c = true;
        prop.RequestAutorization__c = false;
        prop.OneStepRegistration__c = true;
        upsert prop;
        Member__c referalParticipant ;
        try{
            referalParticipant = MockUpFactory.createMember('referalParticipantParticipant' , '169.826.534-47', 'Passport'); 
            referalParticipant =  [SELECT Id, User__c FROM Member__c where id =:referalParticipant.id];
        }catch(Exception  ex){
            referalParticipant = [SELECT Id, User__c FROM Member__c limit 1];
        }
        Member__c participant = new Member__c();
        participant.FirstName__c = 'testNameParticipant';
        participant.LastName__c = 'testLastNameParticipant';
        participant.Email__c = 't1111111114@test.com';
        participant.Type__c='Operator';
        participant.OperatorPassword__c='1234';
        participant.OperatorCode__c='1';
        participant.IdentificationCode__c = '158.316.577-11';
        participant.IdentificationType__c = 'Passaport';
        participant.ReferalMember__c= referalParticipant.id;
        
        //MemberTrigger.isSite = true;
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert participant;
        Contact contact = [SELECT id, Member__c FROM Contact WHERE Member__c =:participant.id];
        
        system.currentPageReference().getParameters().put('mId',participant.id);
        
        RegisterStep2Controller controller = New RegisterStep2Controller();
        controller.confirmOneStepRegistration();

        participant = [SELECT id, OperatorPassword__c, Registered__c, Approved__c,User__c FROM Member__c WHERE id =:participant.id]; 
        
        system.assertNotEquals(participant.User__c, null);
        system.assertNotEquals(participant.Approved__c, false);
    }*/
}