public with sharing class FieloCMSPLT_MembersSelector extends FieloCMSPLT_SObjectSelector{

	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField>{
            FieloPLT__Member__c.Id,
			FieloPLT__Member__c.Name,
			FieloPLT__Member__c.FieloPLT__Email__c,
			FieloPLT__Member__c.FieloPLT__Program__c,
			FieloPLT__Member__c.FieloPLT__User__c,
			FieloPLT__Member__c.FieloPLT__Account__c,
			FieloPLT__Member__c.FieloPLT__Status__c,
            FieloPLT__Member__c.FieloPLT__OrganizationAccount__c,
            FieloPLT__Member__c.FieloPLT__Contact__c,
            FieloPLT__Member__c.FieloPLT__IsManager__c
		};
	}

	public FieloCMSPLT_MembersSelector(Set<String> fields){
		super(fields);
	}

	public FieloCMSPLT_MembersSelector(){
		super();
	}

	public Schema.SObjectType getSObjectType(){
		return FieloPLT__Member__c.SObjectType;
	}

	public List<FieloPLT__Member__c> selectById(Set<Id> memberIds){
		return (List<FieloPLT__Member__c>) selectSObjectsById(memberIds);
	}

	public List<FieloPLT__Member__c> selectRelatedMembers(Id userId, Id programId){
		assertIsAccessible();
		String fieldSet = getFieldListString();
		if(!fieldset.contains('OrganizationAccount__c')){
			fieldSet += ',OrganizationAccount__c';
		}
		if(!fieldset.contains('IsManager__c')){
			fieldSet += ',IsManager__c';
		}
		String query = String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloPLT__User__c =: userId AND FieloPLT__Program__c =: programId {2} {3} ',
				new List<String> {
					fieldSet,
					getSObjectName(), getLimitCondition(), getOffsetCondition()});

		List<FieloPLT__Member__c> members = (List<FieloPLT__Member__c>)Database.query(query);

    	return members;
	}

	public List<FieloPLT__Member__c> selectByOrganizationAccount(Id orgAccountId){
		assertIsAccessible();
		String query = String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloPLT__OrganizationAccount__c =: orgAccountId {2} {3}',
				new List<String> {getFieldListString(),getSObjectName(),getLimitCondition(), getOffsetCondition()});

		return (List<FieloPLT__Member__c>) Database.query(query);
	}

}
