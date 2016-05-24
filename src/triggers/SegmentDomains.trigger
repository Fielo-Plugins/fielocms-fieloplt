trigger SegmentDomains on FieloAlpha__SegmentDomain__c (after delete, after insert, after update, before delete, before insert, before update){
   SObjectDomain.triggerHandler(SegmentDomains.class);
}