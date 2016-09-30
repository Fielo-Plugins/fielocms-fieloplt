global with sharing class LoginAPI implements FieloCMS.ViewInterface{
    
    global ApexPages.Component getComponent(FieloCMS__Component__c component){                                
        if(component.FieloCMS__ComponentLibrary__r.Name == 'Platform Login'){                    
            return new Component.SiteLoginFielo(config = component);            
        }
        return null;
    }    
}