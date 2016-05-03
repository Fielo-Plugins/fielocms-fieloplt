global with sharing class BlockUnblockMemberController implements FieloCMS.SubComponentInterface {

    public ApexPages.Component getSubComponent(Field field, SObject record){   
        Component.BlockUnblockMember blockUnblockMember = new Component.BlockUnblockMember();        
        blockUnblockMember.field = field;
        if(record != null){
            BlockUnblockMember.record = record;
        }else{
            BlockUnblockMember.expressions.record = '{!record}';
        }
        return BlockUnblockMember;
    }

    @RemoteAction
    global static RemoteActionResult blockUnblockMember(Id memberId, String action){
    	RemoteActionResult result = new RemoteActionResult();

    	try {
    		FieloAlpha.MemberService.blockUnblock(new List<Id>{memberId}, action);
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.redirectURL = '#';
    	} catch(DMLException e) {
            result.addMessage(new RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
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