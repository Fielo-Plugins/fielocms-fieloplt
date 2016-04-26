global with sharing class ChangePasswordFieloController {

    @RemoteAction
    global static RemoteActionResult changePassword(String newPassword, String verifyNewPassword, String oldpassword){        
        RemoteActionResult result = new RemoteActionResult();                
        Pagereference redirectPage;
        try{
            if(oldpassword == '') oldpassword = null;
            redirectPage = Site.changePassword(newPassword, verifyNewPassword, oldpassword);
            Site__c site = SiteUtil.getSiteProgram(new List<String>{'MemberSelectionPage__c'});
            if(site.MemberSelectionPage__c != null){
                result.redirectURL = '/Page?pageId=' + site.MemberSelectionPage__c;
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