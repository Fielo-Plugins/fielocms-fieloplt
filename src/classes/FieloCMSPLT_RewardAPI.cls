global with sharing class FieloCMSPLT_RewardAPI implements FieloCMS.DataInterface,FieloCMS.ViewSubComponentInterface{

    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            Id memberId = FieloCMSPLT_MemberService.getCurrentMemberId();

            List<FieloCMSPLT_FilterService.FilterWrapper> filters = new List<FieloCMSPLT_FilterService.FilterWrapper>();            
            if(memberId == null){
                filters.add(new FieloCMSPLT_FilterService.FilterWrapper(null,'(','FieloPLT__Program__c','equals',null,null));
                filters.add(new FieloCMSPLT_FilterService.FilterWrapper('or',null,'FieloPLT__Program__c','equals',program.Id,')'));
            }

            if(c.FieloCMS__Tag__c != null){
                FieloCMSPLT_FilterService.SubQueryFilter sqf = new FieloCMSPLT_FilterService.SubQueryFilter('FieloCMSPLT_Reward__c','FieloCMS__TagItem__c',new List<FieloCMSPLT_FilterService.FilterWrapper>{new FieloCMSPLT_FilterService.FilterWrapper(null,null,'FieloCMS__Tag__c','equals',c.FieloCMS__Tag__c,null)});
                filters.add(new FieloCMSPLT_FilterService.FilterWrapper('and',null,'Id',sqf,null));
            }
            if(c.FieloCMS__Category__c != null){
                filters.add(new FieloCMSPLT_FilterService.FilterWrapper('and',null,'FieloCMSPLT_Category__c','equals',c.FieloCMS__Category__c,null));
            }

            if(!filters.isEmpty()){
                filters[0].andOrOperator = null;
            }

            system.debug(JSON.serialize(filters));
            newMapData.put(c.Id, FieloPLT.RewardService.getRewards(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), memberId, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c, filters.isEmpty() ? null : JSON.serialize(filters)));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        
        List<FieloCMSPLT_FilterService.FilterWrapper> filtersList = new List<FieloCMSPLT_FilterService.FilterWrapper>();
        if(String.isNotBlank(filters)){
            //List<FilterService.FilterWrapper> filtersList = (List<FilterService.FilterWrapper>) JSON.deserialize(filters, List<FilterService.FilterWrapper>.class);
            filtersList.addAll((List<FieloCMSPLT_FilterService.FilterWrapper>) JSON.deserialize(filters, List<FieloCMSPLT_FilterService.FilterWrapper>.class));
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

        FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();                
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        Id memberId = FieloCMSPLT_MemberService.getCurrentMemberId();
        if(memberId == null){
            filtersList.add(new FieloCMSPLT_FilterService.FilterWrapper(null,'(','FieloPLT__Program__c','equals',null,null));
            filtersList.add(new FieloCMSPLT_FilterService.FilterWrapper('or',null,'FieloPLT__Program__c','equals',program.Id,')'));
        }

        if(component.FieloCMS__Tag__c != null){
            FieloCMSPLT_FilterService.SubQueryFilter sqf = new FieloCMSPLT_FilterService.SubQueryFilter('FieloCMSPLT_Reward__c','FieloCMS__TagItem__c',new List<FieloCMSPLT_FilterService.FilterWrapper>{new FieloCMSPLT_FilterService.FilterWrapper(null,null,'FieloCMS__Tag__c','equals',component.FieloCMS__Tag__c,null)});
            filtersList.add(new FieloCMSPLT_FilterService.FilterWrapper('and',null,'Id',sqf,null));
        }   
        if(component.FieloCMS__Category__c != null){
            filtersList.add(new FieloCMSPLT_FilterService.FilterWrapper('and',null,'FieloCMSPLT_Category__c','equals',component.FieloCMS__Category__c,null));
        }   

        if(!filtersList.isEmpty()){
            filtersList[0].andOrOperator = null;
        }

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        return FieloPLT.RewardService.getRewards(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), memberId, component.FieloCMS__Limit__c.intValue(), offset, orderBy, filtersList.isEmpty() ? null : JSON.serialize(filtersList));
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