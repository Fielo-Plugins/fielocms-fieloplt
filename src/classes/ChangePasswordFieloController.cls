global with sharing class ChangePasswordFieloController {

    global String oldPassword {get; set;}
    global String newPassword {get; set;}
    global String verifyNewPassword {get; set;}

    global PageReference changePassword() {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);
    }

    @RemoteAction
    global static RemoteActionResult changePassword(String newPassword, String verifyNewPassword, String oldpassword){        
        RemoteActionResult result = new RemoteActionResult();                
        Pagereference redirectPage;
        try{
            if(oldpassword == '') oldpassword = null;
            redirectPage = Site.changePassword(newPassword, verifyNewPassword, oldpassword);
            Program__c program = new ProgramsSelector(new Set<String>{'MemberSelectionPage__c'}).selectBySiteUrl(Site.getDomain());
            if(program.MemberSelectionPage__c != null){
                result.redirectURL = '/Page?pageId=' + program.MemberSelectionPage__c;
            } else if(redirectPage != null){
                result.redirectURL = redirectPage.getUrl();
            }
        }catch(FieloCustomException e){
            result.redirectURL = '';
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