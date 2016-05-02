public with sharing class RedemptionAPI {
	
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

                    if(c.ComponentLibrary__r.Name == 'RedemptionDetail'){
                        Id redemptionId = c.RecordId__c;
                        if(redemptionId != null){
                            newMapData.put(c.Id, RedemptionUtil.getRedemption(redemptionId, OrganizationUtil.getFieldSet(c.FieldSet__c)));
                        }else{
                            newMapData.put(c.Id, RedemptionUtil.getRedemptionRecord(MemberUtil.getLoggedMember(null), 'FrontEnd'));
                        }
                    }if(c.ComponentLibrary__r.Name == 'ShoppingCart'){
                        Redemption__c redemption = RedemptionUtil.getRedemptionRecord(MemberUtil.getLoggedMember(null), 'FrontEnd');
                        String whereCondition;
                        if(redemption.Id != null){
                            whereCondition = ' Redemption__c = \'' + redemption.Id + '\'';
                        }else{
                            whereCondition = ' Redemption__c = null';
                        }
                        List<RedemptionItem__c> redItems = RedemptionData.getRedemptionItems(new Set<String>{'Id','Reward__c'}, null, null, null, c.Limit__c.intValue(), 0, whereCondition, c.OrderBy__c);
                        if(redItems.size() > 0){
                            whereCondition = ' Id in (';
                            for(RedemptionItem__c ri : redItems){
                                whereCondition += '\'' + ri.Reward__c + '\',';
                            }
                            whereCondition = whereCondition.subStringBeforeLast(',');
                            whereCondition += ')';
                        }else{
                            whereCondition = ' Id = null';
                        }
                        newMapData.put(c.Id, RewardData.getRewards(OrganizationUtil.getFieldSet(c.FieldSet__c), program.Id, whereCondition, null, null, null, 0, null, null));
                    }
                }
            }
        }
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
}