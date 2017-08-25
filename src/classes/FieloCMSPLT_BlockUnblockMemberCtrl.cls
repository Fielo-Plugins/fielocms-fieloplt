global class FieloCMSPLT_BlockUnblockMemberCtrl implements FieloCMS.ViewSubComponentInterface {

    global ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){   
        Component.FieloCMSPLT_BlockUnblockMember blockUnblockMember = new Component.FieloCMSPLT_BlockUnblockMember();        
        blockUnblockMember.field = field;
        if(record != null){
            blockUnblockMember.record = record;
        }else{
            blockUnblockMember.expressions.record = '{!record}';
        }
        return blockUnblockMember;
    }
    
    @RemoteAction
    global static FieloCMS.RemoteActionResult FieloCMSPLT_blockUnblockMember(Id memberId, String action){
    	FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();

    	try {
    		FieloPLT.MemberService.blockUnblock(new List<Id>{memberId}, action);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.CONFIRM, Label.FieloCMSPLT_SuccessfulRemoteActionRefresh));
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