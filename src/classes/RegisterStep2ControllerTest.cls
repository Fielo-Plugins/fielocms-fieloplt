@isTest
private class RegisterStep2ControllerTest{
	@isTest
		static void itShould_1(){

			MockupFactory.setProgramAndMember();

			FieloPLT__Member__c member = [SELECT Id FROM FieloPLT__Member__C];

			RegisterStep2Controller controller = new RegisterStep2Controller();
			ApexPages.currentPage().getParameters().put('memberId', member.Id);
			FieloPLT__Member__c mem = controller.member;
			Boolean show = controller.showForm;
			Boolean test1 = controller.memberAlreadyRegistered;
			Boolean test2 = controller.memberInApproval;
			Boolean test3 = controller.showContinue;			
			RegisterStep2Controller.continueRegistration(member.Id);
			RegisterStep2Controller.finishRegistration(member,'test');

	}
}