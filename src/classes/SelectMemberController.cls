global with sharing class SelectMemberController implements FieloCMS.SubComponentInterface {

    public ApexPages.Component getSubComponent(Field field, SObject record){
        Component.SelectMember selectMember = new Component.SelectMember();        
        selectMember.field = field;
        selectMember.type = field.apiName == 'LoginAsMember' ? 'Member' : 'Organization';
        if(record != null){
            selectMember.record = record;
        }else{
            selectMember.expressions.record = '{!record}';
        }
        return selectMember;
    }

    @RemoteAction
    global static RemoteActionResult selectMember(Id memberId, String type){        
        RemoteActionResult result = new RemoteActionResult();
        try{
        	if(type == 'Member'){
            	MemberUtil.setMemberId(memberId);
        	}else{
        		Member__c member = new MembersSelector(new Set<String>{'OrganizationAccount__c'}).selectById(new Set<Id>{memberId})[0];
        		MemberUtil.setMemberId(member.OrganizationAccount__c);
        	}

            result.redirectURL = '/Page';                                   
        }catch(FieloCustomException e){
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}