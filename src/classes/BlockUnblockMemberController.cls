global with sharing class BlockUnblockMemberController implements FieloCMS.SubComponentInterface {

    public ApexPages.Component getSubComponent(Component__c config, Field field, SObject record){   
        Component.BlockUnblockMember blockUnblockMember = new Component.BlockUnblockMember();
        blockUnblockMember.config = config;
        blockUnblockMember.field = field;
        if(record != null){
            BlockUnblockMember.record = record;
        }else{
            BlockUnblockMember.expressions.record = '{!record}';
        }
        return BlockUnblockMember;
    }

    @RemoteAction
    global static RemoteActionResult blockUnblockMember(Id componentId, Id memberId, String action){
    	RemoteActionResult result = new RemoteActionResult();

    	try {
    		MemberService.blockUnblock(MemberService.getCurrentMemberId(), new List<Id>{memberId});
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.redirectURL = '#';
    	} catch(DMLException e) {
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e, componentId));
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