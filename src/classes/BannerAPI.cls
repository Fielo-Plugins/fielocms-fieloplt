global with sharing class BannerAPI implements FieloCMS.DataInterface{
	
	//BANNERS
    public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        FieloAlpha__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){                            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;                               
            //c.Id SEPARAR COMO ANTES EN 2 COMP, WIDGET Y NO
            newMapData.put(c.Id, FieloAlpha.BannerService.getBanners(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), null, c.Tag__c, c.Category__c, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));                        
        }
        return newMapData;
    }


    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        //Set Category or Tag from FilterBy
        String categoryId;
        String tagId;
        if(filters != null){
            Map<String,Object> filtersMap = (Map<String,Object>) JSON.deserializeUntyped(filters);
            for(String s : filtersMap.keySet()){
                if(s == 'Category__c'){
                    categoryId = (String)filtersMap.get(s);
                }else if(s == 'Tag__c'){
                    tagId = (String)filtersMap.get(s);
                }
            }
        }

        FieloAlpha__Program__c program = ProgramService.getCurrentProgram();

        //Prepare all the queries        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        if(categoryId == null && component.Category__c != null){
            categoryId = component.Category__c;
        }
        if(tagId == null && component.Tag__c != null){
            tagId = component.Tag__c;
        }
        return FieloAlpha.BannerService.getBanners(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), component.Id, tagId, categoryId, component.FieloCMS__Limit__c.intValue(), offset, orderBy);            
    }

}