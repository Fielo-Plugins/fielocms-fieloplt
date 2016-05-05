public with sharing class RedemptionItemAPI implements FieloCMS.DataInterface{
	
	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            String whereCondition = 'FieloAlpha__Redemption__r.FieloAlpha__Status__c != \'Open\' AND FieloAlpha__Redemption__r.FieloAlpha__Member__c = \'' + MemberService.getCurrentMemberId() + '\'';
            Id redemptionId = c.FieloCMS__RecordId__c;
            if(redemptionId != null){
                whereCondition += ' AND FieloAlpha__Redemption__c = \'' + redemptionId + '\'';
            }
            newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloAlpha__RedemptionItem__c WHERE ' + whereCondition));            
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        String whereCondition = 'FieloAlpha__Redemption__r.FieloAlpha__Status__c != \'Open\' AND FieloAlpha__Redemption__r.FieloAlpha__Member__c = \'' + MemberService.getCurrentMemberId() + '\'';
        Id redemptionId = component.FieloCMS__RecordId__c;
        if(redemptionId != null){
            whereCondition += ' AND FieloAlpha__Redemption__c = \'' + redemptionId + '\'';
        }
        whereCondition += ' LIMIT ' + String.valueOf(offset);
        whereCondition += ' OFFSET ' + String.valueOf(component.FieloCMS__Limit__c);
        return Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM FieloAlpha__RedemptionItem__c WHERE ' + whereCondition);
    }
}