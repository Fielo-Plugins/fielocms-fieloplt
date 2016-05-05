public with sharing class NewsAPI implements FieloCMS.DataInterface {
	
    public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        FieloAlpha__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){                        
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.Name == 'ContentFeed'){
            //if(c.ComponentLibrary__r.Name == 'ContentFeed'){
                newMapData.put(c.Id, FieloAlpha.NewsService.getNews(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), c.Id, c.Tag__c, c.Category__c, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));
            }else if(c.Name == 'ContentFeedDetail'){
            //}else if(c.ComponentLibrary__r.Name == 'ContentFeedDetail'){
                Id newsId = c.FieloCMS__RecordId__c;
                newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloAlpha__News__c WHERE Id =: newsId'));
            }                
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

        if(categoryId == null && component.Category__c != null){
            categoryId = component.Category__c;
        }
        if(tagId == null && component.Tag__c != null){
            tagId = component.Tag__c;
        }

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));         
        return FieloAlpha.NewsService.getNews(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), component.Id, tagId, categoryId, component.FieloCMS__Limit__c.intValue(), offset, orderBy);
    }
}