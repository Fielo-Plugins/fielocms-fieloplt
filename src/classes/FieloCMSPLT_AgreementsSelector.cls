public class FieloCMSPLT_AgreementsSelector extends FieloCMSPLT_SObjectSelector{
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloPLT__Agreement__c.Id
			};
	}

	public FieloCMSPLT_AgreementsSelector(Set<String> fields){
		super(fields);
	}

	public FieloCMSPLT_AgreementsSelector(){
        super();
    }

	public Schema.SObjectType getSObjectType(){
		return FieloPLT__Agreement__c.sObjectType;
	}

	public List<FieloPLT__Agreement__c> selectById(Set<ID> idSet){
		return (List<FieloPLT__Agreement__c>) selectSObjectsById(idSet);
	}

	public List<FieloPLT__Agreement__c> selectCurrentByProgram(Id programId){
		String currentStatus = 'Current';
		assertIsAccessible();
		return (List<FieloPLT__Agreement__c>) Database.query(
				String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloPLT__Status__c =: currentStatus AND FieloPLT__Program__c =: programId ' + 
				  'order by {2}',
				new List<String> {
					getFieldListString(),
					getSObjectName(),
					getOrderBy() } ) );
	}

	/*
	 * For more examples see https://github.com/financialforcedev/SegmentCriteria__r-apex-common-samplecode
	 * 
	public List<FieloPLT__Agreement__c> selectBySomethingElse(List<String> somethings){
		assertIsAccessible();
		return (List<FieloPLT__Agreement__c>) Database.query(
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