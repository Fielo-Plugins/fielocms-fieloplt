global with sharing class FieloCMSPLT_ContactAPI implements FieloCMS.DataInterface{
    
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){                            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__Account__c'});
            newMapData.put(c.Id, FieloCMSPLT_ContactService.getUnregisteredContacts(loggedMember.FieloPLT__Account__c, null, c.FieloCMS__Limit__c.intValue(), c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        List<SObject> newData = new List<SObject>();
            
            //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));            
        FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__Account__c'});
        return FieloCMSPLT_ContactService.getUnregisteredContacts(loggedMember.FieloPLT__Account__c, offset, component.FieloCMS__Limit__c.intValue(), orderBy);
    }

}