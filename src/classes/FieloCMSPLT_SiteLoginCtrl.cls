global with sharing class FieloCMSPLT_SiteLoginCtrl {
    
    @RemoteAction
    global static FieloCMS.RemoteActionResult login(String userName, String password){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();                
        Pagereference redirectPage;
        try{
            redirectPage = FieloCMSPLT_LoginService.login(username, password, null);            
            if(redirectPage != null){
                result.redirectURL = redirectPage.getUrl().replace('%2Fapex','');
            }
        }catch(FieloCMSPLT_Exception e){
            result.redirectURL = '';
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloPLT.FieloException e){
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
            redirectPage = FieloCMSPLT_LoginService.forgotPassword(username);
            if(redirectPage != null) result.redirectURL = redirectPage.getUrl();
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.site.temp_password_sent + '<a href="/" >' + Label.FieloCMSPLT_GoToHome + '</a>')));
        }catch(FieloCMSPLT_Exception e){
            result.redirectURL = '';
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloPLT.FieloException e){
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