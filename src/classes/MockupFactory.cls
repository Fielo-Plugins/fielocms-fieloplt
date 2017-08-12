@isTest
public class MockupFactory{

	public static void setProgramAndMember(){
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;
	}


	public static List<FieloPLT__Reward__c> createRewards(String basename, Integer count, Id programId, Integer points){
		List<FieloPLT__Reward__c> results = new List<FieloPLT__Reward__c>();
		for(Integer x = 0; x < count; x++){
			FieloPLT__Reward__c r = new FieloPLT__Reward__c();
			r.Name = basename + String.valueOf(x);
			r.FieloPLT__Program__c = programId;
			r.FieloPLT__Points__c = points;
			r.FieloPLT__Stock__c = count;
			results.add(r);
		}
		return results;
	}

	public static void createPoints(FieloPLT__Member__c member, Integer pointsValue){
        FieloPLT.SObjectService.enableAdminPermission(true);
        FieloPLT__Transaction__c adjustTransaction = new FieloPLT__Transaction__c(FieloPLT__Type__c = 'Adjust', FieloPLT__SkipEngine__c = true, FieloPLT__Value__c = pointsValue, FieloPLT__Member__c = member.id);
        insert adjustTransaction;        
        FieloPLT.SObjectService.enableAdminPermission(false);
    }
}