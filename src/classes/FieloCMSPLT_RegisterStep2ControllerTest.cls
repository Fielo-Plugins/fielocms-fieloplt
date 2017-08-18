@isTest
private class FieloCMSPLT_RegisterStep2ControllerTest{
	@isTest
		static void itShould_1(){

			FieloCMSPLT_MockupFactory.setProgramAndMember();

			FieloPLT__Member__c member = [SELECT Id FROM FieloPLT__Member__C];

			FieloCMSPLT_RegisterStep2Controller controller = new FieloCMSPLT_RegisterStep2Controller();
			ApexPages.currentPage().getParameters().put('memberId', member.Id);
			FieloPLT__Member__c mem = controller.member;
			Boolean show = controller.showForm;
			Boolean test1 = controller.memberAlreadyRegistered;
			Boolean test2 = controller.memberInApproval;
			Boolean test3 = controller.showContinue;			
			FieloCMSPLT_RegisterStep2Controller.continueRegistration(member.Id);
			FieloCMSPLT_RegisterStep2Controller.finishRegistration(member,'test');

	}
}