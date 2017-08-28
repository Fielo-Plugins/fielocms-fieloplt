public class FieloCMSPLT_Rewards extends FieloCMSPLT_SObjectDomain {
	
	public FieloCMSPLT_Rewards(List<FieloPLT__Reward__c> records){
		super(records);	
	}

	public override void onAfterInsert(){
    	FieloCMS.CategoryService.updateCounters( records, 1);
  	}
  
  	public override void onAfterUpdate(Map<Id,SObject> existingRecords){  
    	FieloCMS.CategoryService.updateCounters( records, existingRecords);    
  	}
  
  	public override void onAfterDelete(){
    	FieloCMS.CategoryService.updateCounters( records, -1);
  	}

	public class Constructor implements FieloCMSPLT_SObjectDomain.IConstructable{
		
		public FieloCMSPLT_SObjectDomain construct(List<SObject> sObjectList){
			return new FieloCMSPLT_Rewards(sObjectList);
		}
	}	
}