public class FieloCMSPLT_NavigationService {

	public static List<FieloCMS__Navigation__c> getNavigations(Id parentId, Set<String> fields, Id siteId, Id memberId){

		String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ', (SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Navigations__r) FROM FieloCMS__Navigation__c';
		query += ' WHERE FieloCMS__Site__c =: siteId AND FieloCMS__Parent__c =: parentId ';

		Set<Id> appliedSegments = new Set<Id>();
		if(memberId != null) appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
		//ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
		if(UserInfo.getUserType() == 'Guest'){
			appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
		}else{
			appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
		}

        query += ' AND (FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMSPLT_Segment__c IN : appliedSegments) ';

		query += ' ORDER BY FieloCMS__Order__c';

		return Database.query(query);
	}

}