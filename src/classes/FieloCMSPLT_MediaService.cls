public with sharing class FieloCMSPLT_MediaService {
    public static List<FieloCMS__Media__c> getMedia(Set<String> fields, Id tagId, Id categoryId, Integer quantity, Integer offset, String orderBy, Id memberId, String dynamicFilter) {
        if(tagId != null) {
            String query = 'SELECT ID';
            for ( String f: fields) {
                query += ', FieloCMS__Media__r.' + f ;
            }
            query += ' FROM FieloCMS__TagItem__c WHERE FieloCMS__Tag__c = :tagId AND FieloCMS__Media__c <> NULL ';
            if (categoryId != null) {
                query += 'AND FieloCMS__Media__r.FieloCMS__Category__c =: categoryId ';
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
            query += ' AND (FieloCMS__Media__r.FieloCMSPLT_Segment__c = ' + null + ' OR FieloCMS__Media__r.FieloCMSPLT_Segment__c IN : appliedSegments) ';

            if(String.isNotBlank(dynamicFilter)){
                query += ' AND ' + FieloCMSPLT_FilterService.getDynamicWhereCondition(dynamicFilter, 'FieloCMS__Media__c', 'FieloCMS__Media__r.');
            }

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

        if (categoryId != null) {
            query += 'AND ( FieloCMS__Category__c =: categoryId OR FieloCMS__Category__r.FieloCMS__Category__c =: categoryId ) ';
        }

        if(String.isNotBlank(dynamicFilter)){
            query += ' AND ' + FieloCMSPLT_FilterService.getDynamicWhereCondition(dynamicFilter, 'FieloCMS__Media__c', '');
        }

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
