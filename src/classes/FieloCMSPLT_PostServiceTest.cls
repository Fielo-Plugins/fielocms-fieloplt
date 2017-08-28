@isTest
private class FieloCMSPLT_PostServiceTest {
	
	@isTest static void test_method_one() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;


		Id publicId = [select id, name, sobjecttype from recordtype where name = 'Public' limit 1].Id;
		Id privateId = [select id, name, sobjecttype from recordtype where name = 'Private' limit 1].Id;

		insert new FieloPLT__Segment__c(Name = 'Public', recordtypeId = publicId );
		insert new FieloPLT__Segment__c(Name = 'Private', recordtypeId = privateId );

		FieloCMS__Category__c category = new FieloCMS__Category__c(Name = 'Test');
		insert category;

		insert new FieloCMS__Post__c(Name = 'test');

		Set<String> fields = new Set<String>{'Id','Name'};		
		String status = '';
		Id tagId = null;
		Id categoryId = null;
		Integer quantity = 10; 
		Integer offset = 1; 
		String orderBy = 'Name';
		Id memberId = null;

		try{
			FieloCMSPLT_PostService.getPosts(fields, status, tagId, category.Id, quantity, offset, orderBy, memberId);
		}catch(exception e){}
	}

	@isTest static void test_method_two() {
		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;

		Id publicId = [select id, name, sobjecttype from recordtype where name = 'Public' limit 1].Id;
		Id privateId = [select id, name, sobjecttype from recordtype where name = 'Private' limit 1].Id;

		insert new FieloPLT__Segment__c(Name = 'Public', recordtypeId = publicId );
		insert new FieloPLT__Segment__c(Name = 'Private', recordtypeId = privateId );

		FieloCMS__Category__c category = new FieloCMS__Category__c(Name = 'Test');
		insert category;

		FieloCMS__Tag__c tag = new FieloCMS__Tag__c(Name = 'test');
		insert tag;

		insert new FieloCMS__Post__c(Name = 'test');

		Set<String> fields = new Set<String>{'Id','Name'};		
		String status = '';
		Integer quantity = 10; 
		Integer offset = 1; 
		String orderBy = 'Name';
		Id memberId = null;

		try{
			FieloCMSPLT_PostService.getPosts(fields, status, tag.Id, category.Id, quantity, offset, orderBy, memberId);
		}catch(exception e){}
	}
	
}