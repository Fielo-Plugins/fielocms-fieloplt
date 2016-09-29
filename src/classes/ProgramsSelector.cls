public with sharing class ProgramsSelector extends SObjectSelector{
  public List<Schema.SObjectField> getSObjectFieldList(){
    return new List<Schema.SObjectField> {
        Program__c.Id,
        Program__c.Name,
        Program__c.RequestMemberAuthorization__c,
        Program__c.UserCreationClass__c,
                Program__c.AuditPoints__c,
                Program__c.ExpirationMode__c,
                Program__c.PointsSpendingMode__c
      };
  }

  public Schema.SObjectType getSObjectType(){
    return Program__c.sObjectType;
  }

  public List<Program__c> selectById(Set<Id> idSet){
    return (List<Program__c>)selectSObjectsById(idSet);
  }

    private Id lastProgramId;
  private Program__c staticProgram;
  public Program__c selectStaticProgram(Id programId){
    if(lastProgramId == null || lastProgramId != programId){
      lastProgramId = programId;
      Set<String> fieldSet = getFieldList();
      setFieldList(getAllFields());
      staticProgram = selectById(new Set<Id>{programId})[0];
      setFieldList(fieldSet);
    }

        Program__c returnProgram = new Program__c(Id = staticProgram.Id);
        for(String field : getFieldList()){
            try{
                returnProgram.put(field, staticProgram.get(field));
            }catch(Exception e){
                return staticProgram;
            }
        }
        return returnProgram;
  }

  public ProgramsSelector(Set<String> fields){
    super(fields);
  }

  public ProgramsSelector(){
    super();
  }

  public ProgramsSelector(Boolean allFields){
    if(!allFields){
      this();
    }else{
      setFieldList(getAllFields());
    }
  }

  private static Set<String> getAllFields(){
        //String query = ' ';
        Set<String> fieldSet = new Set<String>();
        PublicSettings__c settings = PublicSettings__c.getOrgDefaults();
        //If the Custom Setting is not empty then used the Optimized query
        if(settings.OptimizedProgramQuery__c){
            //If its the Default Case use only Standard Field
            fieldSet.addAll(new Set<String>{'Name','RewardInjectQuery__c','SegmentInjectQuery__c','CategoryInjectQuery__c','TagInjectQuery__c','Image__c','AuditPoints__c','IsDefault__c','ExpirationMode__c','ExpirationPeriod__c','InstructionsReward__c','VoucherInstructions__c','Language__c','Locale__c','NumberOfVoucherDigits__c','OpenRedemptionDays__c','PointCost__c','RequestRedemptionAuthorization__c','RequestMemberAuthorization__c','RequestTransactionAuthorization__c','ShowVoucherCode__c','PointsSpendingMode__c','OnlineTransactionProcessing__c','UseAgreement__c','UserCreationClass__c'});
            for(Schema.FieldSetMember fsm : Schema.SObjectType.Program__c.fieldSets.ProgramQuery.getFields()){
                fieldSet.add(fsm.getFieldPath());
            }
        }else{
            //Use Describe to get all the Fields
            Map<String, Schema.SObjectField> fields = Program__c.SObjectType.getDescribe().fields.getMap();
            Set<String> fieldFilter = new Set<String> {'CreatedById', 'IsDeleted', 'OwnerId', 'LastModifiedDate', 'LastModifiedById', 'SystemModstamp'};
            for(Schema.SObjectField field : fields.values()){
                fieldSet.add(field.getDescribe().getName());
            }
        }
        return fieldSet;
    }

  //private static Program__c programBySiteUrl;
  public Program__c selectBySiteUrl(String siteDomain){
    //if(programBySiteUrl == null){
          if(siteDomain != null) siteDomain = siteDomain.replace('.secure.','.');

      assertIsAccessible();
      List<Program__c> programs = (List<Program__c>) Database.query(
          String.format(
          'select {0} ' +
            'from {1} ' +
            'where SiteDomain__c =: siteDomain ' +
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

  /*Program__c p = getProgramByDomain();
    Program__c returnProgram = new Program__c(Id = p.Id);
    Map<String, Schema.SObjectField> fieldsDescribe = Program__c.SObjectType.getDescribe().fields.getMap();
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

  private static Program__c programDefault;
  public Program__c selectByDefault(){
    programDefault = (Program__c) Database.query(
        String.format(
        'select {0} ' +
          'from {1} ' +
          'where IsDefault__c = true ' +
          'order by {2}',
        new List<String> {
          getFieldListString(),
          getSObjectName(),
          getOrderBy() } ) );

    return programDefault;
  }

  public List<Program__c> selectAll(){
    return (List<Program__c>) Database.query(
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
  public List<Program__c> selectBySomethingElse(List<String> somethings)
  {
    assertIsAccessible();
    return (List<Program__c>) Database.query(
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