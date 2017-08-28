public class FieloCMSPLT_RedemptionItemsSelector extends FieloCMSPLT_SObjectSelector{

	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloPLT__RedemptionItem__c.Id
			};
	}

	public FieloCMSPLT_RedemptionItemsSelector(Set<String> fields){
		super(fields);
	}

	public FieloCMSPLT_RedemptionItemsSelector(){
		super();
	}

	public Schema.SObjectType getSObjectType(){
		return FieloPLT__RedemptionItem__c.sObjectType;
	}

	public List<FieloPLT__RedemptionItem__c> selectById(Set<ID> idSet){
		return (List<FieloPLT__RedemptionItem__c>) selectSObjectsById(idSet);
	}

	public List<FieloPLT__RedemptionItem__c> selectByMemberOriginStatusAndReward(Id rewardId, String status, String origin, Id memberId){
		assertIsAccessible();
		return (List<FieloPLT__RedemptionItem__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloPLT__Reward__c =: rewardId AND FieloPLT__Redemption__r.FieloPLT__Status__c =: status AND FieloPLT__Redemption__r.FieloPLT__Origin__c =: origin AND FieloPLT__Redemption__r.FieloPLT__Member__c =: memberId ' + 
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),					
					getOrderBy() } ) );
	}	

	public List<FieloPLT__RedemptionItem__c> selectByRedemptionAndRewards(Id redemptionId, Set<Id> rewardIds){
		assertIsAccessible();
		return (List<FieloPLT__RedemptionItem__c>) Database.query(
			String.format(
			'select {0} ' +
			 	'from {1} ' +
			 	'where FieloPLT__Redemption__c =: redemptionId AND FieloPLT__Reward__c IN: rewardIds ' + 
			 	'order by {2}',
			new List<String> {
				getFieldListString(),
				getSObjectName(),
				getOrderBy() } ) );
	}

	/*
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
	 * 
	public List<FieloPLT__RedemptionItem__c> selectBySomethingElse(List<String> somethings)
	{
		assertIsAccessible();
		return (List<FieloPLT__RedemptionItem__c>) Database.query(
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