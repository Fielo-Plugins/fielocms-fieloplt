global with sharing class LoginAPI implements FieloCMS.ViewInterface{
    
    global ApexPages.Component getComponent(FieloCMS__Component__c component){                                        
        return new Component.SiteLoginFielo(config = component);
    }    
}