trigger FieloCMSPLT_Programs on FieloPLT__Program__c (before insert, before update) {		
	FieloCMSPLT_Programs.formatSiteDomain(Trigger.new);
}