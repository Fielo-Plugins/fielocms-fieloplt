public with sharing class TransactionAPI implements FieloCMS.DataInterface, FieloCMS.ControlInterface{
	
	public Map<Id, Object> getBulkData(List<Component__c> components){
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        Map<String,ComponentLibrary__c> compSettingsMap = DataUtil.getComponentsEnabledMap(components);
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(Component__c c : components){
            if(c.ComponentLibrary__c != null){
                if(OrganizationUtil.showComponent(compSettingsMap.get(c.ComponentLibrary__c).Visibility__c)){
                    if(c.Limit__c == null)
                        c.Limit__c = 5;

                    if(c.ComponentLibrary__r.Name == 'GetPoints'){
                        newMapData.put(c.Id, new Transaction__c());
                    }else if(c.ComponentLibrary__r.Name == 'Transactions'){
                        newMapData.put(c.Id, TransactionData.getTransactions(OrganizationUtil.getFieldSet(c.FieldSet__c), null, null, null, c.Limit__c.intValue(), 0, null, c.OrderBy__c));
                    }
                }
            }
        }
    }

    public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
        //Set Category or Tag from FilterBy
        String categoryId;
        String tagId;
        if(filters != null){
            Map<String,Object> filtersMap = (Map<String,Object>) JSON.deserializeUntyped(filters);
            for(String s : filtersMap.keySet()){
                if(s == 'Category__c'){
                    categoryId = (String)filtersMap.get(s);
                }else if(s == 'Tag__c'){
                    tagId = (String)filtersMap.get(s);
                }
            }
        }

        String locale = 'EN';//OrganizationUtil.getLanguage();
        Site__c program = SiteUtil.getSiteProgram(new List<String>{'RewardView__c','NewsView__c','CustomPage__c', 'ShoppingCart__c'});
        List<SObject> newData = new List<SObject>();

        //Prepare all the queries
        if(component.ComponentLibrary__c != null){
            if(component.Limit__c == null)
                component.Limit__c = 5;

            //Calculate the offset from the Page Number
            Integer offset = Integer.valueOf(component.Limit__c * (pageNumber - 1));

            if(component.ComponentLibrary__r.Name == 'Transactions'){
                List<sObject> aux = TransactionData.getTransactions(OrganizationUtil.getFieldSet(component.FieldSet__c), null, null, null, component.Limit__c.intValue(), offset, null, orderBy);
                newData.addAll(aux);
            }
        }
    }
    
    public RemoteActionResult remoteComponentAction(Component__c component, sObject record){
        ComponentLibrary__c compReference = [SELECT Id, Name FROM ComponentLibrary__c WHERE Id =: component.ComponentReference__c];
        
        Savepoint sp;

        RemoteActionResult result = new RemoteActionResult();
        List<RemoteActionResult.RemoteActionMessage> successMessages = new List<RemoteActionResult.RemoteActionMessage>();

        try{                    
            sp = Database.setSavepoint();
            
            Transaction__c trans = (Transaction__c)record;
            trans.Type__c = (component.TransactionType__c != null && component.TransactionType__c != '') ? component.TransactionType__c : 'Code Insert';
            CodeUtil.sendCode(trans);
            successMessages.add(new RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SuccessGetPointsMessageSite ));            
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