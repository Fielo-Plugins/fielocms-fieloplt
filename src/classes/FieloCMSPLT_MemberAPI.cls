global with sharing class FieloCMSPLT_MemberAPI implements FieloCMS.DataInterface, FieloCMS.ControlInterface, FieloCMS.ViewInterface{

    global ApexPages.Component getComponent(FieloCMS__Component__c component){
        if(component.FieloCMS__ComponentLibrary__r.Name == 'Register Step 2'){
            return new Component.FieloCMSPLT_RegisterStep2(config = component);
        }

        return null;
    }

    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.FieloCMS__ComponentLibrary__r.Name == 'Organization Account'){
                FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__OrganizationFieloCMSPLT_Account__c','FieloPLT__Type__c'});
                if(loggedMember.FieloPLT__Type__c != 'Organization Account' && loggedMember.FieloPLT__OrganizationAccount__c != null){
                    newMapData.put(c.Id, new FieloCMSPLT_MembersSelector(new Set<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectById(new Set<Id>{loggedMember.FieloPLT__OrganizationAccount__c})[0]);
                }else{
                    newMapData.put(c.Id, new FieloPLT__Member__c());
                }
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Member Selection'){
                FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();
                newMapData.put(c.Id, new FieloCMSPLT_MembersSelector(new Set<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectRelatedMembers(UserInfo.getUserId(), program.Id));
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Organization Members'){
                FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__Type__c'});
                if(loggedMember.FieloPLT__Type__c == 'Organization Account'){
                    newMapData.put(c.Id, new FieloCMSPLT_MembersSelector(new Set<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectByOrganizationAccount(loggedMember.Id));
                }else{
                    newMapData.put(c.Id, new List<FieloPLT__Member__c>());
                }
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Register'){
                newMapData.put(c.Id, new FieloPLT__Member__c());
            } else if(c.FieloCMS__ComponentLibrary__r.Name == 'Member Detail' || c.FieloCMS__ComponentLibrary__r.Name == 'Account' || c.FieloCMS__ComponentLibrary__r.Name == 'Welcome'){
                system.debug('member: ' + FieloCMSPLT_MemberService.getCurrentMember(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)));
                newMapData.put(c.Id, FieloCMSPLT_MemberService.getCurrentMember(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)));
            }
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component2, Integer pageNumber, String orderBy, String filters){
        return null;
    }

    global FieloCMS.RemoteActionResult remoteComponentAction(FieloCMS__Component__c component, sObject record, String json){
        Savepoint sp;
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        List<FieloCMS.RemoteActionResult.RemoteActionMessage> successMessages = new List<FieloCMS.RemoteActionResult.RemoteActionMessage>();

        try{
            sp = Database.setSavepoint();

            FieloPLT__Member__c member = (FieloPLT__Member__c)record;
            String registerType;
            if(UserInfo.getUserType() == 'Guest'){
                registerType = component.FieloCMSPLT_AccountCRMMode__c;
                if(registerType == 'Defined Account'){
                    member.FieloPLT__Account__c = component.FieloCMSPLT_Account__c;
                }
            }else{
                FieloPLT__Member__c loggedMember = FieloCMSPLT_MemberService.getCurrentMember(new Set<String>{'FieloPLT__Type__c','FieloPLT__OrganizationAccount__c'});
                if(loggedMember.FieloPLT__Type__c == 'Organization Account'){
                    registerType = 'Organization';
                    member.FieloPLT__OrganizationAccount__c = loggedMember.Id;
                    member.FieloPLT__Type__c = 'Organization Contributor';
                }
            }
            member.FieloPLT__Program__c = component.FieloCMSPLT_Program__c;
            FieloPLT.MemberService.register(member, registerType, component.FieloCMSPLT_AccountOwner__c);
            successMessages.add(new FieloCMS.RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.FieloCMSPLT_SucessRegistrationStep1 ));
        }catch(DmlException e){
            Database.rollback(sp);
            if(ApexPages.hasMessages()){
                result.redirectURL = '';
                for(ApexPages.Message m : ApexPages.getMessages()){
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
                }
            } else {
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
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
            /*if(String.isBlank(result.redirectUrl)){
                result.redirectUrl = '#';
            } */
        }

        return result;
    }

}
