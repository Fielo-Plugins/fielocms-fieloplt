public with sharing class MemberData implements FieloCMS.DataInterface{
	
	public Map<Id, Object> getBulkData(List<Component__c> components){
        Map<String,ComponentsEnabled__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentReference__c != null){
                if(c.Qant__c == null)
                    c.Qant__c = 5;

                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentReference__c).Visibility__c)){
                    if(c.ComponentReference__c == 'MemberAccount'){
                        Member__c loggedMember = new MembersSelector(new Set<String>{'OrganizationAccount__c','RecordType.DeveloperName'}).selectLoggedMember();
                        if(loggedMember.RecordType.DeveloperName != 'OrganizationAccount' && loggedMember.OrganizationAccount__c != null){
                        	newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c))).selectById(new Set<Id>{loggedMember.OrganizationAccount__c})[0]);
                        }else{
                        	newMapData.put(c.Id, null);
                        }
                    }else if(c.ComponentReference__c == 'MemberSelection'){
                    	Site__c program = new ProgramsSelector().selectBySiteUrl();
        	      		newMapData.put(c.Id, getRelatedMembers(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c)), UserInfo.getUserId(), program.Id));
                    }else if(c.ComponentReference__c == 'OrganizationMembers'){
        	      		Member__c loggedMember = new MembersSelector(new Set<String>{'RecordType.DeveloperName'}).selectLoggedMember();
        	      		if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
        	      			newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c))).selectByOrganizationAccount(loggedMember.Id));
        	      		}
                    }
                }
            }
        }
        return newMapData;
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        List<SObject> newData = new List<SObject>();

        //Prepare all the queries
        if(component.ComponentReference__c != null){
            if(component.Qant__c == null)
                component.Qant__c = 5;

            //Calculate the offset from the Page Number
            Integer offset = Integer.valueOf(component.Qant__c * (pageNumber - 1));
            if(component.ComponentReference__c == 'MemberSelection'){
                Site__c program = new ProgramsSelector().selectBySiteUrl();
        	    MembersSelector selector = new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(component.FieldSet__c)));
        	    selector.setLimit(component.Qant__c.intValue());
        	    selector.setLimit(offset);
                newData.addAll((List<SObject>)selector.selectRelatedMembers(UserInfo.getUserId(), program.Id));
            }
        }

        return newData;
    }

}