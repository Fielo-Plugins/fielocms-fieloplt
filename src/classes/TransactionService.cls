global with sharing class TransactionService implements FieloCMS.DataInterface, FieloCMS.ControlInterface{
	
	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.FieloCMS__ComponentLibrary__r.Name == 'Get Points'){
                newMapData.put(c.Id, new FieloPLT__Transaction__c());
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Transactions'){
                Id memberId = MemberService.getCurrentMemberId();
                String query = 'SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__Transaction__c WHERE FieloPLT__Member__c =: memberId';
                query += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
                newMapData.put(c.Id, Database.query(query));
            }                
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));                
        Id memberId = MemberService.getCurrentMemberId();
        String query = 'SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPLT__Transaction__c WHERE FieloPLT__Member__c =: memberId';
        query += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        query += ' OFFSET ' + String.valueOf(offset);
        return Database.query(query);
    }
    
    public FieloCMS.RemoteActionResult remoteComponentAction(FieloCMS__Component__c component, sObject record, String json){
        
        Savepoint sp;

        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        List<FieloCMS.RemoteActionResult.RemoteActionMessage> successMessages = new List<FieloCMS.RemoteActionResult.RemoteActionMessage>();

        try{                    
            sp = Database.setSavepoint();
            
            FieloPLT__Transaction__c trans = (FieloPLT__Transaction__c)record;
            //se comenta porque el code insert pasa a una solution
            //trans.FieloPLT__Type__c = (component.TransactionType__c != null && component.TransactionType__c != '') ? component.TransactionType__c : 'Code Insert';
            trans.FieloPLT__Member__c = MemberService.getCurrentMemberId();
            //se comenta porque el code insert pasa a una solution
            //FieloPLT.CodeUtil.sendCode(trans);
            successMessages.add(new FieloCMS.RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, 'Success'));            
        }catch(DmlException e){            
            Database.rollback(sp);
            if(ApexPages.hasMessages()){
                result.redirectURL = '';
                for(ApexPages.Message m : ApexPages.getMessages()){
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
                }
            }
            return result;
        }catch(Exception e){
            if(sp != null){
                Database.rollback(sp);
            }
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
            return result;
        }

        if(!successMessages.isEmpty()){            
            result.addMessages(successMessages);            
        }

        return result;
    }
}