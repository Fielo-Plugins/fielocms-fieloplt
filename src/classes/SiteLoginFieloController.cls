global with sharing class SiteLoginFieloController {
    
    @RemoteAction
    global static FieloCMS.RemoteActionResult login(String userName, String password){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();                
        Pagereference redirectPage;
        try{
            redirectPage = LoginService.login(username, password, null);
            if(redirectPage != null){
                result.redirectURL = redirectPage.getUrl();
            }
        }catch(FieloCustomException e){
            result.redirectURL = '';
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloAlpha.FieloCustomException e){
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

    @RemoteAction
    global static FieloCMS.RemoteActionResult forgotPassword(String userName){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();                
        Pagereference redirectPage;
        try{
            redirectPage = LoginService.forgotPassword(username);
            if(redirectPage != null) result.redirectURL = redirectPage.getUrl();
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.site.temp_password_sent + '<a href="/" >' + Label.GoToHome + '</a>')));
        }catch(FieloCustomException e){
            result.redirectURL = '';
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloAlpha.FieloCustomException e){
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