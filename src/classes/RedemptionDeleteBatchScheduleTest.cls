@isTest
private class RedemptionDeleteBatchScheduleTest {

    @isTest(seeAllData=false) public static void deleteBatchScheduleTest() {   
        // set properties
        MockUpFactory.setCustomProperties(false);
        
        System.Test.StartTest();
        
        
        // create member
        Member__c member ;
        try{
            member = MockUpFactory.createMember('testRedDelBatchSchedule', '66666666666', 'Passport');             
        }catch(Exception  ex){
            member = [SELECT Id, User__c FROM Member__c limit 1];
        }
    
        // create redemption
        Redemption__c orden = MockUpFactory.createOrder(member);
        orden.status__c = 'Open';
        update orden;
        
        // create redemption delete batch schedule
        RedemptionDeleteBatchSchedule reassign = new RedemptionDeleteBatchSchedule();
        String sch = '0 0 23 * * ?';
        
        // schedule batch     
        system.schedule('Test RedemptionDeleteBatchSchedule Check',sch,reassign);
        
        Id batchId = Database.executeBatch(reassign);
        new RedemptionDeleteBatchSchedule();
        System.Test.StopTest();
        
        
        // query for async jobs list
        List<AsyncApexJob> lista = [SELECT Id From AsyncApexJob where id = :batchId];
        
        // ASSERTIONS
            // async job list not empty 
        system.assert(!lista.isEmpty());                                                                   
   }

}