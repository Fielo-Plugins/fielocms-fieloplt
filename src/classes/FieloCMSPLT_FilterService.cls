public with sharing class FieloCMSPLT_FilterService {
	
	public static String getDynamicWhereCondition(String jsonCondition, String objectName, String prefix){
        List<FilterWrapper> filterWrappers;
        try{
            filterWrappers = (List<FilterWrapper>)JSON.deserializeStrict(jsonCondition, List<FilterWrapper>.class);
        }catch(Exception e){
            throw new FieloPLT.FieloException('JSON wrong format');
        }
        
        if(filterWrappers.isEmpty()){
            return '';
        }

        Map<String,String> operatorsMap = new Map<String,String>{'equals'=>'=','not equals'=>'!=','greater than'=>'>','greater or equal'=>'>=','less than'=>'<','less or equal'=>'<=','in'=>'','like'=>'like'};
        Set<String> andoroperators = new Set<String>{'and','or'};
        Set<String> nonQuotedTypes = new Set<String>{'DOUBLE','DATETIME','DATE','CURRENCY','INTEGER','BOOLEAN','PERCENT','TIME'};
        Map<String,Schema.SObjectField> fieldsTypeMap = Schema.describeSObjects(new String[]{objectName})[0].getSObjectType().getDescribe().fields.getMap();   
        
        deepLevel = 0;
        return getWhereCondition(filterWrappers, operatorsMap, andoroperators, nonQuotedTypes, fieldsTypeMap, prefix);
    }

    public class FilterWrapper{
        public String andOrOperator;
        public String openPars;
        public String field;
        public String operator;
        public String value;
        public String closePars;
        public SubQueryFilter subQueryFilter;

        public FilterWrapper(){}

        public FilterWrapper(String andOrOperator, String openPars, String field, String operator, String value, String closePars){
			this.andOrOperator = andOrOperator;
			this.openPars = openPars;
			this.field = field;
			this.operator = operator;
			this.value = value;
			this.closePars = closePars;
        }

        public FilterWrapper(String andOrOperator, String openPars, String field, SubQueryFilter subQueryFilter, String closePars){
			this.andOrOperator = andOrOperator;
			this.openPars = openPars;
			this.field = field;
			this.operator = 'in';
			this.closePars = closePars;
			this.subQueryFilter = subQueryFilter;
        }
    }

    public class SubQueryFilter{
        public String field;
        public String objectName;
        public List<FilterWrapper> filters;

        public SubQueryFilter(){}

        public SubQueryFilter(String field, String objectName, List<FilterWrapper> filters){
        	this.field = field;
	        this.objectName = objectName;
	        this.filters = filters;
        }
    }

    private static Integer deepLevel = 0;
    private static String getWhereCondition(List<FilterWrapper> filterWrappers, Map<String,String> operatorsMap, Set<String> andoroperators, Set<String> nonQuotedTypes, Map<String,Schema.SObjectField> fieldsTypeMap, String prefix){
        deepLevel++;
        String whereCondition = '';
        Integer position = 0;
        Integer parCounter = 0;
        Boolean hasOrConditions = false;
        Boolean hasInConditions = false;

        for(FilterWrapper filter : filterWrappers){
            if(!String.isBlank(filter.andOrOperator)){
                if(position == 0){
                    filter.andOrOperator = null;
                }else if(!andoroperators.contains(filter.andOrOperator)){
                    throw new FieloPLT.FieloException('And_Or Operator ' + filter.andOrOperator + ' not found.');
                }
            }else if(position != 0){
                filter.andOrOperator = 'and';
            }
            
            if(String.isBlank(filter.field) || !fieldsTypeMap.containsKey(filter.field)){
                throw new FieloPLT.FieloException('Field ' + filter.field + ' not found in object.');
            }

            if(!String.isBlank(filter.operator)){
                if(!operatorsMap.containsKey(filter.operator)){
                    throw new FieloPLT.FieloException('Operator ' + filter.operator + ' not found.');
                }
            }else{
                filter.operator = 'equals';
            }

            if(filter.operator == 'in' && filter.SubQueryFilter == null){
                throw new FieloPLT.FieloException('SubQueryFilter is required for operator "in".');
            }

            if(!String.isBlank(filter.andOrOperator)){
                whereCondition += ' ' + filter.andOrOperator + ' ';

                if(filter.andOrOperator == 'or'){
                    hasOrConditions = true;
                }
            }
            
            if(String.isNotBlank(filter.openPars)){
                Integer i = 0;
                while(i < filter.openPars.length()){
                    if(filter.openPars.substring(i,i+1) != '('){
                        throw new FieloPLT.FieloException('Incorrect carhacter ' + filter.openPars + ' for openPars attribute.');
                    }else{
                        parCounter++;
                    }
                    i++;
                }
                whereCondition += filter.openPars;
            }

            if(filter.operator != 'in'){
                String fieldType = fieldsTypeMap.get(filter.field).getDescribe().getType().name();
                if(filter.value == null){
                    whereCondition += prefix + filter.field + ' ' + operatorsMap.get(filter.operator) + ' null ';
                }else if(nonQuotedTypes.contains(fieldType)){
                    if(fieldType == 'DATE'){
                        filter.value = String.valueOf(DateTime.newInstance(Long.valueOf(filter.value)).formatGmt('yyyy-MM-dd'));
                    }else if(fieldType == 'DATETIME'){
                        filter.value = String.valueOf(DateTime.newInstance(Long.valueOf(filter.value)).formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''));
                    }
                    whereCondition += prefix + filter.field + ' ' + operatorsMap.get(filter.operator) + ' ' + filter.value;
                } else if(filter.operator == 'like'){
                    whereCondition += prefix + filter.field + ' ' + operatorsMap.get(filter.operator) + ' \'%' + filter.value + '%\'';
                }else{
                    whereCondition += filter.field + ' ' + operatorsMap.get(filter.operator) + ' \'' + filter.value + '\'';
                }
            }else{
                hasInConditions = true;
                if(deepLevel > 1){
                    throw new FieloPLT.FieloException('Subquery not supported inside another subquery');
                }

                Schema.DescribeSobjectResult[] results = Schema.describeSObjects(new List<String>{filter.subQueryFilter.objectName});
                if(results == null){
                    throw new FieloPLT.FieloException('Invalid object ' + filter.subQueryFilter.objectName);
                }
                
                Map<String,Schema.SObjectField> fieldsTypeMapSubQuery = results[0].fields.getMap();
                if(String.isBlank(filter.subQueryFilter.field) || !fieldsTypeMapSubQuery.containsKey(filter.subQueryFilter.field)){
                    throw new FieloPLT.FieloException('Field ' + filter.field + ' not found in object.');
                }

                whereCondition += prefix + filter.field + ' in (SELECT ' + filter.subQueryFilter.field + ' FROM ' + filter.subQueryFilter.objectName + ' WHERE ' + getWhereCondition(filter.subQueryFilter.filters, operatorsMap, andoroperators, nonQuotedTypes, fieldsTypeMapSubQuery, prefix) + ')';
            }

            if(String.isNotBlank(filter.closePars)){
                Integer i = 0;
                while(i < filter.closePars.length()){
                    if(filter.closePars.substring(i,i+1) != ')'){
                        throw new FieloPLT.FieloException('Incorrect carhacter ' + filter.closePars + ' for closePars attribute.');
                    }else{
                        parCounter--;
                    }
                    i++;
                }
                whereCondition += filter.closePars;
            }

            position++;
        }

        if(parCounter != 0){
            throw new FieloPLT.FieloException('Parenthesis error in formula.');
        }

        if(hasOrConditions){
            if(hasInConditions){
                throw new FieloPLT.FieloException('Cannot use in condition and or in the same query.');
            }else{
                return '(' + whereCondition + ')';
            }
        }else{
            return whereCondition;
        }
    }
}