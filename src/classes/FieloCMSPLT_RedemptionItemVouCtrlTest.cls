@isTest
private class FieloCMSPLT_RedemptionItemVouCtrlTest {

    static testMethod void itemVoucherControllerTest(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        member.FieloPLT__Points__c = 500;
        FieloPLT.SObjectService.enableAdminPermission(true);
        update member;
        FieloPLT.SObjectService.enableAdminPermission(false);
        
        System.debug(loggingLevel.Error, '*** redemptions: ' + [Select id, fieloplt__points__c from FieloPLT__Member__c]);
        // create reward. reward items and redemption
        
        FieloPLT__Reward__c reward = FieloCMSPLT_MockUpFactory.createRewards('Test', 10, program.Id, 10)[0];
        insert reward;
        Map<Id, Integer> quantityPerReward = new Map<Id, Integer>{reward.Id => 1};
        List<FieloPLT__Redemption__c> redemptions = FieloPLT.RedemptionService.createRedemptions(quantityPerReward, member.Id);
        System.debug(loggingLevel.Error, '*** redemptions: ' + redemptions);

        FieloPLT__RedemptionItem__c item = [SElect id from FieloPLT__RedemptionItem__c limit 1];
                
        Pagereference pageRef = ApexPages.currentPage();
        pageRef.getParameters().put('ordenId', redemptions.get(0).id);
        
        // create redemption item voucher controller
        FieloCMSPLT_RedemptionItemVouCtrl controller = new FieloCMSPLT_RedemptionItemVouCtrl();
        
        controller.vouchers.size();
        String imageId = controller.imageId;
        String docUrl = controller.docURL;
        String orgId = controller.orgId;
        
        pageRef = ApexPages.currentPage();
        pageRef.getParameters().put('voucherId', item.Id);
        
        
    }

}