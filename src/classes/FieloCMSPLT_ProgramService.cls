public class FieloCMSPLT_ProgramService{
	private static FieloPLT__Program__c currentProgram;
	public static FieloPLT__Program__c getCurrentProgram(){
		if(currentProgram == null){
			Id currentMemberId = FieloCMSPLT_MemberService.getCurrentMemberId();
			//si es guest tomo el pr
			if(currentMemberId == null){
				currentProgram = new FieloCMSPLT_ProgramsSelector(false).selectBySiteUrl(Site.getDomain());
			}else{
				Id programId = [SELECT FieloPLT__Program__c FROM FieloPLT__Member__c WHERE Id =: currentMemberId].FieloPLT__Program__c;
				currentProgram = new FieloCMSPLT_ProgramsSelector(true).selectById(new Set<Id>{programId}).get(0);
			}
		}
		return currentProgram;
	}

	public static FieloPLT__Program__c getProgramByDomain(){
        return new FieloCMSPLT_ProgramsSelector(false).selectBySiteUrl(Site.getDomain());
    }

}