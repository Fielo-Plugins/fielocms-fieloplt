trigger FieloCMSPLT_Plugins on FieloCMS__Plugin__c (after delete, after insert, after update, before delete, before insert, before update){
   FieloCMSPLT_SObjectDomain.triggerHandler(FieloCMSPLT_Plugins.class);
}