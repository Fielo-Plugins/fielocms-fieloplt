public with sharing class MemberService {
	
	public static FieloAlpha__Member__c getCurrentMember(Set<String> fields){
        return new MembersSelector(fields).selectById(new Set<Id>{getMemberId()});
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
                List<Member__c> members = [SELECT Id, FieloAlpha__Program__c FROM FieloAlpha__Member__c WHERE User__c =: UserInfo.getUserId()];
                if(members.size() == 1){
                    memId = members[0].Id;
                    setCurrentMemberId(memId);
                }else{
                    Id programId = ProgramUtil.getProgramByDomain().Id;
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

}