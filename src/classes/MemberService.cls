public with sharing class MemberService {
	
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
                        Id programId = FieloPLT.ProgramUtil.getProgramByDomain().Id;
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