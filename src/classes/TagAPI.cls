public with sharing class TagAPI implements FieloCMS.ViewSubComponentInterface,FieloCMS.DataInterface{
	
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
    
    public ApexPages.Component getSubComponent(Field field, SObject record){        
        Component.Tag tag = new Component.Tag();
        if(record != null){
            tag.record = record;
        }else{
            tag.expressions.record = '{!record}';
        }
        tag.field = field;
        String objectName = Describe_de(parentId.subString(0,3));
        if(objectName == 'Reward__c'){
            tag.relatedListName = 'RewardTag__r';
        }else{
            tag.relatedListName = 'TagItems__r';
        }
        return tag;        
    }
}