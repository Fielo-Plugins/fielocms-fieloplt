public class ProgramService{
	private static FieloPLT__Program__c currentProgram;
	public static FieloPLT__Program__c getCurrentProgram(){
		if(currentProgram == null){
			Id currentMemberId = MemberService.getCurrentMemberId();
			//si es guest tomo el pr
			if(currentMemberId == null){				
				currentProgram = new ProgramsSelector(true).getProgramByDomain();
			}else{
				Id programId = [SELECT FieloPLT__Program__c FROM FieloPLT__Member__c WHERE Id =: currentMemberId].FieloPLT__Program__c;
				currentProgram = new ProgramsSelector(true).getProgram(programId);
			}
		}
		return currentProgram;
	}


}