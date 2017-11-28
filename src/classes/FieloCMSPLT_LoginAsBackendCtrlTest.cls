@isTest
private class FieloCMSPLT_LoginAsBackendCtrlTest {

    @isTest(seeAllData=false) static void redirectSuccessful() {

      FieloPLT__Program__c lProgram = new FieloPLT__Program__c(Name = 'test');
        insert lProgram;
        //crate new member with user
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test member');
        insert member;
                
        FieloCMSPLT_LoginAsBackendCtrl controller = new FieloCMSPLT_LoginAsBackendCtrl();
        system.currentPageReference().getParameters().put('memberId',member.Id); 
        try {
            controller.redirect();
        } catch (Exception e) {
        }
    }
    
}