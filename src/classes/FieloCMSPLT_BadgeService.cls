public with sharing class FieloCMSPLT_BadgeService{
	
    public static List<FieloPLT__Badge__c> getBadges(Set<String> fields, Id programId, Id memberId, Integer quantity, Integer offset, String orderBy){
        String query = 'SELECT ' + String.join(new List<String>(fields),',');
        
        Set<Id> badgeIds = new Set<Id>();
        for(FieloPLT__BadgeMember__c bm : [Select FieloPLT__Badge__c FROM FieloPLT__BadgeMember__c WHERE FieloPLT__Member__c =: memberId]){
            badgeIds.add(bm.FieloPLT__Badge__c);
        }

        query += ' FROM FieloPLT__Badge__c WHERE Id In : badgeIds AND FieloPLT__Program__c =: programId';

        //LIMIT
        if(quantity != null){
            query += ' LIMIT ' + quantity;
        }

        //OFFSET
        if(offset != null){
            query += ' OFFSET ' + offset;
        }

        //ORDER by
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + orderBy;
        }

        return Database.query(query);        
    }

}