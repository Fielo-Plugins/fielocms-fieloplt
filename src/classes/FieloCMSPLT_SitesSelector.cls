public class FieloCMSPLT_SitesSelector extends FieloCMSPLT_SObjectSelector{
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloCMS__Site__c.Id
			};
	}

	public FieloCMSPLT_SitesSelector (Set<String> fields){
		super(fields);
	}

	public Schema.SObjectType getSObjectType(){
		return FieloCMS__Site__c.sObjectType;
	}

	public List<FieloCMS__Site__c> selectById(Set<ID> idSet){
		return (List<FieloCMS__Site__c>) selectSObjectsById(idSet);
	}	

	public List<FieloCMS__Site__c> selectAll(){
		assertIsAccessible();
		return (List<FieloCMS__Site__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),
					getOrderBy() } ) );
	}

	/*
	 * For more examples see https://github.com/financialforcedev/SegmentCriteria__r-apex-common-samplecode
	 * 
	public List<FieloCMS__Site__c> selectBySomethingElse(List<String> somethings){
		assertIsAccessible();
		return (List<FieloCMS__Site__c>) Database.query(
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