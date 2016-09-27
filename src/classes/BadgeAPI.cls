public with sharing class BadgeAPI implements FieloCMS.DataInterface{
	
	//BADGES
    public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            newMapData.put(c.Id, getBadges(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        //Prepare all the queries        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));
        return getBadges(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), Integer.valueOf(component.FieloCMS__Limit__c), offset, orderBy);        
    }

    public static List<FieloPLT__Badge__c> getBadges(Set<String> fields, Id programId, Id memberId, Integer quantity, Integer offset, String orderBy){
        String query = 'SELECT ' + String.join(new List<String>(fields),',');
        
        Set<Id> badgeIds = new Set<Id>();
        for(FieloPLT__BadgeMember__c bm : [Select FieloPLT__Badge2__c FROM FieloPLT__BadgeMember__c WHERE FieloPLT__Member2__c =: memberId]){
            badgeIds.add(bm.FieloPLT__Badge2__c);
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