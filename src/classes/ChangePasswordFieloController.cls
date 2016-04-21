//NO DOCUMENT
/**
* @author Matias Trionfetti
* @date   13/07/2011
* @description  Class is used to change password in the site
*/
global with sharing class ChangePasswordFieloController {

    @RemoteAction
    global static RemoteActionResult changePassword(String newPassword, String verifyNewPassword, String oldpassword){        
        RemoteActionResult result = new RemoteActionResult();                
        Pagereference redirectPage;
        try{
            if(oldpassword == '') oldpassword = null;
            redirectPage = Site.changePassword(newPassword, verifyNewPassword, oldpassword);
            Site__c program = SiteUtil.getSiteProgram(new List<String>{'MemberSelectionPage__c'});
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

    ///DEPRECATED
    global static testmethod void testChangePasswordController(){}
}