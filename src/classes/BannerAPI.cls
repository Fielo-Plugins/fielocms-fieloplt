public with sharing class BannerAPI implements FieloCMS.DataInterface{
	
	//BANNERS
    public Map<Id, Object> getBulkData(List<Component__c> components){
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        Map<String,ComponentLibrary__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentLibrary__c != null){
                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentLibrary__c).Visibility__c)){
                    if(c.Limit__c == null)
                        c.Limit__c = 5;

                    if(c.ComponentLibrary__r.Name == 'Banner'){
                        List<String> fieldSet = OrganizationUtil.getFieldSet(c.FieldSet__c);
                        if(c.ComponentLibrary__r.LinkField__c != null){
                            fieldSet = OrganizationUtil.getJoinedList(fieldSet,new List<String>{c.ComponentLibary__r.LinkField__c});
                        }
                        newMapData.put(c.Id, BannerData.getBanners(fieldSet, program.Id, c.Id, null, null, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'BannerWidget'){
                        List<String> fieldSet = OrganizationUtil.getFieldSet(c.FieldSet__c);
                        if(c.ComponentLibrary__r.LinkField__c != null){
                            fieldSet = OrganizationUtil.getJoinedList(fieldSet,new List<String>{.ComponentLibary__r.LinkField__c});
                        }
                        newMapData.put(c.Id, BannerData.getBanners(fieldSet, program.Id, c.Id, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }
                }
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

        String locale = 'EN';//OrganizationUtil.getLanguage();
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        List<SObject> newData = new List<SObject>();

        //Prepare all the queries
        if(component.ComponentLibrary__c != null){
            if(component.Limit__c == null)
                component.Limit__c = 5;

            //Calculate the offset from the Page Number
            Integer offset = Integer.valueOf(component.Limit__c * (pageNumber - 1));

            if(component.ComponentLibrary__r.Name == 'Banner'){
                List<sObject> aux = BannerData.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, component.Tag__c, component.Category__c, Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);

            }else if(component.ComponentLibrary__r.Name == 'BannerWidget'){
                //newMapData.put(c.Id, FrontEndUtil.getBanners(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, c.Id, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0));
                if(component.Category__c != null){
                    categoryId = component.Category__c;
                }
                if(component.Tag__c != null){
                    tagId = component.Tag__c;
                }
                List<sObject> aux = BannerData.getBanners(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, component.Id, tagId, categoryId, Integer.valueOf(component.Limit__c), offset, orderBy);
                newData.addAll(aux);

            }
        }
    }

}