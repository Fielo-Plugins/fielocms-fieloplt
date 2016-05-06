public with sharing class MemberService {
	
	public static FieloAlpha__Member__c getCurrentMember(Set<String> fields){
        return new MembersSelector(fields).selectById(new Set<Id>{getCurrentMemberId()})[0];
    }

    private static Id memId;
    public static Id getCurrentMemberId(){        
        if(UserInfo.getUserType() == 'Guest')
            return null;

        Cookie memberCookie = ApexPages.currentPage().getCookies().get('memberId');
        Cookie sessionIdCookie = ApexPages.currentPage().getCookies().get('sessionMemberId');
        if(memberCookie != null && sessionIdCookie != null && (sessionIdCookie.getValue() == UserInfo.getSessionId())){        
            return (Id)memberCookie.getValue();
        }else if(memId == null){
            try{
                List<FieloAlpha__Member__c> members = [SELECT Id, FieloAlpha__Program__c FROM FieloAlpha__Member__c WHERE FieloAlpha__User__c =: UserInfo.getUserId()];
                if(members.size() == 1){
                    memId = members[0].Id;
                    setCurrentMemberId(memId);
                }else{
                    Id programId = FieloAlpha.ProgramUtil.getProgramByDomain().Id;
                    for(FieloAlpha__Member__c m : members){
                        if(m.FieloAlpha__Program__c == programId){
                            memId = m.Id;
                            setCurrentMemberId(memId);
                            break;
                        }
                    }
                }
            }catch(Exception e){
                return null;
            }
        }
        return memId;
    }

    public static void setCurrentMemberId(Id memberId){
        ApexPages.currentPage().setCookies(new Cookie[]{new Cookie('memberId', memberId, null, -1,true),new Cookie('sessionMemberId', UserInfo.getSessionId(), null, -1,false)});
    }

    public static PageReference setPasswordAndLogin(Id memberId, String password){
        if(memberId == null){
            throw new FieloCustomException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloCustomException(Label.PasswordIsRequired);
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
            throw new FieloCustomException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloCustomException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            FieloAlpha__Member__c member = new MembersSelector().selectById(new Set<Id>{memberId})[0];
            User user = [SELECT UserName FROM User WHERE Id =: member.FieloAlpha__User__c LIMIT 1];
            return Site.login(user.UserName, password, null);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

    public static void setPassword(Id memberId, String password){
        if(memberId == null){
            throw new FieloCustomException(Label.MemberIdRequired);
        }else if(String.isBlank(password)){
            throw new FieloCustomException(Label.PasswordIsRequired);
        }
        Savepoint sp = Database.setSavepoint();
        try{
            FieloAlpha__Member__c member = new MembersSelector(new Set<String>{'FieloAlpha__User__c'}).selectById(new Set<Id>{memberId})[0];
            system.setPassword(member.FieloAlpha__User__c, password);
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

}