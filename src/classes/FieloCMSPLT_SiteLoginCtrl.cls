global with sharing class FieloCMSPLT_SiteLoginCtrl {
    
    @RemoteAction
    global static FieloCMS.RemoteActionResult login(String userName, String password){        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();                
        Pagereference redirectPage;

        String redirectURL;
        String siteId = site.getSiteId();
        List<FieloCMS__Layout__c> ll = [SELECT Id FROM FieloCMS__Layout__c WHERE FieloCMS__Site__r.FieloCMS__SiteId__c = :siteId AND Name = 'Private' ];
        if ( !ll.isEmpty() ) {
            redirectURL = '?layoutid=' + ll.get(0).Id;
        }
        
        try{
            redirectPage = FieloCMSPLT_LoginService.login(username, password, redirectURL);            

            if(redirectPage != null){
                redirectPage.getParameters().put('retURL', redirectPage.getParameters().get('retURL') + redirectURL);

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