public with sharing class RedemptionItemData {
	
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

                    if(c.ComponentLibrary__r.Name == 'Redemptions'){
                        String whereCondition = 'Redemption__r.Status__c != \'Open\' AND Redemption__r.Member__c = \'' + MemberUtil.getMemberId() + '\'';
                        Id redemptionId = c.RecordId__c;
                        if(redemptionId != null){
                            whereCondition += ' AND Redemption__c = \'' + redemptionId + '\'';
                        }
                        Set<String> fields = new Set<String>();
                        for(String s : OrganizationUtil.getFieldSet(c.FieldSet__c)){
                            fields.add(s);
                        }
                        newMapData.put(c.Id, RedemptionData.getRedemptionItems(fields, null, null, null, c.Limit__c.intValue(), 0, whereCondition, c.OrderBy__c));
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

            if(component.ComponentLibrary__r.Name == 'Redemptions'){
                String whereCondition = 'Redemption__r.Status__c = \'Close\' AND Redemption__r.Member__c = \'' + MemberUtil.getMemberId() + '\'';
                Id redemptionId = component.RecordId__c;
                if(redemptionId != null){
                    whereCondition += ' AND Redemption__c = \'' + redemptionId + '\'';
                }
                Set<String> fields = new Set<String>();
                for(String s : OrganizationUtil.getFieldSet(component.FieldSet__c)){
                    fields.add(s);
                }
                List<sObject> aux = RedemptionData.getRedemptionItems(fields, null, null, null, component.Limit__c.intValue(), offset, whereCondition, orderBy);
                newData.addAll(aux);
            }
        }
    }
}