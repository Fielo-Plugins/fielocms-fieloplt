public with sharing class FieloCMSPLT_MediaService {
	public static List<FieloCMS__Media__c> getMedia(Set<String> fields, Id tagId, Integer quantity, Integer offset, String orderBy, Id memberId) {
        if(tagId != null) {
            String query = 'SELECT ID';
            for ( String f: fields) {
                query += ', FieloCMS__Media__r.' + f ;
            }
            query += ' FROM FieloCMS__TagItem__c WHERE FieloCMS__Tag__c = :tagId ';
          

            //segmentation
            Set<Id> appliedSegments = new Set<Id>();
            if(memberId != null) appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
            //ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
            if(UserInfo.getUserType() == 'Guest'){
                appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
            }else{
                appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
            }
            query += ' AND (FieloCMS__Media__r.FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMS__Media__r.FieloCMSPLT_Segment__c IN : appliedSegments) ';

            // ORDER BY,  LIMIT & OFFSET
            if( String.isNotBlank(orderBy) ){
                query += ' ORDER BY FieloCMS__Media__r.' + orderBy;
            }
            if(quantity != null){
                query += ' LIMIT ' + quantity;
            }
            if(offset != null){
                query += ' OFFSET ' + offset;
            }
            List<FieloCMS__Media__c> medias = new List<FieloCMS__Media__c>();
            for ( FieloCMS__TagItem__c ti : Database.query(query) ) {
                medias.add(ti.FieloCMS__Media__r);
            }
            return medias;
        }         
        String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Media__c ';
     
        //segmentation
        Set<Id> appliedSegments = new Set<Id>();
        if(memberId != null) appliedSegments = FieloPLT.SegmentService.getMemberSegments(memberId, null);
        //ya que platform no me devuelve los segmentos privado y público, los agrego yo según corresponda
        if(UserInfo.getUserType() == 'Guest'){
            appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Public' LIMIT 1].Id);
        }else{
            appliedSegments.add([SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1].Id);
        }
        query += ' WHERE (FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMSPLT_Segment__c IN : appliedSegments) ';

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
