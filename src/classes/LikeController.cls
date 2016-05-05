global with sharing class LikeController implements FieloCMS.ViewSubComponentInterface{
    
    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
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
    global static FieloCMS.RemoteActionResult likeRec(Id parentId, String action){
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try {
            doLikeIt(MemberService.getCurrentMemberId(), parentId, Boolean.valueOf(action));
            result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh('likeValue', action) );
            result.refresh.add( new FieloCMS.RemoteActionResult.RemoteActionRefresh( 'action', String.valueOf(!Boolean.valueOf(action))));
        } catch(FieloCustomException e){
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

    private static void doLikeIt(Id memberId, Id parentId, Boolean action){        
        if(parentId.getSObjectType() == Schema.FieloAlpha__Reward__c.SObjectType){
            if(action){
                insert new FieloAlpha__Like__c(FieloAlpha__Member__c = memberId , FieloAlpha__Reward__c = parentId);
            }else{
                delete [SELECT Id FROM FieloAlpha__Like__c WHERE FieloAlpha__Member__c =: memberId AND FieloAlpha__Reward__c =: parentId];
            }
        }else{
            if(action){
                insert new FieloAlpha__Like__c(FieloAlpha__Member__c = memberId , FieloAlpha__News__c = parentId);
            }else{
                delete [SELECT Id FROM FieloAlpha__Like__c WHERE FieloAlpha__Member__c =: memberId AND FieloAlpha__News__c =: parentId];
            }            
        }
    }

}