@isTest
private class ProgramsSelectorTest{
	@isTest
	static void itShould_1(){
		// Given
		FieloPLT__Program__c program1 = new FieloPLT__Program__c(Name = 'Test', SiteDomain__c = 'www.fielo.com');
		insert program1;

		// When
		FieloPLT__Program__c program2 = new ProgramsSelector().selectStaticProgram(program1.Id);

		List<FieloPLT__Program__c> programs1 = new ProgramsSelector().selectById(new Set<Id>{program1.Id});

		List<FieloPLT__Program__c> programs2 = new ProgramsSelector(true).selectById(new Set<Id>{program1.Id});

		List<FieloPLT__Program__c> programs3 = new ProgramsSelector().selectAll();

		List<FieloPLT__Program__c> programs4 = new ProgramsSelector(new Set<String>{'Name'}).selectById(new Set<Id>{program1.Id});

		FieloPLT__Program__c program3 = new ProgramsSelector().selectBySiteUrl('www.fielo.com');

	}
}