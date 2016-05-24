global with sharing class BlockUnblockMemberController implements FieloCMS.ViewSubComponentInterface {

    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){   
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
    global static FieloCMS.RemoteActionResult blockUnblockMember(Id memberId, String action){
    	FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();

    	try {
    		FieloAlpha.MemberService.blockUnblock(new List<Id>{memberId}, action);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.refresh.add(new FieloCMS.RemoteActionResult.RemoteActionRefresh('action',action));
            result.redirectURL = '#';
    	} catch(DMLException e) {
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
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