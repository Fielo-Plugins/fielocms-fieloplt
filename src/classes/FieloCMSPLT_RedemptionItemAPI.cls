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
                FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__OrganizationAccount__c','FieloPLT__Type__c','FieloPLT__IsManager__c'});
                Id memberId = (loggedMember.FieloPLT__Type__c == 'Organization Contributor' && loggedMember.FieloPLT__OrganizationAccount__c != null && loggedMember.FieloPLT__IsManager__c) ? loggedMember.FieloPLT__OrganizationAccount__c : loggedMember.Id;

                whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\' AND FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + memberId + '\'';
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        Map<String,Schema.SObjectField> redemptionItemFieldMap = Schema.SObjectType.FieloPLT__RedemptionItem__c.fields.getMap();

        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__OrganizationAccount__c','FieloPLT__Type__c','FieloPLT__IsManager__c'});
        Id memberId = (loggedMember.FieloPLT__Type__c == 'Organization Contributor' && loggedMember.FieloPLT__OrganizationAccount__c != null && loggedMember.FieloPLT__IsManager__c) ? loggedMember.FieloPLT__OrganizationAccount__c : loggedMember.Id;

        String whereCondition = 'FieloPLT__Redemption__r.FieloPLT__Status__c != \'Open\' AND FieloPLT__Redemption__r.FieloPLT__Member__c = \'' + memberId + '\'';
        Id redemptionId = component.FieloCMS__RecordId__c;
        if(redemptionId != null){
            whereCondition += ' AND FieloPLT__Redemption__c = \'' + redemptionId + '\'';
        }

        if(String.isNotBlank(filters) && filters != '[]'){
            whereCondition += ' AND ' + FieloCMSPLT_FilterService.getDynamicWhereCondition(filters, 'FieloPLT__RedemptionItem__c', '');
        }

        whereCondition += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        whereCondition += ' OFFSET ' + String.valueOf(offset);

        Set<String> fieldSet = new Set<String>();
        for (String fieldName : FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)) {
            if ( redemptionItemFieldMap.containsKey(fieldName) && redemptionItemFieldMap.get(fieldName).getDescribe().getType().name().toLowerCase() == 'picklist') {
                fieldSet.add( 'toLabel(' + fieldName + ') ' + fieldName );
            } else {
                fieldSet.add(fieldName);
            }
        }

        return Database.query('SELECT ' + String.join(new List<String>(fieldSet), ',') + ' FROM FieloPLT__RedemptionItem__c WHERE ' + whereCondition);
    }
}