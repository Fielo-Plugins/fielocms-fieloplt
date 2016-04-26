public with sharing class TagView implements FieloCMS.ViewInterface{
	
	public ApexPages.Component getComponent(Component__c c, Object data, ComponentsEnabled__c compReference){
		return null;
	}

    public ApexPages.Component getSubComponent(Component__c config, Field field, SObject record){
        if(field.apiName == 'Tag'){
            Component.Tag tag = new Component.Tag();
            if(record != null){
                tag.record = record;
            }else{
                tag.expressions.record = '{!record}';
            }
            tag.field = field;
            tag.config = config;
            if(config.ComponentReference__c == 'Catalog'){
                tag.relatedListName = 'RewardTag__r';
            }else{
                tag.relatedListName = 'TagItems__r';
            }
            return tag;
        }
    }

}