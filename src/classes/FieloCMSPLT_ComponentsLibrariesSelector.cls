public class FieloCMSPLT_ComponentsLibrariesSelector extends FieloCMSPLT_SObjectSelector{
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
				FieloCMS__ComponentLibrary__c.Id
			};
	}

	public FieloCMSPLT_ComponentsLibrariesSelector(Set<String> fields){
        super(fields);
    }

	public Schema.SObjectType getSObjectType(){
		return FieloCMS__ComponentLibrary__c.sObjectType;
	}

	public List<FieloCMS__ComponentLibrary__c> selectById(Set<ID> idSet){
		return (List<FieloCMS__ComponentLibrary__c>) selectSObjectsById(idSet);
	}

	/*
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
	 *
	public List<FieloCMS__ComponentLibrary__c> selectBySomethingElse(List<String> somethings){
		assertIsAccessible();
		return (List<FieloCMS__ComponentLibrary__c>) Database.query(
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