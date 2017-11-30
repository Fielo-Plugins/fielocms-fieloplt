@isTest
private class FieloCMSPLT_MediaServiceTest
{
  @isTest
  static void itShould()
  {
    Fielo_SObjectForTest.setAbbreviation();
    
    Account lAccount = Fielo_SObjectForTest.getAccount();
    insert lAccount;

        FieloCMSPLT_MockupFactory.setProgramAndMember();
        
        FieloPLT__Program__c lProgram = [SELECT Id FROM FieloPLT__Program__c];
        
        FieloPLT__Member__c lMember = [SELECT Id FROM FieloPLT__Member__c];

    FieloCMS__Tag__c lTag = new FieloCMS__Tag__c();
    lTag.Name = 'Test';
    lTag.FieloCMS__Items__c = 1;
    insert lTag;

    RecordType lRT = [SELECT id, DeveloperName FROM RecordType WHERE DeveloperName = 'Private' limit 1];
    FieloPLT__Segment__c lSegment = new FieloPLT__Segment__c();
    lSegment.RecordTypeId = lRT.id;
    insert lSegment;

    System.debug('## = ' + lSegment.RecordType +' <lSegment-SELECT> '+ [SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1]);

    Set<String> lFields = new Set<String>();
    lFields.add('Name');

    FieloCMS__Category__c lCategory = new FieloCMS__Category__c();
    insert lCategory;

    FieloCMS__Media__c lMedia = new FieloCMS__Media__c();
    lMedia.FieloCMS__Category__c = lCategory.id;
    insert lMedia;

    FieloCMS__TagItem__c lTagItem = new FieloCMS__TagItem__c();
    lTagItem.FieloCMS__Tag__c = lTag.id;
    lTagItem.FieloCMS__Media__c = lMedia.id;
    insert lTagItem;

    FieloCMSPLT_MediaService.getMedia(lFields, lTag.id, lCategory.id, 1, 1, 'id', lMember.id, null);
  }

  @isTest
  static void itShould2()
  {
    Fielo_SObjectForTest.setAbbreviation();
    
    Account lAccount = Fielo_SObjectForTest.getAccount();
    insert lAccount;

        FieloCMSPLT_MockupFactory.setProgramAndMember();
        
        FieloPLT__Program__c lProgram = [SELECT Id FROM FieloPLT__Program__c];
        
        FieloPLT__Member__c lMember = [SELECT Id FROM FieloPLT__Member__c];

    FieloCMS__Tag__c lTag = new FieloCMS__Tag__c();
    lTag.Name = 'Test';
    lTag.FieloCMS__Items__c = 1;
    insert lTag;

    RecordType lRT = [SELECT id, DeveloperName FROM RecordType WHERE DeveloperName = 'Private' limit 1];
    FieloPLT__Segment__c lSegment = new FieloPLT__Segment__c();
    lSegment.RecordTypeId = lRT.id;
    insert lSegment;

    System.debug('## = ' + lSegment.RecordType +' <lSegment-SELECT> '+ [SELECT Id FROM FieloPLT__Segment__c WHERE RecordType.DeveloperName = 'Private' LIMIT 1]);

    Set<String> lFields = new Set<String>();
    lFields.add('Name');

    FieloCMS__Category__c lCategory = new FieloCMS__Category__c();
    insert lCategory;

    FieloCMS__Media__c lMedia = new FieloCMS__Media__c();
    lMedia.FieloCMS__Category__c = lCategory.id;
    insert lMedia;

    FieloCMS__TagItem__c lTagItem = new FieloCMS__TagItem__c();
    lTagItem.FieloCMS__Tag__c = lTag.id;
    lTagItem.FieloCMS__Media__c = lMedia.id;
    insert lTagItem;

    FieloCMSPLT_MediaService.getMedia(lFields, null, lCategory.id, 1, 1, 'id', lMember.id, null);
  }
}