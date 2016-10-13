public with sharing class MediaService {
	public static List<FieloCMS__Media__c> getMedia(Set<String> fields, Id tagId, Integer quantity, Integer offset, String orderBy, Id memberId) {
        if(tagId != null) {
            String query = 'SELECT ID';
            for ( String f: fields) {
                query += ', FieloCMS__Media__r.' + f ;
            }
            query += ' FROM FieloCMS__TagItem__c WHERE FieloCMS__Tag__c = :tagId ';
          
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

            System.debug(medias);

            return medias;
        }         
        String query = 'SELECT ' + String.join(new List<String>(fields), ',') + ' FROM FieloCMS__Media__c ';
        // WHERE CONDITION 
        String whereCondition = '';

        if ( whereCondition != '' ) {
            query += ' WHERE ' + whereCondition.substring(4);
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

        System.debug(Database.query(query));

        return Database.query(query);        
    }

}