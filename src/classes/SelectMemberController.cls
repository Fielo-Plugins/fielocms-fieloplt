global with sharing class SelectMemberController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
        Component.SelectMember selectMember = new Component.SelectMember();        
        selectMember.field = field;
        if(record != null){
            selectMember.record = (FieloAlpha__Member__c)record;
        }else{
            selectMember.expressions.record = '{!record}';
        }
        return selectMember;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult selectMember(Id memberId, String type){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try{
        	if(type == 'Member'){
            	MemberService.setCurrentMemberId(memberId);
                //recalculate segments for the new member
                FieloAlpha.SegmentService.getMemberSegments(memberId, null);
            }else{
                FieloAlpha__Member__c member = new MembersSelector(new Set<String>{'FieloAlpha__OrganizationAccount__c'}).selectById(new Set<Id>{memberId})[0];
                MemberService.setCurrentMemberId(member.FieloAlpha__OrganizationAccount__c);
                //recalculate segments for the new member
                FieloAlpha.SegmentService.getMemberSegments(member.FieloAlpha__OrganizationAccount__c, null);
            }
            
            result.redirectURL = '/';                                   
        }catch(FieloCustomException e){
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}