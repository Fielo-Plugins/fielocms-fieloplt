global with sharing class TagAPI implements FieloCMS.ViewSubComponentInterface,FieloCMS.DataInterface{
	
	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        FieloPLT__Program__c program = ProgramService.getCurrentProgram();
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
                        
            newMapData.put(c.Id, FieloPLT.TagService.getTags(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), c.Tag__c, program.Id, MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c));
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
    
    global ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){        
        Component.Tag tag = new Component.Tag();
        if(record != null){
            tag.record = record;
        }else{
            tag.expressions.record = '{!record}';
        }
        tag.field = field;        
        //if(record.Id.getSObjectType() == Schema.FieloPLT__Reward__c.SObjectType){
            tag.relatedListName = 'FieloPLT__RewardTag__r';
        /*}else{
            tag.relatedListName = 'FieloPLT__TagItems__r';
        }*/
        return tag;        
        //return new Component.Apex.OutputText(value='test');
    }
}