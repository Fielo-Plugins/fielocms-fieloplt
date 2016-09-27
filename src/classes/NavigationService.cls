public class NavigationService{

	public static List<FieloCMS__Navigation__c> getNavigations(Id parentId, Set<String> fields, Id siteId, Id memberId, Boolean filterBySegments){

		String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ', (SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Navigations__r) FROM FieloCMS__Navigation__c';
		query += ' WHERE FieloCMS__Site__c =: siteId AND FieloCMS__Parent__c =: parentId ';

		Set<Id> appliedSegments;
		Set<Id> navIds;
		if(filterBySegments){
			appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
			//ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
			if(UserInfo.getUserType() == 'Guest'){
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
			}else{
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
			}

			navIds = new Set<Id>();
			for(FieloPLT__SegmentDomain__c segDom : [SELECT Navigation__c FROM FieloPLT__SegmentDomain__c WHERE FieloPLT__Segment__c in : appliedSegments AND Navigation__c != NULL]){
                navIds.add(segDom.Navigation__c);
            }
            query += ' AND (Id IN : navIds OR HasSegments__c = false)';
		}

		query += ' ORDER BY FieloCMS__Order__c';

		return Database.query(query);
	}



}