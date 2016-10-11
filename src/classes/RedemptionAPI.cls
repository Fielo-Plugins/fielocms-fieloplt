global with sharing class RedemptionAPI implements FieloCMS.ViewInterface{
    
    global ApexPages.Component getComponent(FieloCMS__Component__c c){                
        Component.ShoppingCart shoppingCart = new Component.ShoppingCart(config = c);
        return shoppingCart;        
    }
}