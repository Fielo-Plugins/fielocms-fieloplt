public with sharing class FieloCMSPLT_MemberService {

	public static FieloPLT__Member__c getCurrentMember(Set<String> fields){
        return new FieloCMSPLT_MembersSelector(fields).selectById(new Set<Id>{getCurrentMemberId()})[0];
    }

    private static Id memId;
    public static Id getCurrentMemberId(){
        if(UserInfo.getUserType() == 'Guest')
            return null;

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
                        Id programId = ProgramService.getProgramByDomain().Id;
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
        //return 'a0D41000000y2fM';
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


    public static PageReference login(Id memberId, String password){
        if(memberId == null){
            throw new FieloException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            FieloPLT__Member__c member = new FieloCMSPLT_MembersSelector().selectById(new Set<Id>{memberId})[0];
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
            FieloPLT__Member__c member = new FieloCMSPLT_MembersSelector(new Set<String>{'FieloPLT__User__c'}).selectById(new Set<Id>{memberId})[0];
            system.setPassword(member.FieloPLT__User__c, password);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

}