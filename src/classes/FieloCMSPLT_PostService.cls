public with sharing class FieloCMSPLT_PostService {
    public static List<FieloCMS__Post__c> getPosts(Set<String> fields, String status, Id tagId, Id categoryId, Integer quantity, Integer offset, String orderBy, Id memberId) {
        if(tagId != null) {
            String query = 'SELECT ID';
            for ( String f: fields) {
                query += ', FieloCMS__Post__r.' + f ;
            }
            query += ' FROM FieloCMS__TagItem__c WHERE FieloCMS__Tag__c = :tagId ';
            if (categoryId != null) {
                query += 'AND ( FieloCMS__Post__r.FieloCMS__Category__c =: categoryId OR FieloCMS__Post__r.FieloCMS__Category__r.FieloCMS__Category__c =: categoryId )';
            }
            if (status != null) {
                query += 'AND FieloCMS__Post__r.FieloCMS__Status__c =: status ';
            }

            //segmentation
            Set<Id> appliedSegments = new Set<Id>();
			if(memberId != null) appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
			//ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
			if(UserInfo.getUserType() == 'Guest'){
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
			}else{
				appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
			}
            query += ' AND (FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMSPLT_Segment__c IN : appliedSegments) ';

            // ORDER BY,  LIMIT & OFFSET
            if( String.isNotBlank(orderBy) ){
                query += ' ORDER BY FieloCMS__Post__r.' + orderBy;
            }
            if(quantity != null){
                query += ' LIMIT ' + quantity;
            }
            if(offset != null){
                query += ' OFFSET ' + offset;
            }
            List<FieloCMS__Post__c> posts = new List<FieloCMS__Post__c>();
            for ( FieloCMS__TagItem__c ti : Database.query(query) ) {
                posts.add(ti.FieloCMS__Post__r);
            }
            return posts;
        }         
        String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Post__c ';
        // WHERE CONDITION 
        String whereCondition = '';
        if (categoryId != null) {
            whereCondition += 'AND (FieloCMS__Category__c =: categoryId OR FieloCMS__Category__r.FieloCMS__Category__c =: categoryId ) ';
        }
        if (status != null) {
            whereCondition += 'AND FieloCMS__Status__c =: status ';
        }
        if ( whereCondition != '' ) {
            query += ' WHERE ' + whereCondition.substring(4);
        }

        //segmentation
        Set<Id> appliedSegments = new Set<Id>();
		if(memberId != null) appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
		//ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
		if(UserInfo.getUserType() == 'Guest'){
			appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
		}else{
			appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
		}
           query += ' AND (FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMSPLT_Segment__c IN : appliedSegments) ';

        // ORDER BY,  LIMIT & OFFSET
        if( String.isNotBlank(orderBy) ){
            query += ' ORDER BY ' + orderBy;
        }
        if(quantity != null){
            query += ' LIMIT ' + quantity;
        }
        if(offset != null){
            query += ' OFFSET ' + offset;
        }        
        return Database.query(query);        
    }   

}