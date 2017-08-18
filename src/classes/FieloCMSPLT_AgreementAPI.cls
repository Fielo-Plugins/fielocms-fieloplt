global with sharing class FieloCMSPLT_AgreementAPI implements FieloCMS.ViewInterface{
	global ApexPages.Component getComponent(FieloCMS__Component__c c){                
        Component.Agreement agreement = new Component.Agreement(config = c);
        return agreement;        
    }
}