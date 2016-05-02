global with sharing class LikeController implements FieloCMS.SubComponentInterface{
    
    public ApexPages.Component getSubComponent(Component__c config, Field field, SObject record){
        Component.Like likeComponent = new Component.Like();
        if(record != null){
            likeComponent.record = record;
        }else{
            likeComponent.expressions.record = '{!record}';
        }
        likeComponent.field = field;
        likeComponent.config = config;
        likeComponent.relatedListName = 'Likes__r';
        return likeComponent;
    }

    @RemoteAction
    global static RemoteActionResult likeRec(Id parentId, String compReference, String likeValue ){
        RemoteActionResult result = new RemoteActionResult();
        try {
            ComponentsEnabled__c settings = [SELECT SObject__c FROM ComponentsEnabled__c WHERE Name =: compReference];
            Member__c member = MemberUtil.getLoggedMember(null);
            if ( doLikeIt(member.Id, parentId, settings.sObject__c) ) {
                result.refresh.add( new RemoteActionResult.RemoteActionRefresh('likeValue', 'true') );        
            } else {
                result.refresh.add( new RemoteActionResult.RemoteActionRefresh('likeValue', 'false' ) );
            }
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

    private static Boolean doLikeIt(Id memberId, String parentId, String objectName){        
        if(objectName == 'Reward__c'){
            List<Like__c> likes = [SELECT Id, Member__c, ParentId__c FROM Like__c WHERE Member__c =: memberId AND Reward__c =: parentId];
            if(likes.isEmpty()){
                insert new Like__c(Member__c = memberId , Reward__c = parentId);
                return true;
            }else{
                delete likes;
                return false;
            }
        }else if(objectName == 'News__c'){
            List<Like__c> likes = [SELECT Id, Member__c, ParentId__c FROM Like__c WHERE Member__c =: memberId AND News__c =: parentId];
            if(likes.isEmpty()){
                insert new Like__c(Member__c = memberId , News__c = parentId);
                return true;
            }else{
                delete likes;
                return false;
            }
        }

        return null;
    }

}