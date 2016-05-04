global with sharing class BlockUnblockMemberController implements CMSViewSubComponentInterface {

    public ApexPages.Component getSubComponent(CMSField field, SObject record){   
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
    global static CMSRemoteActionResult blockUnblockMember(Id memberId, String action){
    	CMSRemoteActionResult result = new CMSRemoteActionResult();

    	try {
    		FieloAlpha.MemberService.blockUnblock(new List<Id>{memberId}, action);
            result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.SuccessfulRemoteActionRefresh));
            result.refresh.add(new RemoteActionRefresh('action',action));
            result.redirectURL = '#';
    	} catch(DMLException e) {
            result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(ApexPages.Severity.Error, e.getDMLMessage(0)));
        } catch (Exception e){
            result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(e));
        }

    	if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new CMSRemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }
}