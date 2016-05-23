public class NavigationService{

	public static List<FieloCMS__Navigation__c> getNavigations(Set<String> fields, Id siteId, Id memberId, Boolean filterBySegments){

		String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ', (SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Navigations__r) FROM FieloCMS__Navigation__c';
		query += ' WHERE FieloCMS__Site__c =: siteId ';

		Set<Id> appliedSegments;
		Set<Id> navIds;
		if(filterBySegments){
			appliedSegments = FieloAlpha.SegmentService.getMemberSegments(memberId, null);
			navIds = new Set<Id>();
			for(FieloAlpha__SegmentDomain__c segDom : [SELECT FieloCMS_EE__Navigation__c FROM FieloAlpha__SegmentDomain__c WHERE FieloAlpha__Segment__c in : FieloAlpha.SegmentService.getMemberSegments(memberId, null) AND FieloCMS_EE__Navigation__c != NULL]){
                navIds.add(segDom.FieloCMS_EE__Navigation__c);
            }
            query += ' AND (Id IN : navIds OR HasSegments__c = false)';
		}

		return Database.query(query);
	}

	public static List<FieloCMS__Navigation__c> getNavigations(Id parentId, Set<String> fields, Id siteId, Id memberId, Boolean filterBySegments){

		String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ', (SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Navigations__r) FROM FieloCMS__Navigation__c';
		query += ' WHERE FieloCMS__Site__c =: siteId AND FieloCMS__Parent__c =: parentId ';

		Set<Id> appliedSegments;
		Set<Id> navIds;
		if(filterBySegments){
			appliedSegments = FieloAlpha.SegmentService.getMemberSegments(memberId, null);
			navIds = new Set<Id>();
			for(FieloAlpha__SegmentDomain__c segDom : [SELECT FieloCMS_EE__Navigation__c FROM FieloAlpha__SegmentDomain__c WHERE FieloAlpha__Segment__c in : FieloAlpha.SegmentService.getMemberSegments(memberId, null) AND FieloCMS_EE__Navigation__c != NULL]){
                navIds.add(segDom.FieloCMS_EE__Navigation__c);
            }
            query += ' AND (Id IN : navIds OR HasSegments__c = false)';
		}

		return Database.query(query);
	}



}