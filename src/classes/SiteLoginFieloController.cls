//NO DOCUMENT
/**
* @author Matias Trionfetti
* @date  07/07/2011
* @description Class is used to login in site
*/
global with sharing class SiteLoginFieloController {
   
    global String username {get; set;}
    global String password {get; set;}
    
    
    global PageReference login() {   
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        try{
            return LoginUtil.login(username, password, startUrl);
        }catch(FieloCustomException e){
            Apexpages.addMessage(new apexpages.Message(apexpages.severity.Error, e.getMessage()));
            return null;
        }
    }
    
    @RemoteAction
    global static RemoteActionResult login(String userName, String password){        
        RemoteActionResult result = new RemoteActionResult();                
        Pagereference redirectPage;
        try{
            redirectPage = LoginUtil.login(username, password, null);
            if(redirectPage != null){
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

    @RemoteAction
    global static RemoteActionResult forgotPassword(String userName){        
        RemoteActionResult result = new RemoteActionResult();                
        Pagereference redirectPage;
        try{
            redirectPage = LoginUtil.forgotPassword(username);
            if(redirectPage != null) result.redirectURL = redirectPage.getUrl();
            result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.site.temp_password_sent + '<a href="/" >' + Label.GoToHome + '</a>')));
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
    global Pagereference redirect(){return null;}
}