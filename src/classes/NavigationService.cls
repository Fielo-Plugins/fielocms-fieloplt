public class NavigationService implements FieloCMS.DataInterface{

	public static List<FieloCMS__Navigation__c> getNavigations(Id parentId, Set<String> fields, Id siteId, Id memberId, Boolean filterBySegments){

		String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ', (SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Navigations__r) FROM FieloCMS__Navigation__c';
		query += ' WHERE FieloCMS__Site__c =: siteId AND FieloCMS__Parent__c =: parentId ';

		Set<Id> appliedSegments;
		if(filterBySegments){
			appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
			//ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
			if(UserInfo.getUserType() == 'Guest'){
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
			}else{
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
			}

            query += ' AND Segment__c IN : appliedSegments';
		}

		query += ' ORDER BY FieloCMS__Order__c';

		return Database.query(query);
	}

	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        Map<Id,Object> newMapData = new Map<Id,Object>();


        String siteId = Site.getSiteId();

        List<FieloCMS__Site__c> sites = [SELECT Id FROM FieloCMS__Site__c WHERE FieloCMS__SiteId__c =: siteId];
        if(!sites.isEmpty()){
            siteId = sites.get(0).Id;
        }                

        //Prepare all the queries
        for(FieloCMS__Component__c c : components){

        	//como hay campos que necesito sí o sí traer en el query, me armo un set en low case de los campos
			Set<String> fieldsToQuery = new Set<String>();
			fieldsToQuery.add('fielocms__url__c');

			for(String fieldName : OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)){
				fieldsToQuery.add(fieldName.toLowerCase());
			}

			newMapData.put(c.Id, NavigationService.getNavigations(c.FieloCMS__Navigation__c, fieldsToQuery, siteId, MemberService.getCurrentMemberId(), true));
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }

}