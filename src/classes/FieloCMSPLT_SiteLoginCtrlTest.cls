@isTest
private class FieloCMSPLT_SiteLoginCtrlTest {

    static testMethod void checkout1(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        FieloCMSPLT_SiteLoginCtrl controller = new FieloCMSPLT_SiteLoginCtrl();

        FieloCMSPLT_SiteLoginCtrl.login('test@fielo.com','test');
        
        FieloCMSPLT_SiteLoginCtrl.forgotPassword('test@fielo.com');
        
        
    }
}