public with sharing class RewardAPI implements FieloCMS.DataInterface{

    public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        FieloAlpha__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.Name == 'Catalog'){
            //if(c.ComponentLibrary__r.Name == 'Catalog'){
                newMapData.put(c.Id, FieloAlpha.RewardService.getRewards(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), c.Tag__c, c.Category__c, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c, c.FilterBySegment__c));
            }else if(c.Name == 'RewardDetail'){
            //}else if(c.ComponentLibrary__r.Name == 'RewardDetail'){
                Id rewardId = c.FieloCMS__RecordId__c;                
                newMapData.put(c.Id, Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloAlpha__Reward__c WHERE Id =: rewardId'));
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
        return FieloAlpha.RewardService.getRewards(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), program.Id, MemberService.getCurrentMemberId(), component.Tag__c, component.Category__c, component.FieloCMS__Limit__c.intValue(), offset, orderBy, component.FilterBySegment__c);
    }

}