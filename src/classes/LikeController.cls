global with sharing class LikeController implements FieloCMS.SubComponentInterface{
    
    public ApexPages.Component getSubComponent(Field field, SObject record){
        Component.Like likeComponent = new Component.Like();
        if(record != null){
            likeComponent.record = record;
        }else{
            likeComponent.expressions.record = '{!record}';
        }
        likeComponent.field = field;        
        return likeComponent;
    }

    @RemoteAction
    global static RemoteActionResult likeRec(Id parentId, String action){
        RemoteActionResult result = new RemoteActionResult();
        try {
            doLikeIt(MemberService.getCurrentMemberId(), parentId, Boolean.valueOf(action));
            result.refresh.add( new RemoteActionResult.RemoteActionRefresh('likeValue', action) );
            result.refresh.add( new RemoteActionResult.RemoteActionRefresh( 'action', String.valueOf(!Boolean.valueOf(action)) );
        } catch(FieloCustomException e){
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

    private static void doLikeIt(Id memberId, Id parentId, Boolean like){        
        if(parentId.getSObjectType() == Schema.Reward__c.SObjectType)
            if(like){
                insert new Like__c(Member__c = memberId , Reward__c = parentId);
            }else{
                delete [SELECT Id FROM Like__c WHERE Member__c =: memberId AND Reward__c =: parentId];
            }
        }else{
            if(like){
                insert new Like__c(Member__c = memberId , News__c = parentId);
            }else{
                delete [SELECT Id FROM Like__c WHERE Member__c =: memberId AND News__c =: parentId];
            }            
        }
    }

}