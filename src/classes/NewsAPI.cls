public with sharing class NewsAPI {
	

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

                    if(c.ComponentLibrary__r.Name == 'ContentFeed'){
                        newMapData.put(c.Id, ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, null, null, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'ContentFeedWidget'){
                        newMapData.put(c.Id, ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }else if(c.ComponentLibrary__r.Name == 'ContentFeedDetail'){
                        Id newsId = c.RecordId__c;
                        List<News__c> news = ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), null, ' Id = \'' + newsId + '\'', null, null, 1, 0, null);
                        newMapData.put(c.Id, (!news.isEmpty() ? news[0] : null));
                    }if(c.ComponentLibrary__r.Name == 'ContentFeedDetail'){
                        Id newsId = c.RecordId__c;
                        List<News__c> news = ContentFeedData.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), null, ' Id = \'' + newsId + '\'', null, null, 1, 0, null);
                        newMapData.put(c.Id, (!news.isEmpty() ? news[0] : null));
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

            if(component.ComponentLibrary__r.Name == 'Catalog'){

                List<String> categoriesIds = new List<String>();
                system.debug(categoryId);
                if(categoryId != null && categoryId != ''){
                    categoryId = categoryId.replace('(', '');
                    categoryId = categoryId.replace(')', '');
                    categoriesIds.add(categoryId);
                }
                system.debug(tagId);
                system.debug(categoryId);
                system.debug(categoriesIds);
                List<sObject> aux = RewardData.getRewards(OrganizationUtil.getFieldSet(component.FieldSet__c), program.Id, null, categoriesIds, tagId, Integer.valueOf(component.Limit__c), offset, orderBy, component.FilterBySegment__c);
                newData.addAll(aux);            
            }
        }
    }
}