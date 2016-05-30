public without sharing class PackageInstallation implements InstallHandler {
	public void onInstall(InstallContext context){
		if(context.PreviousVersion() == null){
            install(context.installerId());
        }
	}

	public void install(Id userId){
		createPublicAndPrivateSegments();
	}

	public static void createPublicAndPrivateSegments(){
		List<RecordType> recordTypes = [SELECT Id FROM RecordType WHERE (DeveloperName = 'Private' OR DeveloperName = 'Public') AND SObjectType = 'FieloAlpha__RedemptionRule__c' ORDER BY DeveloperName ASC];
		List<FieloAlpha__RedemptionRule__c> toInsert = new List<FieloAlpha__RedemptionRule__c>();
		for(FieloAlpha__Program__c p : [SELECT Id FROM FieloAlpha__Program__c]){
			toInsert.add(new FieloAlpha__RedemptionRule__c(Name = 'Registered', RecordTypeId = recordTypes[0].Id, FieloAlpha__Program__c = p.Id));
			toInsert.add(new FieloAlpha__RedemptionRule__c(Name = 'Guest', RecordTypeId = recordTypes[1].Id, FieloAlpha__Program__c = p.Id));
		}
		insert toInsert;
	}
}