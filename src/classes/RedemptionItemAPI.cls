global with sharing class RedemptionItemAPI implements FieloCMS.DataInterface{
    
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            String whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + MemberService.getCurrentMemberId() + '\'';
            if(c.FieloCMS__RecordId__c != null){
                //Id redemptionId = ApexPages.CurrentPage().getParameters().get(c.FieloCMS__DetailParameter__c);
                whereCondition += ' AND FieloPLT__Redemption__c = \'' + c.FieloCMS__RecordId__c + '\'';
            }else{
                whereCondition += ' AND FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\'';
            }
            if(!String.isBlank(c.FieloCMS__OrderBy__c)){
                whereCondition += ' ORDER BY ' + c.FieloCMS__OrderBy__c;
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            whereCondition += ' OFFSET 0';
            newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        Id recordId;
        if(String.isNotBlank(filters)){
            List<FilterService.FilterWrapper> filtersList = (List<FilterService.FilterWrapper>) JSON.deserialize(filters, List<FilterService.FilterWrapper>.class);
            if(!filtersList.isEmpty()){
                for(FilterService.FilterWrapper filter: filtersList ){
                    if(filter.field == 'FieloCMS__RecordId__c' && filter.value != null){
                        recordId = filter.value;
                    }
                }
            }
        }

        String whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + MemberService.getCurrentMemberId() + '\'';
        if(recordId != null){
            //Id redemptionId = ApexPages.CurrentPage().getParameters().get(c.FieloCMS__DetailParameter__c);
            whereCondition += ' AND FieloPLT__Redemption__c = \'' + recordId + '\'';
        }else{
            whereCondition += ' AND FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\'';
        }

        if(orderBy != null && orderBy != ''){
            whereCondition += ' ORDER BY ' + orderBy;
        }        
        whereCondition += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        whereCondition += ' OFFSET ' + String.valueOf(offset);

        List<String> fields = new List<String>(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c));

        Schema.DescribeSObjectResult objectDescribe = Schema.describeSObjects(new List<String>{'FieloPLT__RedemptionItem__c'})[0];
        Set<String> picklistTypes = new Set<String>{'PICKLIST','MULTIPICKLIST'};
        
        for(Integer i = 0 ; i < fields.size() ; ) {
            String field = fields.get(i);
            if(objectDescribe.fields.getMap().containskey(field.toLowerCase()) && picklistTypes.contains(objectDescribe.fields.getMap().get(field.toLowerCase()).getDescribe().getType().name())){
                fields.remove(i);
                fields.add('toLabel(' + field + ')');
            }else{
                i++;
            }
        }

        return Database.query('SELECT ' + String.join(fields, ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition);
    }
}