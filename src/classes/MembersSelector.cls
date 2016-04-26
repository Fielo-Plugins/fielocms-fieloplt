public with sharing class MembersSelector extends SObjectSelector{

	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField>{
            FieloAlpha__Member__c.Id,
			FieloAlpha__Member__c.Name,
			FieloAlpha__Member__c.Email__c,
			FieloAlpha__Member__c.Program__c,
			FieloAlpha__Member__c.User__c,
			FieloAlpha__Member__c.LastName__c,
			FieloAlpha__Member__c.FirstName__c,
			FieloAlpha__Member__c.User__c,
			FieloAlpha__Member__c.Account__c,
			FieloAlpha__Member__c.FieloAccountStatus__c,
            FieloAlpha__Member__c.OrganizationAccount__c,
            FieloAlpha__Member__c.Contact__c,
            FieloAlpha__Member__c.IsManager__c,
            FieloAlpha__Member__c.Blocked__c,
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

	public List<Member__c> selectById(Set<Id> memberIds){
		return (List<FieloAlpha__Member__c>) selectSObjectsById(memberIds);
	}

	public List<Member__c> selectRelatedMembers(Id userId, Id programId){
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
				  'where User__c =: userId AND Program__c =: programId {2} {3} ',
				new List<String> {
					fieldSet,
					getSObjectName(), getLimitCondition(), getOffsetCondition()});

		List<Member__c> members = (List<Member__c>)Database.query(query);

    	return members;
	}

	public List<Member__c> selectByOrganizationAccount(Id orgAccountId){
		assertIsAccessible();
		String query = String.format(
				'select {0} ' +
				  'from {1} ' +
				  'where OrganizationAccount__c =: orgAccountId {2} {3}',
				new List<String> {getFieldListString(),getSObjectName(),getLimitCondition(), getOffsetCondition()});

		return (List<Member__c>) Database.query(query);
	}

}