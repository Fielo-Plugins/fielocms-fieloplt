global with sharing class FieloCMSPLT_ChangePwdCtrl {

    global String oldPassword {get; set;}
    global String newPassword {get; set;}
    global String verifyNewPassword {get; set;}

    global PageReference changePassword() {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult changePassword(String newPassword, String verifyNewPassword, String oldpassword){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();                
        Pagereference redirectPage;
        try{
            if(oldpassword == '') oldpassword = null;
            redirectPage = Site.changePassword(newPassword, verifyNewPassword, oldpassword);
            if(redirectPage != null){
                result.redirectURL = redirectPage.getUrl();
            }
        }catch(FieloCMSPLT_Exception e){
            result.redirectURL = '';
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