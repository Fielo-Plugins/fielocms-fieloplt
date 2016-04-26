global with sharing class ShoppingCartController {
    
    @RemoteAction
    global static RemoteActionResult save(Id componentId, String newQuantJSON){//Map<Id,Integer> newQuantitiesMap                        
        Redemption__c redemption = RedemptionService.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
        RemoteActionResult result = new RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isNotBlank(newQuantJSON)){
                Map<String,Object> newQuantitiesMap = (Map<String,Object>)JSON.deserializeUntyped(newQuantJSON);
                saveCart(redemption, newQuantitiesMap);
            }
            result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, 'success')));
            result.redirectURL = '#';
        }catch(FieloCustomException e){
            Database.rollBack(sp);
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }

    private static void saveCart(Redemption__c redemption, Map<String,Object> newQuantitiesMap){        
        Map<Id,Integer> oldQuantities = new Map<Id,Integer>();
        for(AggregateResult result : [SELECT Reward__c rewardId, sum(Quantity__c) quantity FROM RedemptionItem__c WHERE Redemption__c =: redemption.Id GROUP BY Reward__c]){
            oldQuantities.put((Id)result.get('rewardId'), ((Decimal)result.get('quantity')).intValue());
        }

        Savepoint sp = Database.setSavepoint();
        List<RedemptionUtil.RedItemWrapper> redItemsWrapper = new List<RedemptionUtil.RedItemWrapper>();        
        for(Id rewardId : oldQuantities.keySet()){
            if(newQuantitiesMap.containsKey(rewardId)){
                Integer diff = Integer.valueOf(((String)newQuantitiesMap.get(rewardId))) - oldQuantities.get(rewardId);
                if(diff != 0){
                    redItemsWrapper.add(new RedemptionUtil.RedItemWrapper(rewardId, diff));
                }
            }
        }

        if(redItemsWrapper.size() > 0){            
            RedemptionService.addRedemptionItems(redemption.Id,redItemsWrapper);            
        }
    }

    @RemoteAction
    global static RemoteActionResult checkout(Id componentId, String newQuantJSON){                
        Redemption__c redemption = RedemptionUtil.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
        Component__c component = [SELECT Id, DetailParameter__c, DetailPage__c FROM Component__c WHERE Id =: componentId];
        RemoteActionResult result = new RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isNotBlank(newQuantJSON)){
                Map<String,Object> newQuantitiesMap = (Map<String,Object>)JSON.deserializeUntyped(newQuantJSON);
                saveCart(redemption, newQuantitiesMap);
            }
            RedemptionService.closeRedemption(redemption.Id);
            PageReference retPage = Page.Page;
            retPage.getParameters().put('pageId',component.DetailPage__c);
            retPage.getParameters().put(component.DetailParameter__c,redemption.Id);
            result.redirectURL = retPage.getUrl();
            //result.redirectURL = '/Page?pageId=' + component.DetailPage__c + '&' + component.DetailParameter__c + '=' + redemption.Id;
        }catch(Exception e){
            Database.rollBack(sp);
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }

    @RemoteAction
    global static RemoteActionResult emptyCart(Id componentId, String newQuantJSON){                
        RemoteActionResult result = new RemoteActionResult();        
        Savepoint sp = Database.setSavepoint();
        try{
            RedemptionService.deleteRedemptions(MemberService.getCurrentMemberId(), 'Open', 'FrontEnd');
            result.redirectURL = '#';
        }catch(Exception e){            
            Database.rollBack(sp);
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }    
        
        return result;
    }

}