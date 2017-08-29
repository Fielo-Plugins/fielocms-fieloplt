global with sharing class FieloCMSPLT_ShoppingCartCtrl {

    public List<FieloPLT__Reward__c> rewards {get{
        if(rewards == null){
            Set<Id> rewardIds = quantitiesMap.keySet();
            rewards = Database.query('SELECT ' + getFieldSet() + ' FROM FieloPLT__Reward__c WHERE Id in : rewardIds');
        }
        return rewards;
    } set;}

    public Map<Id,Integer> quantitiesMap {get{
        if(quantitiesMap == null){
            Cookie shopCartCookie = ApexPages.currentPage().getCookies().get('shoppingCart');
            if(shopCartCookie != null && !String.isBlank(shopCartCookie.getValue())){
                quantitiesMap = (Map<Id,Integer>)JSON.deserialize(shopCartCookie.getValue(),Map<Id,Integer>.class);
            }else{
                quantitiesMap = new Map<Id,Integer>();
            }
        }
        return quantitiesMap;
    } set;}

    public Integer totalItems {get{
            if(totalItems == null){
                totalItems = 0;
                for(Integer quant : quantitiesMap.values()){
                    totalItems += quant;
                }
            }
            return totalItems;
        } set;}

    public Map<Id,Integer> totalPointsMap {get{
        if(totalPointsMap == null){
            totalPointsMap = new Map<Id,Integer>();
            for(FieloPLT__Reward__c reward : rewards){
                totalPointsMap.put(reward.Id, (quantitiesMap.get(reward.Id) * reward.FieloPLT__Points__c).intValue());
            }
        }
        return totalPointsMap;
    } set;}

    private String getFieldset(){
        Set<String> fields = new Set<String>{'Id','FieloPLT__Points__c'};
        for(Schema.FieldSetMember fsm : Schema.SObjectType.FieloPLT__Reward__c.fieldSets.FieloCMSPLT_ShoppingCart.getFields()){
            fields.add(fsm.getFieldPath());
        }
        return String.join(new List<String>(fields),',');
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult checkout(Id componentId, String newQuantJSON){
        FieloCMS__Component__c component = [SELECT FieloCMS__DetailParameter__c, FieloCMSPLT_RedirectPage__c FROM FieloCMS__Component__c WHERE Id =: componentId];
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        Savepoint sp = Database.setSavepoint();
        try{
            FieloPLT__Redemption__c redemption;
            if(String.isNotBlank(newQuantJSON)){
                Map<Id,Integer> quantitiesMap = (Map<Id,Integer>)JSON.deserialize(newQuantJSON, Map<Id,Integer>.class);
                redemption = FieloPLT.RedemptionService.createRedemptions(quantitiesMap, FieloCMSPLT_MemberService.getCurrentMemberId())[0];
                if(redemption.FieloPLT__Status__c == 'Closed'){
                    PageReference retPage = Page.FieloCMS__Page;
                    retPage.getParameters().put('pageId',component.FieloCMSPLT_RedirectPage__c);
                    retPage.getParameters().put(component.FieloCMS__DetailParameter__c,redemption.Id);
                    result.redirectURL = retPage.getUrl().replace('/apex','');
                }else{
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.FieloCMSPLT_InfoRedemptionApproval)));
                }
            }
        }catch(DMLException e){
            Database.rollBack(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }

}