public with sharing class MemberService implements FieloCMS.DataInterface, FieloCMS.ControlInterface, FieloCMS.ViewInterface{
	
    public ApexPages.Component getComponent(FieloCMS__Component__c component){                                
        if(component.FieloCMS__ComponentLibrary__r.Name == 'Platform Login'){                    
            return new Component.SiteLoginFielo(config = component);            
        }else if(component.FieloCMS__ComponentLibrary__r.Name == 'Register Step 2'){                    
            return new Component.RegisterStep2(config = component);                            
        }
        
        return null;
    }
    
    public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            if(c.FieloCMS__ComponentLibrary__r.Name == 'Organization Account'){
                FieloPLT__Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'FieloPLT__OrganizationAccount__c','RecordType.DeveloperName'});
                if(loggedMember.RecordType.DeveloperName != 'OrganizationAccount' && loggedMember.FieloPLT__OrganizationAccount__c != null){
                    newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectById(new Set<Id>{loggedMember.FieloPLT__OrganizationAccount__c})[0]);
                }else{
                    newMapData.put(c.Id, new FieloPLT__Member__c());
                }
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Member Selection'){
                FieloPLT__Program__c program = ProgramService.getCurrentProgram();
                newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectRelatedMembers(UserInfo.getUserId(), program.Id));
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Organization Members'){
                FieloPLT__Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'RecordType.DeveloperName'});
                if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
                    newMapData.put(c.Id, new MembersSelector(new Set<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))).selectByOrganizationAccount(loggedMember.Id));
                }else{
                    newMapData.put(c.Id, new List<FieloPLT__Member__c>());
                }
            }else if(c.FieloCMS__ComponentLibrary__r.Name == 'Register'){
                newMapData.put(c.Id, new FieloPLT__Member__c());
            } else if(c.FieloCMS__ComponentLibrary__r.Name == 'Member Detail' || c.FieloCMS__ComponentLibrary__r.Name == 'Account'){
                newMapData.put(c.Id, MemberService.getCurrentMember(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)));
            }
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component2, Integer pageNumber, String orderBy, String filters){
        return null;
    }
    
    public FieloCMS.RemoteActionResult remoteComponentAction(FieloCMS__Component__c component, sObject record, String json){        
        Savepoint sp;
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        List<FieloCMS.RemoteActionResult.RemoteActionMessage> successMessages = new List<FieloCMS.RemoteActionResult.RemoteActionMessage>();

        try{                    
            sp = Database.setSavepoint();

            FieloPLT__Member__c member = (FieloPLT__Member__c)record;
            String registerType;
            if(UserInfo.getUserType() == 'Guest'){
                registerType = component.AccountCRMMode__c;
                if(registerType == 'Defined Account'){
                    member.FieloPLT__Account__c = component.Account__c;
                }               
            }else{
                FieloPLT__Member__c loggedMember = MemberService.getCurrentMember(new Set<String>{'RecordType.DeveloperName','FieloPLT__OrganizationAccount__c'});
                if(loggedMember.RecordType.DeveloperName == 'OrganizationAccount'){
                    registerType = 'Organization';
                    member.FieloPLT__OrganizationAccount__c = loggedMember.Id;
                    RecordType contributorRT = [SELECT Id FROM RecordType WHERE DeveloperName = 'OrganizationContributor'];
                    member.RecordTypeId = contributorRT.Id;
                }
            }
            member.FieloPLT__Program__c = component.Program__c;
            FieloPLT.MemberService.register(member, registerType, component.AccountOwner__c);
            successMessages.add(new FieloCMS.RemoteActionResult.RemoteActionMessage( ApexPages.Severity.Info, Label.SucessRegistrationStep1 ));                                  
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
            /*if(String.isBlank(result.redirectUrl)){
                result.redirectUrl = '#';                
            } */           
        }

        return result;
    }
    
	public static FieloPLT__Member__c getCurrentMember(Set<String> fields){
        return new MembersSelector(fields).selectById(new Set<Id>{getCurrentMemberId()})[0];
    }

    private static Id memId;
    public static Id getCurrentMemberId(){        
        if(UserInfo.getUserType() == 'Guest')
            return null;

        /*Cookie memberCookie = ApexPages.currentPage().getCookies().get('memberId');
        Cookie sessionIdCookie = ApexPages.currentPage().getCookies().get('sessionMemberId');
        if(memberCookie != null && sessionIdCookie != null && (sessionIdCookie.getValue() == UserInfo.getSessionId())){        
            return (Id)memberCookie.getValue();
        }else if(memId == null){
            try{
                List<FieloPLT__Member__c> members = [SELECT Id, FieloPLT__Program__c FROM FieloPLT__Member__c WHERE FieloPLT__User__c =: UserInfo.getUserId()];
                if(members.size() == 1){
                    memId = members[0].Id;
                    setCurrentMemberId(memId);
                }else{
                    Id programId = FieloPLT.ProgramUtil.getProgramByDomain().Id;
                    for(FieloPLT__Member__c m : members){
                        if(m.FieloPLT__Program__c == programId){
                            memId = m.Id;
                            setCurrentMemberId(memId);
                            break;
                        }
                    }
                }
            }catch(Exception e){
                return null;
            }
        }*/


        if(memId == null){
            SessionCache__c sessionCache = SessionCache__c.getInstance(UserInfo.getUserId());
            if((sessionCache.SessionId__c == UserInfo.getSessionId() || UserInfo.getUserType() == 'Standard') && sessionCache.MemberId__c != null){
                memId = sessionCache.MemberId__c;
            }else{
                try{
                    List<FieloPLT__Member__c> members = [SELECT Id, FieloPLT__Program__c FROM FieloPLT__Member__c WHERE FieloPLT__User__c =: UserInfo.getUserId()];
                    if(members.size() == 1){
                        memId = members[0].Id;
                    }else{
                        Id programId = new ProgramsSelector(new List<String>()).getProgramByDomain().Id;
                        for(FieloPLT__Member__c m : members){
                            if(m.FieloPLT__Program__c == programId){
                                memId = m.Id;
                                break;
                            }
                        }

                    }
                }catch(Exception e){
                    return null;
                }
            }
        }

        return memId;
    }

    public static void setCurrentMemberId(Id memberId){
        //ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('memberId', memberId, null, -1,true),new Cookie('sessionMemberId', UserInfo.getSessionId(), null, -1,false)});

        SessionCache__c sessionCache = SessionCache__c.getInstance(UserInfo.getUserId());
        sessionCache.SessionId__c = UserInfo.getSessionId();
        sessionCache.MemberId__c = memberId;        
        upsert sessionCache;
    }

    public static PageReference setPasswordAndLogin(Id memberId, String password){
        if(memberId == null){
            throw new FieloException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            setPassword(memberId, password);
            return login(memberId, password);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

    public static PageReference getAgreementPage(Id memberId){
        PageReference agreementPage;
        /*Cookie memberCookie = ApexPages.currentPage().getCookies().get('agreementAccepted');
        if(memberCookie == null || String.isBlank(memberCookie.getValue()) || memberCookie.getValue() != 'true'){*/
            FieloPLT__Member__c member = [SELECT Id, FieloPLT__Agreement__r.FieloPLT__Status__c, FieloPLT__Program__r.FieloPLT__UseAgreement__c FROM FieloPLT__Member__c WHERE Id =: memberId limit 1];            
            if(member.FieloPLT__Program__r.FieloPLT__UseAgreement__c && member.FieloPLT__Agreement__r.FieloPLT__Status__c != 'Current'){
                agreementPage = Page.AgreementAccept;
                agreementPage.getParameters().put('retUrl','');
            }
        //}
        return agreementPage;
    }

    public static PageReference login(Id memberId, String password){
        if(memberId == null){
            throw new FieloException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            FieloPLT__Member__c member = new MembersSelector().selectById(new Set<Id>{memberId})[0];
            User user = [SELECT UserName FROM User WHERE Id =: member.FieloPLT__User__c LIMIT 1];
            return Site.login(user.UserName, password, null);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

    public static void setPassword(Id memberId, String password){
        if(memberId == null){
            throw new FieloException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            FieloPLT__Member__c member = new MembersSelector(new Set<String>{'FieloPLT__User__c'}).selectById(new Set<Id>{memberId})[0];
            system.setPassword(member.FieloPLT__User__c, password);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

}