public class FieloCMSPLT_OrganizationUtil {

    public static Set<String> getFieldSet(String fieldSet){
        Set<String> fields = new Set<String>();
        if(String.isNotBlank(fieldSet)){

            for(Object field : (List<Object>)JSON.deserializeUntyped(fieldSet)){

                Map<String, Object> attributesMap = (Map<String, Object>)field;
                if(attributesMap.get('type') != 'Subcomponent'){
                    fields.add((String)attributesMap.get('apiName'));
                }else if (attributesMap.containsKey( 'fieldName')) {
                    fields.add((String)attributesMap.get('fieldName'));
                }
            }
        }
        return fields;
    }

    public static Boolean testPersonAccountEnabled = false;
    public static Boolean isPersonAccountEnabled(){
        if(System.Test.isRunningTest()){
            return testPersonAccountEnabled;
        }
        Map<String, Schema.SObjectField> M = Schema.SObjectType.Account.fields.getMap();
        //Boolean flag to detect person account enabled or not
        Boolean isPersonAccountEnabled = M.containsKey('IsPersonAccount');
        return isPersonAccountEnabled;
    }
}