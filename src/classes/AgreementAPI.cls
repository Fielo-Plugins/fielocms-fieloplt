global with sharing class AgreementAPI implements FieloCMS.ViewInterface{
 global ApexPages.Component getComponent(FieloCMS__Component__c c){                
        Component.FieloCMSPLT_Agreement agreement = new Component.FieloCMSPLT_Agreement(config = c);
        return agreement;        
    }
}