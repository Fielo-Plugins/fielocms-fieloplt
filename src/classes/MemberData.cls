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
                        Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'OrganizationAccount__c','RecordType.DeveloperName'});
                        if(loggedMember.RecordType.DeveloperName != 'OrganizationAccount' && loggedMember.OrganizationAccount__c != null){
                        	newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c))).selectById(new Set<Id>{loggedMember.OrganizationAccount__c})[0]);
                        }else{
                        	newMapData.put(c.Id, null);
                        }
                    }else if(c.ComponentReference__c == 'MemberSelection'){
                    	Program__c program = new ProgramsSelector().selectBySiteUrl();
        	      		newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c))).selectRelatedMembers(UserInfo.getUserId(), program.Id));
                    }else if(c.ComponentReference__c == 'OrganizationMembers'){
        	      		Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'RecordType.DeveloperName'});
        	      		if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
        	      			newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieldSet__c))).selectByOrganizationAccount(loggedMember.Id));
        	      		}
                    }if(c.ComponentLibrary__r.Name == 'Register'){
                        newMapData.put(c.Id, new Member__c());
                    }else if(c.ComponentLibrary__r.Name == 'MemberDetail' || c.ComponentLibrary__r.Name == 'Account'){
                        newMapData.put(c.Id, MemberUtil.getLoggedMember(new List<String>{'Name', 'FirstName__c', 'LastName__c', 'Email__c', 'Points__c'}));
                    }if(c.ComponentLibrary__r.Name == 'RegisterStep2'){
                        Id memberId = c.RecordId__c;
                        newMapData.put(c.Id, MemberUtil.getAllFieldsMember(memberId));
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
            if(component.ComponentLibrary__r.Name == 'ContentFeed'){
                //FrontEndUtil.getNews(List<String> fields, Id componentId, String whereConditionQuery, Id tag, Id category, Integer quantity, Integer offset, String order){
                system.debug('component.Id ' + component.Id + ' tagId ' + tagId + ' categoryId ' + categoryId);
                List<sObject> aux = ContentFeedData.getNews(OrganizationUtil.getFieldSet(component.FieldSet__c), component.Id, null, tagId, categoryId, component.Limit__c.intValue(), offset, orderBy);
                newData.addAll(aux);
            }else if(component.ComponentLibrary__r.Name == 'ContentFeedWidget'){
                //FrontEndUtil.getNews(List<String> fields, Id componentId, String whereConditionQuery, Id tag, Id category, Integer quantity, Integer offset, String order)
                //newMapData.put(c.Id, FrontEndUtil.getNews(OrganizationUtil.getFieldSet(c.FieldSet__c), c.Id, null, c.Tag__c, c.Category__c, c.Limit__c.intValue(), 0, null));
                if(component.Category__c != null){
                    categoryId = component.Category__c;
                }
                if(component.Tag__c != null){
                    tagId = component.Tag__c;
                }

                system.debug('component.Id ' + component.Id + ' tagId ' + tagId + ' categoryId ' + categoryId);
                List<sObject> aux = ContentFeedData.getNews(OrganizationUtil.getFieldSet(component.FieldSet__c), component.Id, null, tagId, categoryId, component.Limit__c.intValue(), offset, orderBy);
                newData.addAll(aux);
            }
        }

        return newData;
    }

}