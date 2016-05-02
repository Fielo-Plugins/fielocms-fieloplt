public with sharing class TagData {
	

    public Map<Id, Object> getBulkData(List<Component__c> components){
        Map<String,ComponentLibrary__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentReference__c != null){
                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentReference__c).Visibility__c)){
                    if(c.Qant__c == null)
                        c.Qant__c = 5;

                    if(c.ComponentLibrary__r.Name == 'FilterByTags'){
                        newMapData.put(c.Id, TagData.getTags(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Tag__c, program.Id, c.Limit__c.intValue(), 0, c.OrderBy__c));
                    }
                }
            }
        }
        return newMapData;
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
}