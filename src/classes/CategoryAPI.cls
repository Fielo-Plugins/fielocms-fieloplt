global with sharing class CategoryAPI implements FieloCMS.DataInterface {
	
	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){                        
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
                                                                        
            newMapData.put(c.Id, FieloPLT.CategoryService.getCategories(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), c.Category__c, program.Id, MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }

}