public class FieloCMSPLT_NavigationsSelector extends FieloCMSPLT_SObjectSelector{
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloCMS__Navigation__c.Id
			};
	}

	public FieloCMSPLT_NavigationsSelector(Set<String> fields){
		super(fields);
	}

	public Schema.SObjectType getSObjectType(){
		return FieloCMS__Navigation__c.sObjectType;
	}

	public List<FieloCMS__Navigation__c> selectById(Set<ID> idSet){
		return (List<FieloCMS__Navigation__c>) selectSObjectsById(idSet);
	}	

	public List<FieloCMS__Navigation__c> selectByIdAndHasSegments(Set<Id> idSet, Boolean hasSegments){
		assertIsAccessible();
		return (List<FieloCMS__Navigation__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where Id IN : idSet AND HasSegments__c =: hasSegments ' + 
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),
					getOrderBy() } ) );
	}

	/*
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
	 * 
	public List<FieloCMS__Navigation__c> selectBySomethingElse(List<String> somethings){
		assertIsAccessible();
		return (List<FieloCMS__Navigation__c>) Database.query(
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