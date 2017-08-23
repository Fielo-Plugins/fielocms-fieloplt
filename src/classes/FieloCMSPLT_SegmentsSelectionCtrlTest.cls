@isTest
private class FieloCMSPLT_SegmentsSelectionCtrlTest {
	
	@isTest static void test_method_one() {
		Id publicId = [select id, name, sobjecttype from recordtype where name = 'Public' limit 1].Id;
		Id manualId = [select id, name, sobjecttype from recordtype where name = 'Manual' limit 1].Id;

		insert new FieloPLT__Segment__c(Name = 'Public', recordtypeId = publicId );
		FieloPLT__Segment__c segment = new FieloPLT__Segment__c(Name = 'Manual', recordtypeId = manualId );
		insert segment;

		FieloPLT__Segment__c segment2 = new FieloPLT__Segment__c(Name = 'Manual2', recordtypeId = manualId );
		insert segment2;

		FieloCMS__Post__c post = new FieloCMS__Post__c(Name = 'test', FieloCMSPLT_Segment__c = segment.Id);
		insert post;
		ApexPages.currentPage().getParameters().put('id', post.Id);

		FieloCMSPLT_SegmentsSelectionCtrl sgc = new FieloCMSPLT_SegmentsSelectionCtrl();


		sgc.addSelected();

		sgc.save();

		sgc.cancel();

		sgc.saveAndExit();

		sgc.getRecordName();

		sgc.getObjectLabel();
		
		try{
			apexpages.currentpage().getparameters().put('indexToRemove', '1');
			sgc.remove();
		}catch(Exception e){}


		FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
		insert program;
		FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
		insert member;
		FieloCMSPLT_SegmentsSelectionCtrl.getMetaSegmentId(new List<String>(), program.Id);


		List<String> segmentos = new List<String>();
		segmentos.add(String.valueOf(segment2));
		segmentos.add(String.valueOf(segment));
		FieloCMSPLT_SegmentsSelectionCtrl.getMetaSegmentId(segmentos, program.Id);

	}
	
}