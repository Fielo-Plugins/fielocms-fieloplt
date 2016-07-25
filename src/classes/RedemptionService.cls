public class RedemptionService{

	public static void deleteRedemptions(Id memberId, String status, String origin){
        List<Redemption__c> redemptions = new RedemptionsSelector().selectByStatusOriginAndMember(status, origin, memberId);
        if(!redemptions.isEmpty()){
            SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloPl__Redemption__c.SObjectType});
            uow.registerDeleted(redemptions);
            uow.commitWork();
	}

	public static Redemption__c getOpenRedemption(Id memberId, String origin) {
        //Search for a Redemption for the member received, if it finds return that one, if not creates a new one
        Set<String> fields = new Set<String>();

        Map<String, Schema.SObjectField> o = Schema.describeSObjects(new String[]{'FieloPl__Redemption__c'})[0].fields.getMap();
        Set<String> fieldFilter = new Set<String> {'CreatedById', 'IsDeleted', 'OwnerId', 'LastModifiedDate', 'LastModifiedById', 'SystemModstamp'};
        for(Schema.SObjectField field :o.values()){
            String apiName = field.getDescribe().getName();
            if(!fieldFilter.contains(apiName) ){
                fields.add(apiName);
            }
        }
        List<Redemption__c> redemptions = new RedemptionsSelector(fields).selectByStatusOriginAndMember('Open', origin, memberId);
        return redemptions.size() > 0 ? redemptions.get(0) : null;
    }

    public static Redemption__c addToCart(Id memberId, Id rewardId, Integer quantity, Boolean closeOrder){
        List<RedemptionItem__c> redItems = new RedemptionItemsSelector().selectByMemberOriginStatusAndReward(rewardId, 'Open', 'FrontEnd', memberId);
        if(!redItems.isEmpty()){
            throw new FieloCustomException(Label.ShoppingExistingReward);
        }

        SavePoint sp = Database.setSavePoint();
        try{
            //creates the redemption or brings an existed one
            Redemption__c redemption = getOpenRedemption(memberId, 'FrontEnd');
            if(redemption == null){
                redemption = createRedemption(memberId, 'FrontEnd');
            }

            RedemptionService.addRedemptionItems(redemption.Id, new List<RedemptionUtil.RedItemWrapper>{new RedemptionUtil.RedItemWrapper(rewardId, quantity)});

            if(closeOrder){
                redemption = FieloPl.RedemptionService.closeRedemption(redemption.Id);
            }
            return redemption;
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }

        return null;
    }

    global static FieloPl__Redemption__c createRedemption(Id memberId, String origin){
        FieloPl__Redemption__c redemption = new FieloPl__Redemption__c(Member__c = memberId, Origin__c = origin);
        SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloPl__Redemption__c.SObjectType});
        uow.registerNew(redemption);
        uow.commitWork();
        return redemption;
    }
}