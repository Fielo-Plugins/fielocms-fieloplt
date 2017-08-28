public class FieloCMSPLT_RedemptionsSelector extends FieloCMSPLT_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
                FieloPLT__Redemption__c.Id
            };
    }

    public FieloCMSPLT_RedemptionsSelector(Set<String> fields){
        super(fields);
    }

    public FieloCMSPLT_RedemptionsSelector(){
        super();
    }

    public Schema.SObjectType getSObjectType(){
        return FieloPLT__Redemption__c.sObjectType;
    }

    public List<FieloPLT__Redemption__c> selectById(Set<ID> idSet){
        return (List<FieloPLT__Redemption__c>) selectSObjectsById(idSet);
    }

    public List<FieloPLT__Redemption__c> selectByStatusOriginAndMember(String status, String origin, Id memberId){
        assertIsAccessible();
        return (List<FieloPLT__Redemption__c>) Database.query(
                String.format(
                'select {0} ' +
                  'from {1} ' +
                  'where FieloPLT__Status__c =: status AND FieloPLT__Member__c =: memberId AND FieloPLT__Origin__c =: origin ' + 
                  'order by {2}',
                new List<String> {
                    getFieldListString(),
                    getSObjectName(),
                    getOrderBy() } ) );
    }

    /*
     * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
     * 
    public List<FieloPLT__Redemption__c> selectBySomethingElse(List<String> somethings)
    {
        assertIsAccessible();
        return (List<FieloPLT__Redemption__c>) Database.query(
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