public class RedemptionItemsSelector extends SObjectSelector{

	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloPl__RedemptionItem__c.Id
			};
	}

	public RedemptionItemsSelector(Set<String> fields){
		super(fields);
	}

	public RedemptionItemsSelector(){
		super();
	}

	public Schema.SObjectType getSObjectType(){
		return FieloPl__RedemptionItem__c.sObjectType;
	}

	public List<FieloPl__RedemptionItem__c> selectById(Set<ID> idSet){
		return (List<FieloPl__RedemptionItem__c>) selectSObjectsById(idSet);
	}

	public List<FieloPl__RedemptionItem__c> selectByMemberOriginStatusAndReward(Id rewardId, String status, String origin, Id memberId){
		assertIsAccessible();
		return (List<FieloPl__RedemptionItem__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloPl__Reward__c =: rewardId AND FieloPl__Redemption__r.FieloPl__Status__c =: status AND FieloPl__Redemption__r.FieloPl__Origin__c =: origin AND FieloPl__Redemption__r.FieloPl__Member__c =: memberId ' + 
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),					
					getOrderBy() } ) );
	}	

	public List<FieloPl__RedemptionItem__c> selectByRedemptionAndRewards(Id redemptionId, Set<Id> rewardIds){
		assertIsAccessible();
		return (List<FieloPl__RedemptionItem__c>) Database.query(
			String.format(
			'select {0} ' +
			 	'from {1} ' +
			 	'where FieloPl__Redemption__c =: redemptionId AND FieloPl__Reward__c IN: rewardIds ' + 
			 	'order by {2}',
			new List<String> {
				getFieldListString(),
				getSObjectName(),
				getOrderBy() } ) );
	}

	/*
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
	 * 
	public List<FieloPl__RedemptionItem__c> selectBySomethingElse(List<String> somethings)
	{
		assertIsAccessible();
		return (List<FieloPl__RedemptionItem__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where Something__c in :somethings ' + 
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),
					getOrderBy() } ) );
	}
	 */
}