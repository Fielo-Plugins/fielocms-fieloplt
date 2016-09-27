public without sharing class PackageInstallation implements InstallHandler {
	public void onInstall(InstallContext context){
		if(context.PreviousVersion() == null){
            install(context.installerId());
        }
	}

	public void install(Id userId){
		try{
			createPublicAndPrivateSegments();
		}catch(Exception e){
			FieloPLT.ErrorUtil.insertError(e);
		}
	}

	public static void createPublicAndPrivateSegments(){
		List<RecordType> recordTypes = [SELECT Id FROM RecordType WHERE (DeveloperName = 'Private' OR DeveloperName = 'Public') AND SObjectType = 'FieloPLT__Segment__c' ORDER BY DeveloperName ASC];
		List<FieloPLT__Segment__c> toInsert = new List<FieloPLT__Segment__c>();
		for(FieloPLT__Program__c p : [SELECT Id FROM FieloPLT__Program__c]){
			toInsert.add(new FieloPLT__Segment__c(Name = 'Registered', RecordTypeId = recordTypes[0].Id, FieloPLT__Program__c = p.Id));
			toInsert.add(new FieloPLT__Segment__c(Name = 'Guest', RecordTypeId = recordTypes[1].Id, FieloPLT__Program__c = p.Id));
		}
		insert toInsert;
	}
}