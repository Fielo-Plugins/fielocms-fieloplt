public with sharing class MembersSelector extends SObjectSelector{

	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField>{
            FieloAlpha__Member__c.Id,
			FieloAlpha__Member__c.Name,
			FieloAlpha__Member__c.FieloAlpha__Email__c,
			FieloAlpha__Member__c.FieloAlpha__Program__c,
			FieloAlpha__Member__c.FieloAlpha__User__c,
			FieloAlpha__Member__c.FieloAlpha__LastName__c,
			FieloAlpha__Member__c.FieloAlpha__FirstName__c,
			FieloAlpha__Member__c.FieloAlpha__User__c,
			FieloAlpha__Member__c.FieloAlpha__Account__c,
			FieloAlpha__Member__c.FieloAlpha__FieloAccountStatus__c,
            FieloAlpha__Member__c.FieloAlpha__OrganizationAccount__c,
            FieloAlpha__Member__c.FieloAlpha__Contact__c,
            FieloAlpha__Member__c.FieloAlpha__IsManager__c,
            FieloAlpha__Member__c.FieloAlpha__Blocked__c,
			FieloAlpha__Member__c.RecordTypeId
		};
	}

	public MembersSelector(Set<String> fields){
		super(fields);
	}

	public MembersSelector(){
		super();
	}

	public Schema.SObjectType getSObjectType(){
		return FieloAlpha__Member__c.SObjectType;
	}

	public List<FieloAlpha__Member__c> selectById(Set<Id> memberIds){
		return (List<FieloAlpha__Member__c>) selectSObjectsById(memberIds);
	}

	public List<FieloAlpha__Member__c> selectRelatedMembers(Id userId, Id programId){
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
				  'where FieloAlpha__User__c =: userId AND FieloAlpha__Program__c =: programId {2} {3} ',
				new List<String> {
					fieldSet,
					getSObjectName(), getLimitCondition(), getOffsetCondition()});

		List<FieloAlpha__Member__c> members = (List<FieloAlpha__Member__c>)Database.query(query);

    	return members;
	}

	public List<FieloAlpha__Member__c> selectByOrganizationAccount(Id orgAccountId){
		assertIsAccessible();
		String query = String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where FieloAlpha__OrganizationAccount__c =: orgAccountId {2} {3}',
				new List<String> {getFieldListString(),getSObjectName(),getLimitCondition(), getOffsetCondition()});

		return (List<FieloAlpha__Member__c>) Database.query(query);
	}

}