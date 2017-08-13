@isTest
private class SegmentsSelectionControllerTest {
	
	@isTest static void test_method_one() {
		Id publicId = [select id, name, sobjecttype from recordtype where name = 'Public' limit 1].Id;
		Id manualId = [select id, name, sobjecttype from recordtype where name = 'Manual' limit 1].Id;

		insert new FieloPLT__Segment__c(Name = 'Public', recordtypeId = publicId );
		FieloPLT__Segment__c segment = new FieloPLT__Segment__c(Name = 'Manual', recordtypeId = manualId );
		insert segment;

		FieloPLT__Segment__c segment2 = new FieloPLT__Segment__c(Name = 'Manual2', recordtypeId = manualId );
		insert segment2;

		FieloCMS__Post__c post = new FieloCMS__Post__c(Name = 'test', Segment__c = segment.Id);
		insert post;
		ApexPages.currentPage().getParameters().put('id', post.Id);

		SegmentsSelectionController sgc = new SegmentsSelectionController();


		sgc.addSelected();

		sgc.save();

		sgc.cancel();

		sgc.saveAndExit();

		sgc.getRecordName();

		sgc.getObjectLabel();
		
		sgc.remove();

	}
	
}