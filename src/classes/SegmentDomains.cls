public class SegmentDomains extends SObjectDomain {
	
	public SegmentDomains(List<FieloPLT__SegmentDomain__c> records){
		super(records);	
	}

	public override void onBeforeInsert(){
		Set<Id> navIds = new Set<Id>();
		for(FieloPLT__SegmentDomain__c record : (List<FieloPLT__SegmentDomain__c>) records){
			if(record.Navigation__c != null) navIds.add(record.Navigation__c);
		}

		List<FieloCMS__Navigation__c> toUpdate = new NavigationsSelector(new Set<String>{'Id'}).selectByIdAndHasSegments(navIds, false);
		for(FieloCMS__Navigation__c nav : toUpdate){
			nav.HasSegments__c = true;
		}

		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloCMS__Navigation__c.SObjectType}); 
	
		uow.registerDirty(toUpdate);
		uow.commitWork();
	}

	public override void onBeforeDelete(){
		Set<Id> navIds = new Set<Id>();
		for(FieloPLT__SegmentDomain__c record : (List<FieloPLT__SegmentDomain__c>) records){
			if(record.Navigation__c != null) navIds.add(record.Navigation__c);
		}

		List<FieloCMS__Navigation__c> toUpdate = new NavigationsSelector(new Set<String>{'Id'}).selectByIdAndHasSegments(navIds, true);
		for(FieloCMS__Navigation__c nav : toUpdate){
			nav.HasSegments__c = false;
		}

		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloCMS__Navigation__c.SObjectType}); 
	
		uow.registerDirty(toUpdate);
		uow.commitWork();
	}



	public class Constructor implements SObjectDomain.IConstructable{
		
		public SObjectDomain construct(List<SObject> sObjectList){
			return new SegmentDomains(sObjectList);
		}
	}	
}