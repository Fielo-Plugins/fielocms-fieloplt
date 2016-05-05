public with sharing class ContactAPI implements FieloCMS.DataInterface{
	
	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){                            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            FieloAlpha__Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'FieloAlpha__Account__c'});
            newMapData.put(c.Id, getUnregisteredContacts(loggedMember.FieloAlpha__Account__c, null, c.FieloCMS__Limit__c.intValue(), c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        List<SObject> newData = new List<SObject>();
            
            //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));            
    	FieloAlpha__Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'FieloAlpha__Account__c'});
        return getUnregisteredContacts(loggedMember.FieloAlpha__Account__c, offset, component.FieloCMS__Limit__c.intValue(), orderBy);
    }

    public List<Contact> getUnregisteredContacts(Id accountId, Integer offset, Integer quantity, String orderBy){       
        String query = String.format(
                'select {0} ' +
                  'from Contact ' +
                  'where AccountId =: accountId ',
                new List<String> {'Id, Name'});

        if(orderBy != null){
            query += ' ORDER BY ' + orderBy;
        }

        if(quantity != null){
            query += ' LIMIT ' + String.valueOf(quantity);
        }

        if(offset != null){
            query += ' OFFSET ' + String.valueOf(offset);
        }

        return (List<Contact>) Database.query(query);
    }

}