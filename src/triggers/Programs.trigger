trigger Programs on Program__c (before insert, before update) {		
	Programs.formatSiteDomain(Trigger.new);
}