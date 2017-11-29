@isTest
private class FieloCMSPLT_FilterServiceTest{
    @isTest
    static void itShouldSimple(){    
        String jsonCondition = '[ {"field":"Name", "operator":"not equals", "value":"ACME", "andOrOperator" :""} ]';        
        String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
        System.assertEquals(query, 'Name != \'ACME\'');
            
    }

    @isTest
    static void filterTest(){
        

        FieloCMSPLT_FilterService.FilterWrapper lFilterWrapper = new FieloCMSPLT_FilterService.FilterWrapper('test', 'test', 'test', 'test', 'test', 'test');
        FieloCMSPLT_FilterService.FilterWrapper lFilterWrapper2 = new FieloCMSPLT_FilterService.FilterWrapper();
        List<FieloCMSPLT_FilterService.FilterWrapper> filters = new List<FieloCMSPLT_FilterService.FilterWrapper>();

        FieloCMSPLT_FilterService.SubQueryFilter lSubQueryFilter = new  FieloCMSPLT_FilterService.SubQueryFilter('test', 'test', filters);

        FieloCMSPLT_FilterService.FilterWrapper lFilterWrapper3 = new FieloCMSPLT_FilterService.FilterWrapper('test', 'test', 'test', lSubQueryFilter, 'test');
    }

    @isTest    
    static void itShouldOR(){    
        String jsonCondition = '[ {"field":"Name", "operator":"equals", "value":"ACME", "andOrOperator" :""}, {"field":"CreatedDate", "operator":"greater than", "value":"20000101", "andOrOperator" :"or"} ]';        
        String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
        System.assertEquals(query, '(Name = \'ACME\' or CreatedDate > 1970-01-01T05:33:20.101Z)');
            
    }

    @isTest
    static void itShouldAND(){    
        String jsonCondition = '[ {"field":"Name", "operator":"equals", "value":"ACME", "andOrOperator" :""}, {"field":"CreatedDate", "operator":"less than", "value":"20000101", "andOrOperator" :"and"} ]';        
        String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
        System.assertEquals(query, 'Name = \'ACME\' and CreatedDate < 1970-01-01T05:33:20.101Z');
    }
    
    @isTest
    static void itShouldIN(){    
        String jsonCondition = '[ { "field":"Id", "operator":"in", "subQueryFilter":{ "field":"AccountId","objectName":"Contact", "filters":[{ "field":"LastName", "value":"Smith" }]    }} ]';        
        String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
        System.assertEquals(query, 'Id in (SELECT AccountId FROM Contact WHERE LastName = \'Smith\')');

        // Withpout subQuert
        try { 
            jsonCondition = '[ { "field":"Id", "operator":"in" } ]';        
            query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
       } catch ( Exception e ) {
           system.debug(e.getMessage());
            Boolean expectedExceptionThrown =  e.getMessage().contains('SubQueryFilter is required for operator') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
       }            
                
    }

    @isTest
    static void itShouldNotFindOperator(){ 
        try { 
            String jsonCondition = '[ {"field":"Name", "operator":"no existe", "value":"ACME", "andOrOperator" :""} ]';        
            String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
       } catch ( Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Operator no existe not found') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
       }            
    }

    @isTest
    static void itShouldNotJson(){ 
        try { 
            String jsonCondition = '[ {"field":"Name", "operator":"no existe", "value":"ACME", "andOrOperator"';        
            String query = FieloCMSPLT_FilterService.getDynamicWhereCondition( jsonCondition, 'Account', '' );
       } catch ( Exception e ) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('JSON wrong format') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
       }            
    }

}