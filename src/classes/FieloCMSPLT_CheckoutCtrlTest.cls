@isTest
private class FieloCMSPLT_CheckoutCtrlTest {

    static testMethod void checkout1(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        member.FieloPLT__Points__c = 500;
        FieloPLT.SObjectService.enableAdminPermission(true);
        update member;
        FieloPLT.SObjectService.enableAdminPermission(false);
        
        FieloPLT__Reward__c reward = FieloCMSPLT_MockUpFactory.createRewards('Test', 10, program.Id, 10)[0];
        insert reward;
        Map<Id, Integer> quantityPerReward = new Map<Id, Integer>{reward.Id => 1};
        
        FieloCMSPLT_CheckoutCtrl controller = new FieloCMSPLT_CheckoutCtrl();
        FieloCMSPLT_CheckoutCtrl.checkout(reward.Id,1,'www.fielo.com');
        
    }
   
    static testMethod void checkout2(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test',FieloPLT__RequestRedemptionAuthorization__c = true);
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        member.FieloPLT__Points__c = 500;
        FieloPLT.SObjectService.enableAdminPermission(true);
        update member;
        FieloPLT.SObjectService.enableAdminPermission(false);
        
        FieloPLT__Reward__c reward = FieloCMSPLT_MockUpFactory.createRewards('Test', 10, program.Id, 10)[0];
        insert reward;
        Map<Id, Integer> quantityPerReward = new Map<Id, Integer>{reward.Id => 1};
        
        FieloCMSPLT_CheckoutCtrl controller = new FieloCMSPLT_CheckoutCtrl();
        FieloCMSPLT_CheckoutCtrl.checkout(reward.Id,1,'www.fielo.com');
        
    }   

    static testMethod void checkout3(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test',FieloPLT__RequestRedemptionAuthorization__c = true);
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        member.FieloPLT__Points__c = 500;
        FieloPLT.SObjectService.enableAdminPermission(true);
        update member;
        FieloPLT.SObjectService.enableAdminPermission(false);
        
        FieloPLT__Reward__c reward = FieloCMSPLT_MockUpFactory.createRewards('Test', 10, program.Id, 10)[0];
        insert reward;
        Map<Id, Integer> quantityPerReward = new Map<Id, Integer>{member.Id => 1};
        
        FieloCMSPLT_CheckoutCtrl controller = new FieloCMSPLT_CheckoutCtrl();
        FieloCMSPLT_CheckoutCtrl.checkout(reward.Id,1,'www.fielo.com');
        
    }
   
   
}