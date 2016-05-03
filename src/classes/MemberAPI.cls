public with sharing class MemberData implements FieloCMS.DataInterface, FieloCMS.ControlInterface, FieloCMS.ViewInterface{
	
    public ApexPages.Component getComponent(Component__c c){
        if(OrganizationUtil.showComponent(compReference.Visibility__c)){
            if(c.ComponentReference__c == 'Login'){                
                Component.SiteLoginFielo login = new Component.SiteLoginFielo(config = c);
                return login;
            }else if(c.ComponentReference__c == 'RegisterStep2'){
                List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
                Component.RegisterStep2 register = new Component.RegisterStep2(config = c, fieldSet = fieldSet);                
                return register;
            }
        }

        return null;
    }
    
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
                    }
                }
            }
        }
        return newMapData;
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
    
    public RemoteActionResult remoteComponentAction(Component__c component, sObject record){
        
        ComponentLibrary__c compReference = [SELECT Id, Name FROM ComponentLibrary__c WHERE Id =: component.ComponentReference__c];
        
        Savepoint sp;

        RemoteActionResult result = new RemoteActionResult();
        List<RemoteActionResult.RemoteActionMessage> successMessages = new List<RemoteActionResult.RemoteActionMessage>();

        try{                    
            sp = Database.setSavepoint();

            Member__c member = (Member__c)record;
            String registerType;
            if(UserInfo.getUserType() == 'Guest'){
                registerType = component.AccountCRMMode__c;
                if(registerType == 'Defined Account'){
                    member.Account__c = component.Account__c;
                }               
            }else{
                Member__c loggedMember = new MembersSelector(new Set<String>{'RecordType.DeveloperName','OrganizationAccount__c'}).selectLoggedMember();
                if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
                    registerType = 'Organization';
                    member.OrganizationAccount__c = loggedMember.Id;
                    RecordType contributorRT = [SELECT Id FROM RecordType WHERE DeveloperName = 'OrganizationContributor'];
                    member.RecordTypeId = contributorRT.Id;
                }
            }
            member.Site__c = component.Menu__r.Site__c;
            MemberService.register(member, registerType, component.AccountOwner__c);
            successMessages.add(new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SucessRegistrationStep1 ));                                  
        }catch(DmlException e){            
            Database.rollback(sp);
            if(ApexPages.hasMessages()){
                result.redirectURL = '';
                for(ApexPages.Message m : ApexPages.getMessages()){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
                }
            }
            return result;
        }catch(Exception e){
            if(sp != null){
                Database.rollback(sp);
            }
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
            return result;
        }

        if(!successMessages.isEmpty()){            
            result.addMessages(successMessages);            
        }

        return result;
    }

}