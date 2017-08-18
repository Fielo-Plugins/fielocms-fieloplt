trigger FieloCMSPLT_Components on FieloCMS__Component__c (before insert, before update) {
    FieloCMSPLT_SObjectDomain.triggerHandler(FieloCMSPLT_Components.class);
}