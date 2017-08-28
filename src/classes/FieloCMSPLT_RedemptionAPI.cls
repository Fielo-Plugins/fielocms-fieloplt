global with sharing class FieloCMSPLT_RedemptionAPI implements FieloCMS.ViewInterface{
    
    global ApexPages.Component getComponent(FieloCMS__Component__c c){                
        Component.FieloCMSPLT_ShoppingCart shoppingCart = new Component.FieloCMSPLT_ShoppingCart(config = c);
        return shoppingCart;        
    }
}