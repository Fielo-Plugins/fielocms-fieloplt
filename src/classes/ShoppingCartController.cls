global with sharing class ShoppingCartController {
    
    /*private Boolean redemptionQueried = false;
    private FieloPLT__Redemption__c redemption {get{
        if(!redemptionQueried){
            redemption = RedemptionService.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
            redemptionQueried = true;
        }
        return redemption;
    } set;}*/
    
    public List<FieloPLT__Reward__c> rewards {get{
        if(rewards == null){            
            /*if(redemption != null){
                Id redemptionId = redemption.Id;
                //rewards = Database.query('SELECT ' + getFieldSet() + ' FROM FieloPLT__Reward__c WHERE Id in (SELECT FieloPLT__Reward__c FROM FieloPLT__RedemptionItem__c WHERE FieloPLT__Redemption__c =: redemptionId)');
            }else{
                rewards = new List<FieloPLT__Reward__c>();
            }*/
        }
        return rewards;
    } set;}

    /*public Map<Id,Integer> quantitiesMap {get{
        if(quantitiesMap == null){
            quantitiesMap = new Map<Id,Integer>();
            for(AggregateResult ar : [SELECT sum(FieloPLT__Quantity__c) quantities, FieloPLT__Reward__c FROM FieloPLT__RedemptionItem__c WHERE FieloPLT__Redemption__c =: redemption.Id GROUP BY FieloPLT__Reward__c]){
                quantitiesMap.put((Id)ar.get('FieloPLT__Reward__c'), Integer.valueOf(ar.get('quantities')));
            }
        }
        return quantitiesMap;
    } set;}*/

    private String getFieldset(){        
        List<String> fields = new List<String>{'Id'};
        for(Schema.FieldSetMember fsm : Schema.SObjectType.FieloPLT__Reward__c.fieldSets.ShoppingCart.getFields()){
            fields.add(fsm.getFieldPath());
        }    
        return String.join(fields,',');      
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult save(Id componentId, String newQuantJSON){
        /*FieloPLT__Redemption__c redemption = RedemptionService.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isNotBlank(newQuantJSON)){
                Map<String,Object> newQuantitiesMap = (Map<String,Object>)JSON.deserializeUntyped(newQuantJSON);
                if(redemption == null){
                    redemption = RedemptionService.createRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
                }
                saveCart(redemption, newQuantitiesMap);
            }
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, 'success')));
            result.redirectURL = '#';
            //result.refresh.add(new FieloCMS.RemoteActionResult.RemoteActionRefresh('refresh',componentId));
        }catch(FieloPLT.FieloException e){
            Database.rollBack(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;*/
        return null;
    }

    private static void saveCart(FieloPLT__Redemption__c redemption, Map<String,Object> newQuantitiesMap){        
        /*Map<Id,Integer> oldQuantities = new Map<Id,Integer>();
        for(AggregateResult result : [SELECT FieloPLT__Reward__c rewardId, sum(FieloPLT__Quantity__c) quantity FROM FieloPLT__RedemptionItem__c WHERE FieloPLT__Redemption__c =: redemption.Id GROUP BY FieloPLT__Reward__c]){
            oldQuantities.put((Id)result.get('rewardId'), ((Decimal)result.get('quantity')).intValue());
        }

        Savepoint sp = Database.setSavepoint();
        List<FieloPLT.RedemptionUtil.RedItemWrapper> redItemsWrapper = new List<FieloPLT.RedemptionUtil.RedItemWrapper>();        
        for(Id rewardId : oldQuantities.keySet()){
            if(newQuantitiesMap.containsKey(rewardId)){
                Integer diff = Integer.valueOf(((String)newQuantitiesMap.get(rewardId))) - oldQuantities.get(rewardId);
                if(diff != 0){
                    redItemsWrapper.add(new FieloPLT.RedemptionUtil.RedItemWrapper(rewardId, diff));
                }
            }
        }

        if(redItemsWrapper.size() > 0){            
            FieloPLT.RedemptionService.addRedemptionItems(redemption.Id,redItemsWrapper);            
        }*/
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult checkout(Id componentId, String newQuantJSON){
        /*FieloPLT__Redemption__c redemption = RedemptionService.getOpenRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
        
        FieloCMS__Component__c component = [SELECT FieloCMS__ParameterName__c, RedirectPage__c FROM FieloCMS__Component__c WHERE Id =: componentId];        
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isNotBlank(newQuantJSON)){
                Map<String,Object> newQuantitiesMap = (Map<String,Object>)JSON.deserializeUntyped(newQuantJSON);
                if(redemption == null){
                    redemption = FieloPLT.RedemptionService.createRedemption(MemberService.getCurrentMemberId(), 'FrontEnd');
                }
                saveCart(redemption, newQuantitiesMap);
            }
            redemption = FieloPLT.RedemptionService.closeRedemption(redemption.Id);
            if(redemption.FieloPLT__Status__c == 'Close'){
                PageReference retPage = Page.FieloCMS__Page;
                retPage.getParameters().put('pageId',component.RedirectPage__c);
                retPage.getParameters().put(component.FieloCMS__ParameterName__c,redemption.Id);
                result.redirectURL = retPage.getUrl();
            }else{
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.InfoRedemptionApproval)));
            }
        }catch(Exception e){
            Database.rollBack(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;*/
        return null;
    }

    /*@RemoteAction
    global static FieloCMS.RemoteActionResult emptyCart(Id componentId, String newQuantJSON){                
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();        
        Savepoint sp = Database.setSavepoint();
        try{
            RedemptionService.deleteRedemptions(MemberService.getCurrentMemberId(), 'Open', 'FrontEnd');
            //result.redirectURL = '#';
            result.refresh.add(new FieloCMS.RemoteActionResult.RemoteActionRefresh('refresh',componentId));
        }catch(Exception e){            
            Database.rollBack(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }    
        
        return result;
    }*/

}