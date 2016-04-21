public class ControlReflectionDefault implements ControlInterface{
	
	public RemoteActionResult remoteComponentAction(Component__c component, sObject record, String preSubComponentsJson, String posSubComponentsJson){
        ComponentLibrary__c compReference = ComponentLibrary__c.getInstance(component.ComponentReference__c);
        
        Savepoint sp;

        RemoteActionResult result = new RemoteActionResult();
        List<RemoteActionResult.RemoteActionMessage> successMessages = new List<RemoteActionResult.RemoteActionMessage>();

        try{        
            List<Field> fieldSet = OrganizationUtil.getFieldsStructure(component, compReference.sObject__c);
            List<Field> preSubComponents = new List<Field>();
            List<Field> posSubComponents = new List<Field>();
            for(Field field : fieldSet){                    
                if(field.type == 'SubComponent'){
                    if(field.subtype == 'Pre'){
                        preSubComponents.add(field);
                    }else if(field.subtype == 'Post'){
                        posSubComponents.add(field);
                    }
                }
            }

            //PRE VALIDATIONS
            ControlUtil.analizePreSubComponents(preSubComponents, preSubComponentsJson, component);
            
            sp = Database.setSavepoint();

            if(component.ComponentReference__c == 'Register'){                
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
                //RegistrationUtil.register((Member__c)record);
                successMessages.add(new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SucessRegistrationStep1 ));
                /*if(ApexPages.currentPage().getParameters().get('retURL') != null){
                    result.redirectURL = ApexPages.currentPage().getParameters().get('retURL');
                }*/
            }else if(component.ComponentReference__c == 'RegisterStep2'){                
                Member__c member = (Member__c)record;
                //Member__c memberQuery = MemberUtil.getAllFieldsMember(member.Id);
                
                /*Boolean temporalPassword = true;
                for(Field field : fieldSet){                    
                    if(field.type == 'SubComponent'){
                        if(field.apiName == 'Password' && temporalPassword){
                            temporalPassword = false;
                        }                   
                    }else if(field.type != 'Multimedia' && !field.readOnly && field.isUpdateable){
                        memberQuery.put(field.apiName, member.get(field.apiName));
                    }
                }*/

                //Pagereference redirectPage = RegistrationUtil.finishRegistration(memberQuery, temporalPassword);
                MemberService.finishRegistration(member);
	            //record.put('User__c', memberQuery.User__c);
                /*if(temporalPassword){	                
	            	successMessages.add(new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SucessRegistrationOneStep));
	            } */           	
            }else if(component.ComponentReference__c == 'GetPoints'){                                
                Transaction__c trans = (Transaction__c)record;
                trans.Type__c = (component.TransactionType__c != null && component.TransactionType__c != '') ? component.TransactionType__c : 'Code Insert';
                CodeUtil.sendCode(trans);
                successMessages.add(new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SuccessGetPointsMessageSite ));
            }else{
                //set null values from the fieldset
                String attachmentField;
                for(Field field : fieldSet){                    
                    if(field.isUpdateable && record.get(field.apiName) == null){
                        record.put(field.apiName, null);
                    }
                }

                upsert record;                
            }
        	
            //POS ACTIONS
            ControlUtil.analizePosSubComponents(posSubComponents, posSubComponentsJson, record, component, result);
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