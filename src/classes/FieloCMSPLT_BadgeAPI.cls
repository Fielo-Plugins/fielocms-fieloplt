global with sharing class FieloCMSPLT_BadgeAPI implements FieloCMS.DataInterface{
    
    //BADGES
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            newMapData.put(c.Id, FieloCMSPLT_BadgeService.getBadges(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), program.Id, FieloCMSPLT_MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();
        //Prepare all the queries        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));
        return FieloCMSPLT_BadgeService.getBadges(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), program.Id, FieloCMSPLT_MemberService.getCurrentMemberId(), Integer.valueOf(component.FieloCMS__Limit__c), offset, orderBy);        
    }

}