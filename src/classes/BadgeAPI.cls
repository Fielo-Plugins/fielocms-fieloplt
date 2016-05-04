public with sharing class BadgeAPI implements CMSDataInterface{
	
	//BADGES
    public Map<Id, Object> getBulkData(List<CMSComponent__c> components){
        FieloAlpha__Program__c program = FieloAlpha.ProgramUtil.getProgramByDomain();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.Limit__c == null)
                c.Limit__c = 5;
            
            newMapData.put(c.Id, getBadges(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Limit__c.intValue(), 0, c.OrderBy__c));
        }
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){        
        FieloAlpha__Program__c program = FieloAlpha.ProgramUtil.getProgramByDomain();
        //Prepare all the queries        
        if(component.Limit__c == null)
            component.Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.Limit__c * (pageNumber - 1));
        return getBadges(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, Integer.valueOf(component.Limit__c), offset, orderBy);        
    }

}