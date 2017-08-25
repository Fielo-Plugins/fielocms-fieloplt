global with sharing class FieloCMSPLT_LoginAPI implements FieloCMS.ViewInterface{
    
    global ApexPages.Component getComponent(FieloCMS__Component__c component){                                        
        return new Component.FieloCMSPLT_SiteLogin(config = component);
    }    
}