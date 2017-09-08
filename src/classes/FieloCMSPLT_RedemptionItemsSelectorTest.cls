@isTest
private class FieloCMSPLT_RedemptionItemsSelectorTest {
  
    @isTest static void test_method_one() {

        // Given
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
        
        FieloPLT__RedemptionItem__c redemptionItem = [SELECT Id FROM FieloPLT__RedemptionItem__c];

        List<FieloPLT__RedemptionItem__c> redemptionItem1 = new FieloCMSPLT_RedemptionItemsSelector().selectById(new Set<Id>{redemptionItem.Id});
        List<FieloPLT__RedemptionItem__c> redemptionItem2 = new FieloCMSPLT_RedemptionItemsSelector(new Set<String>{'Name'}).selectById(new Set<Id>{redemptionItem.Id});
        List<FieloPLT__RedemptionItem__c> redemptionItem3 = new FieloCMSPLT_RedemptionItemsSelector().selectByMemberOriginStatusAndReward(reward.Id, 'Open', 'BackEnd', member.Id);
        List<FieloPLT__RedemptionItem__c> redemptionItem4 = new FieloCMSPLT_RedemptionItemsSelector().selectByRedemptionAndRewards(redemptionItem.Id, new Set<Id>{reward.Id});  

    }
}