public class ProgramService{
	private static FieloAlpha__Program__c currentProgram;
	public static FieloAlpha__Program__c getCurrentProgram(){
		if(currentProgram == null){
			Id currentMemberId = MemberService.getCurrentMemberId();
			//si es guest tomo el pr
			if(currentMemberId == null){
				return FieloAlpha.ProgramUtil.getProgramByDomain();
			}else{
				Id programId = [SELECT FieloAlpha__Program__c FROM FieloAlpha__Member__c WHERE Id =: currentMemberId].FieloAlpha__Program__c;
				currentProgram = FieloAlpha.ProgramUtil.getProgram(programId);
			}
		}
		return currentProgram;
	}
}