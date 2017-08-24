public with sharing class FieloCMSPLT_ProgramsSelector extends FieloCMSPLT_SObjectSelector{
  public List<Schema.SObjectField> getSObjectFieldList(){
    return new List<Schema.SObjectField> {
        FieloPLT__Program__c.Id,
        FieloPLT__Program__c.Name,
        FieloPLT__Program__c.FieloPLT__RequestMemberAuthorization__c,
        FieloPLT__Program__c.FieloPLT__UserCreationClass__c
      };
  }

  public Schema.SObjectType getSObjectType(){
    return FieloPLT__Program__c.sObjectType;
  }

  public List<FieloPLT__Program__c> selectById(Set<Id> idSet){
    return (List<FieloPLT__Program__c>)selectSObjectsById(idSet);
  }

    private Id lastProgramId;
  private FieloPLT__Program__c staticProgram;
  public FieloPLT__Program__c selectStaticProgram(Id programId){
    if(lastProgramId == null || lastProgramId != programId){
      lastProgramId = programId;
      Set<String> fieldSet = getFieldList();
      setFieldList(getAllFields());
      staticProgram = selectById(new Set<Id>{programId})[0];
      setFieldList(fieldSet);
    }

        FieloPLT__Program__c returnProgram = new FieloPLT__Program__c(Id = staticProgram.Id);
        for(String field : getFieldList()){
            try{
                returnProgram.put(field, staticProgram.get(field));
            }catch(Exception e){
                return staticProgram;
            }
        }
        return returnProgram;
  }

  public FieloCMSPLT_ProgramsSelector(Set<String> fields){
    super(fields);
  }

  public FieloCMSPLT_ProgramsSelector(){
    super();
  }

  public FieloCMSPLT_ProgramsSelector(Boolean allFields){
    if(!allFields){
      this();
    }else{
      setFieldList(getAllFields());
    }
  }

  private static Set<String> getAllFields(){
        //String query = ' ';
        Set<String> fieldSet = new Set<String>();
        FieloPLT__PublicSettings__c settings = FieloPLT__PublicSettings__c.getOrgDefaults();
        //If the Custom Setting is not empty then used the Optimized query
        if(settings.FieloPLT__OptimizedProgramQuery__c){
            //If its the Default Case use only Standard Field
            fieldSet.addAll(new Set<String>{'Name','FieloPLT__RewardInjectQuery__c','FieloPLT__SegmentInjectQuery__c','FieloPLT__CategoryInjectQuery__c','FieloPLT__ExpirationPeriod__c','FieloPLT__NumberOfVoucherDigits__c','FieloPLT__ActualPointCost__c','FieloPLT__RequestRedemptionAuthorization__c','FieloPLT__RequestMemberAuthorization__c','RequestTransactionAuthorization__c','FieloPLT__RequestTransactionAuthorization__c','FieloPLT__OnlineTransactionProcessing__c','FieloPLT__UseAgreement__c','FieloPLT__UserCreationClass__c'});
            for(Schema.FieldSetMember fsm : Schema.SObjectType.FieloPLT__Program__c.fieldSets.FieloPLT__ProgramQuery.getFields()){
                fieldSet.add(fsm.getFieldPath());
            }
        }else{
            //Use Describe to get all the Fields
            Map<String, Schema.SObjectField> fields = FieloPLT__Program__c.SObjectType.getDescribe().fields.getMap();
            Set<String> fieldFilter = new Set<String> {'CreatedById', 'IsDeleted', 'OwnerId', 'LastModifiedDate', 'LastModifiedById', 'SystemModstamp'};
            for(Schema.SObjectField field : fields.values()){
                fieldSet.add(field.getDescribe().getName());
            }
        }
        return fieldSet;
    }

  //private static FieloPLT__Program__c programBySiteUrl;
  public FieloPLT__Program__c selectBySiteUrl(String siteDomain){
    //if(programBySiteUrl == null){
          if(siteDomain != null) siteDomain = siteDomain.replace('.secure.','.');
          System.debug(loggingLevel.Error, '*** siteDomain: ' + siteDomain);

      assertIsAccessible();
      List<FieloPLT__Program__c> programs = (List<FieloPLT__Program__c>) Database.query(
          String.format(
          'select {0} ' +
            'from {1} ' +
            'where FieloCMSPLT_SiteDomain__c =: siteDomain ' +
            'order by {2}',
          new List<String> {
            getFieldListString(),
            getSObjectName(),
            getOrderBy() } ) );

          if(!programs.isEmpty()){
              //programBySiteUrl = programs.get(0);
              return programs.get(0);
          }else{
              //programBySiteUrl = selectByDefault();
              return selectByDefault();
          }
      //}
      //return programBySiteUrl;
  }

  /*FieloPLT__Program__c p = getProgramByDomain();
    FieloPLT__Program__c returnProgram = new FieloPLT__Program__c(Id = p.Id);
    Map<String, Schema.SObjectField> fieldsDescribe = FieloPLT__Program__c.SObjectType.getDescribe().fields.getMap();
    if(fields != null){
        for(String field : fields){
            try{
                returnProgram.put(field, p.get(field));
            }catch(Exception e){
                return p;
            }
        }
    }
    return returnProgram;*/

  private static FieloPLT__Program__c programDefault;
  public FieloPLT__Program__c selectByDefault(){
    programDefault = (FieloPLT__Program__c) Database.query(
        String.format(
        'select {0} ' +
          'from {1} ' +
          'where FieloPLT__IsDefault__c = true ' +
          'order by {2}',
        new List<String> {
          getFieldListString(),
          getSObjectName(),
          getOrderBy() } ) );

    return programDefault;
  }

  public List<FieloPLT__Program__c> selectAll(){
    return (List<FieloPLT__Program__c>) Database.query(
      String.format(
      'select {0} ' +
        'from {1} ' +
        'order by {2}',
      new List<String> {
        getFieldListString(),
        getSObjectName(),
        getOrderBy() } ) );
  }

  /*
   * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
   *
  public List<FieloPLT__Program__c> selectBySomethingElse(List<String> somethings)
  {
    assertIsAccessible();
    return (List<FieloPLT__Program__c>) Database.query(
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
