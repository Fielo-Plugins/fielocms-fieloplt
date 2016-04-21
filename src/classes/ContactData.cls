public with sharing class ContactData implements FieloCMS.DataInterface{
	
	public Map<Id, Object> getBulkData(List<Component__c> components){
        Map<String,ComponentLibrary__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentReference__c != null){
                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentReference__c).Visibility__c)){
                    if(c.Qant__c == null)
                        c.Qant__c = 5;

                    if(c.ComponentReference__c == 'InviteContacts'){
                        Member__c loggedMember = MemberService.getLoggedMember(new Set<String>{'Account__c'});
                        newMapData.put(c.Id, ContactService.getUnregisteredContacts(loggedMember.Account__c, null, c.Qant__c.intValue(), c.OrderBy__c));
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
            //Calculate the offset from the Page Number
            Integer offset = Integer.valueOf(component.Qant__c * (pageNumber - 1));
            if(component.ComponentReference__c == 'InviteContacts'){
            	Member__c loggedMember = MemberService.getLoggedMember(new Set<String>{'Account__c'});
                newMapData.put(c.Id, ContactService.getUnregisteredContacts(loggedMember.Account__c, offset, c.Qant__c.intValue(), c.OrderBy__c));                
            }
        }

        return newData;
    }

}