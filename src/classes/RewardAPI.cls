global with sharing class RewardAPI implements FieloCMS.DataInterface,FieloCMS.ViewSubComponentInterface{

    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            Id memberId = MemberService.getCurrentMemberId();

            List<FilterService.FilterWrapper> filters = new List<FilterService.FilterWrapper>();            
            if(memberId == null){
                filters.add(new FilterService.FilterWrapper(null,'(','FieloPLT__Program__c','equals',null,null));
                filters.add(new FilterService.FilterWrapper('or',null,'FieloPLT__Program__c','equals',program.Id,')'));
            }

            if(c.FieloCMS__Tag__c != null){
                FilterService.SubQueryFilter sqf = new FilterService.SubQueryFilter('Reward__c','FieloCMS__TagItem__c',new List<FilterService.FilterWrapper>{new FilterService.FilterWrapper(null,null,'FieloCMS__Tag__c','equals',c.FieloCMS__Tag__c,null)});
                filters.add(new FilterService.FilterWrapper('and',null,'Id',sqf,null));
            }
            if(c.FieloCMS__Category__c != null){
                filters.add(new FilterService.FilterWrapper('and',null,'Category__c','equals',c.FieloCMS__Category__c,null));
            }

            if(!filters.isEmpty()){
                filters[0].andOrOperator = null;
            }

            system.debug(JSON.serialize(filters));
            newMapData.put(c.Id, FieloPLT.RewardService.getRewards(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), memberId, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c, filters.isEmpty() ? null : JSON.serialize(filters)));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        
        List<FilterService.FilterWrapper> filtersList = new List<FilterService.FilterWrapper>();
        if(String.isNotBlank(filters)){
            //List<FilterService.FilterWrapper> filtersList = (List<FilterService.FilterWrapper>) JSON.deserialize(filters, List<FilterService.FilterWrapper>.class);
            filtersList.addAll((List<FilterService.FilterWrapper>) JSON.deserialize(filters, List<FilterService.FilterWrapper>.class));
            if(!filtersList.isEmpty()){
                for(Integer i = filtersList.size() - 1; i > 0; i--){
                    if(filtersList[i].field == 'FieloCMS__Category__c' || filtersList[i].field == 'FieloCMS__Tag__c'){
                        if(filtersList[i].value != null){
                            component.put(filtersList[i].field, filtersList[i].value);
                        }
                        filtersList.remove(i);
                    }else if(String.isBlank(filtersList[i].value)){
                        filtersList.remove(i);
                    }
                }
            }
        }

        FieloPLT__Program__c program = ProgramService.getCurrentProgram();                
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        Id memberId = MemberService.getCurrentMemberId();
        if(memberId == null){
            filtersList.add(new FilterService.FilterWrapper(null,'(','FieloPLT__Program__c','equals',null,null));
            filtersList.add(new FilterService.FilterWrapper('or',null,'FieloPLT__Program__c','equals',program.Id,')'));
        }

        if(component.FieloCMS__Tag__c != null){
            FilterService.SubQueryFilter sqf = new FilterService.SubQueryFilter('Reward__c','FieloCMS__TagItem__c',new List<FilterService.FilterWrapper>{new FilterService.FilterWrapper(null,null,'FieloCMS__Tag__c','equals',component.FieloCMS__Tag__c,null)});
            filtersList.add(new FilterService.FilterWrapper('and',null,'Id',sqf,null));
        }   
        if(component.FieloCMS__Category__c != null){
            filtersList.add(new FilterService.FilterWrapper('and',null,'Category__c','equals',component.FieloCMS__Category__c,null));
        }   

        if(!filtersList.isEmpty()){
            filtersList[0].andOrOperator = null;
        }

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        return FieloPLT.RewardService.getRewards(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), memberId, component.FieloCMS__Limit__c.intValue(), offset, orderBy, filtersList.isEmpty() ? null : JSON.serialize(filtersList));
    }

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
        Component.FieloCMSPLT_AddToCart addToCart = new Component.FieloCMSPLT_AddToCart();
        if(record != null){
            addToCart.record = record;
        }else{
            addToCart.expressions.record = '{!record}';
        }        
        addToCart.field = field;        
        return addToCart;
    }

}