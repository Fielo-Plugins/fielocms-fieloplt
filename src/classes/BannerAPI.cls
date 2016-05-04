public with sharing class BannerAPI implements CMSDataInterface{
	
	//BANNERS
    public Map<Id, Object> getBulkData(List<CMSComponent__c> components){
        FieloEE__Program__c program = FieloEE.ProgramUtil.getProgramByDomain();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){                            
            if(c.Limit__c == null)
                c.Limit__c = 5;

            if(c.Name == 'Banner'){
            //if(c.ComponentLibrary__r.Name == 'Banner'){                
                newMapData.put(c.Id, FieloAlpha.BannerService.getBanners(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Id, null, null, c.Limit__c.intValue(), 0, c.OrderBy__c));
            }else if(c.Name == 'BannerWidget'){
            //}else if(c.ComponentLibrary__r.Name == 'BannerWidget'){                
                newMapData.put(c.Id, FieloAlpha.BannerService..getBanners(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Id, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, c.OrderBy__c));
            }            
        }
    }


    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
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

        FieloEE__Program__c program = FieloEE.ProgramUtil.getProgramByDomain();

        //Prepare all the queries        
        if(component.Limit__c == null)
            component.Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.Limit__c * (pageNumber - 1));

        if(c.Name == 'Banner'){
        //if(c.ComponentLibrary__r.Name == 'Banner'){    
            return FieloAlpha.BannerService.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, component.Tag__c, component.Category__c, Integer.valueOf(component.Limit__c), offset, orderBy);            
        }else if(c.Name == 'BannerWidget'){
        //}else if(c.ComponentLibrary__r.Name == 'BannerWidget'){                                
            if(categoryId == null && component.Category__c != null){
                categoryId = component.Category__c;
            }
            if(tagId == null && component.Tag__c != null){
                tagId = component.Tag__c;
            }
            return FieloAlpha.BannerService.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, tagId, categoryId, Integer.valueOf(component.Limit__c), offset, orderBy);                
        }
    }

}