trigger Programs on FieloPLT__Program__c (before insert, before update) {		
	Programs.formatSiteDomain(Trigger.new);
}