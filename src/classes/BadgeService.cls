public with sharing class BadgeService {
	
	public static List<Badge__c> getBadges(Set<String> fields, Id programId, Id memberId, Integer quantity, Integer offset, String orderBy){
        String query = 'SELECT ' + String.join(new List<String>(fields),',');
        
        Set<Id> badgeIds = new Set<Id>();
        for(BadgeMember__c bm : [Select Badge__c FROM BadgeMember__c WHERE Member__c =: memberId]){
            badgeIds.add(bm.Badge__c);
        }

        query += ' FROM Badge__c WHERE Id In : badgeIds AND Program__c =: programId';

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