trigger Comment on Comment__c (after insert, after update, before delete) {
    
    if(Trigger.isInsert){
        CommentLikeTrigger.processComments(Trigger.New,true);
    }else if(Trigger.isUpdate){
        List<Comment__c> summarizeComments = new List<Comment__c>();
        List<Comment__c> restComments = new List<Comment__c>();
        for(Integer i = 0 ; i < Trigger.New.size() ; i++){
            if(!CommentLikeTrigger.processedCommentIds.contains(Trigger.new[i].Id)){
                if(Trigger.new[i].Status__c == 'Ok' && Trigger.old[i].Status__c != 'Ok'){
                    summarizeComments.add(Trigger.new[i]);
                    CommentLikeTrigger.processedCommentIds.add(Trigger.new[i].Id);
                }else if(Trigger.new[i].Status__c != 'Ok' && Trigger.old[i].Status__c == 'Ok'){
                    restComments.add(Trigger.new[i]);
                    CommentLikeTrigger.processedCommentIds.add(Trigger.new[i].Id);
                }                
            }
        }
        
        if(!summarizeComments.isEmpty()){
            CommentLikeTrigger.processComments(summarizeComments,true);
        }
        
        if(!restComments.isEmpty()){
            CommentLikeTrigger.processComments(restComments,false);
        }
    }else{
        CommentLikeTrigger.processComments(Trigger.Old,false);
    }
    
}