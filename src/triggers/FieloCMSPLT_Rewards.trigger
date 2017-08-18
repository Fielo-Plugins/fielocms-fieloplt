trigger FieloCMSPLT_Rewards on FieloPLT__Reward__c (after delete, after insert, after update, before delete, before insert, before update){
   FieloCMSPLT_SObjectDomain.triggerHandler(FieloCMSPLT_Rewards.class);
}