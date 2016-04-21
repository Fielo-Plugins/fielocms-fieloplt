trigger Like2 on Like__c (after insert, before delete) {
    
    if(Trigger.isInsert){
        CommentLikeTrigger.processLikes(Trigger.New,true);
    }else{
        CommentLikeTrigger.processLikes(Trigger.Old,false);
    }
    
}