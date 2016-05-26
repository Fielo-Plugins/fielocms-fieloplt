global with sharing class RedemptionAPI implements FieloCMS.DataInterface, FieloCMS.ViewInterface{
	
    public ApexPages.Component getComponent(FieloCMS__Component__c c){                
        Component.ShoppingCart shoppingCart = new Component.ShoppingCart(config = c);
        return shoppingCart;        
    }

	public Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){        
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            newMapData.put(c.Id, FieloAlpha.RedemptionService.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd'));            
        }
        return newMapData;
    }

    public List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }
}