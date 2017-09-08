global with sharing class FieloCMSPLT_RedemptionItemAPI implements FieloCMS.DataInterface{
	
	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            String whereCondition;
            if(String.isNotBlank(c.FieloCMS__DetailParameter__c) && ApexPages.CurrentPage().getParameters().containsKey(c.FieloCMS__DetailParameter__c)){
                Id redemptionId = ApexPages.CurrentPage().getParameters().get(c.FieloCMS__DetailParameter__c);
                whereCondition = ' FieloPLT__Redemption__c = \'' + redemptionId + '\'';
            }else{
                whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\' AND FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + FieloCMSPLT_MemberService.getCurrentMemberId() + '\'';
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        String whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\' AND FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + FieloCMSPLT_MemberService.getCurrentMemberId() + '\'';
        Id redemptionId = component.FieloCMS__RecordId__c;
        if(redemptionId != null){
            whereCondition += ' AND FieloPLT__Redemption__c = \'' + redemptionId + '\'';
        }
        whereCondition += ' LIMIT ' + String.valueOf(offset);
        whereCondition += ' OFFSET ' + String.valueOf(component.FieloCMS__Limit__c);
        return Database.query('SELECT ' + String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition);
    }
}