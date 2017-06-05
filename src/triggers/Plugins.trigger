trigger Plugins on FieloCMS__Plugin__c (after delete, after insert, after update, before delete, before insert, before update){
   SObjectDomain.triggerHandler(Plugins.class);
}