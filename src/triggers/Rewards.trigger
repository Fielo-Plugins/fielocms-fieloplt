trigger Rewards on FieloPLT__Reward__c (after delete, after insert, after update, before delete, before insert, before update){
   SObjectDomain.triggerHandler(Rewards.class);
}