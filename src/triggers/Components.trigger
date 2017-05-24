trigger Components on FieloCMS__Component__c (before insert, before update) {
    SObjectDomain.triggerHandler(Components.class);
}