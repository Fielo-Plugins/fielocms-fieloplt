//NO DOCUMENT
global with sharing class LikeController {
    
    @RemoteAction
    global static RemoteActionResult likeRec(Id parentId, String compReference, String likeValue ){
        RemoteActionResult result = new RemoteActionResult();
        try {
            ComponentsEnabled__c settings = [SELECT SObject__c FROM ComponentsEnabled__c WHERE Name =: compReference];
            Member__c member = MemberUtil.getLoggedMember(null);
            if ( MemberUtil.doLikeIt(member.Id, parentId, settings.sObject__c) ) {
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

}