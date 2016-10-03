global with sharing class RewardAPI implements FieloCMS.DataInterface,FieloCMS.ViewSubComponentInterface{

    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            newMapData.put(c.Id, FieloPLT.RewardService.getRewards(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c, '(FieloPLT__Program__c = null OR FieloPLT__Program__c = \'' + program.Id + '\')'));

        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        //Set Category or Tag from FilterBy
        String categoryId;
        String tagId;
        if(filters != null){
            Map<String,Object> filtersMap = (Map<String,Object>) JSON.deserializeUntyped(filters);
            for(String s : filtersMap.keySet()){
                if(s == 'FieloCMS__Category__c'){
                    categoryId = (String)filtersMap.get(s);
                }else if(s == 'FieloCMS__Tag__c'){
                    tagId = (String)filtersMap.get(s);
                }
            }
        }

        FieloPLT__Program__c program = ProgramService.getCurrentProgram();                
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        if(categoryId == null && component.FieloCMS__Category__c != null){
            categoryId = component.FieloCMS__Category__c;
        }
        if(tagId == null && component.FieloCMS__Tag__c != null){
            tagId = component.FieloCMS__Tag__c;
        }

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));
        return FieloPLT.RewardService.getRewards(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), MemberService.getCurrentMemberId(), component.FieloCMS__Limit__c.intValue(), offset, orderBy, '(FieloPLT__Program__c = null OR FieloPLT__Program__c = \'' + program.Id + '\')');
    }

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
        Component.AddToCart addToCart = new Component.AddToCart();
        if(record != null){
            addToCart.record = record;
        }else{
            addToCart.expressions.record = '{!record}';
        }        
        addToCart.field = field;        
        return addToCart;
    }

}