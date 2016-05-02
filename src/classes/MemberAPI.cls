public with sharing class MemberData implements FieloCMS.DataInterface, FieloCMS.ControlInterface, FieloCMS.ViewInterface{
	
    public ApexPages.Component getComponent(Component__c c){
        if(OrganizationUtil.showComponent(compReference.Visibility__c)){
            if(c.ComponentReference__c == 'Login'){
                List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c.FieldSet__c);
                Component.SiteLoginFielo login = new Component.SiteLoginFielo(config = c);
                attachSubComponents(c, fieldSet, login);
                return login;
            }else if(c.ComponentReference__c == 'RegisterStep2'){
                List<Field> fieldSet = OrganizationUtil.getFieldsStructure(c, compReference.sObject__c);
                Component.RegisterStep2 register = new Component.RegisterStep2(config = c, fieldSet = fieldSet, compSettings = compReference);                
                register.record = (sObject)data;
                Component.Form form = new Component.Form(config = c, record = (sObject)data, fieldSet = fieldSet, compSettings = compReference);
                attachRecordSubComponents(c, fieldSet, form, (sObject)data, compReference.SObject__c);
                register.childcomponents.add(form);                
                return register;
            }else if(c.ComponentReference__c == 'OrganizationMembers'){
                Member__c loggedMember = new MembersSelector(new Set<String>{'RecordType.DeveloperName'}).selectLoggedMember();
                if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
                    Component.Apex.PanelGroup panelGroup = new Component.Apex.PanelGroup();
                    panelGroup.childcomponents.add(getListComponent(c, data, compReference));
                    Program__c program = new ProgramsSelector(new Set<String>{'RegisterPage__c'}).selectBySiteUrl();
                    Component.Link link = new Component.Link(url = '/Page?pageId=' + c.MenuRedirect__c + '&retURL=' + ApexPages.currentPage().getUrl());
                    link.childcomponents.add(new Component.Apex.OutputText(value = Label.Invite));
                    panelGroup.childcomponents.add(link);
                    return panelGroup;
                }

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

                List<sObject> aux = ContentFeedData.getNews(OrganizationUtil.getFieldSet(component.FieldSet__c), component.Id, null, tagId, categoryId, component.Limit__c.intValue(), offset, orderBy);
                newData.addAll(aux);
            }
        }

        return newData;
    }
    
    public RemoteActionResult remoteComponentAction(Component__c component, sObject record){
        
        ComponentLibrary__c compReference = [SELECT Id, Name FROM ComponentLibrary__c WHERE Id =: component.ComponentReference__c];
        
        Savepoint sp;

        RemoteActionResult result = new RemoteActionResult();
        List<RemoteActionResult.RemoteActionMessage> successMessages = new List<RemoteActionResult.RemoteActionMessage>();

        try{                    
            sp = Database.setSavepoint();

            if(compReference.Name == 'Register'){
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
            }else if(component.ComponentReference__c == 'RegisterStep2'){                
                Member__c member = (Member__c)record;                
                MemberService.finishRegistration(member);                
            }            
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