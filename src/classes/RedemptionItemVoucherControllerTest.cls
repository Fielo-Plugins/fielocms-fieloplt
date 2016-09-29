@isTest
private class RedemptionItemVoucherControllerTest {

    static testMethod void itemVoucherControllerTest(){
        
        // settings authorization request off
        /*MockUpFactory.setCustomProperties(false);
            
        // create member    
        Member__c member ;
	    try{
	    	member = MockUpFactory.createMember('test','66666666666', 'Passport');	        
      	}catch(Exception  ex){
	    	member = [SELECT Id, Points__c, User__c FROM Member__c limit 1];
      	}
        MockUpFactory.createPoints(member, 500);
        
        // create reward. reward items and redemption
        Reward__c reward = MockUpFactory.createReward('Test', 10, 10, 'Controlled By Quantity', false, new ProgramsSelector().selectByDefault().Id);        
        Redemption__c redemption = MockUpFactory.createOrder(member);
        RedemptionItem__c item = MockUpFactory.createRedemptionItem(reward, redemption);
        MockUpFactory.createRedemptionItem(reward, redemption);
                
        Pagereference pageRef = ApexPages.currentPage();
        pageRef.getParameters().put('ordenId', redemption.id);
        
        // create redemption item voucher controller
        RedemptionItemVoucherController controller = new RedemptionItemVoucherController();
        
        // ASSERTIONS
        	// controller's voucher list size is 2
        system.assertEquals(2, controller.vouchers.size());
        
        pageRef = ApexPages.currentPage();
        pageRef.getParameters().put('voucherId', item.Id);
        
        // create redemption item voucher controller
        controller = new RedemptionItemVoucherController();
        
        // controller's voucher list size is 2
        system.assertEquals(2, controller.vouchers.size());  */     
    }

}