/**
* @brief Class is used get attributes particulars to the org
*/
public class OrganizationUtil {

  /**
    * @brief returns a list with the API names of the fields in a custom fieldset (comma separated)
    * @param String fieldSet
    */
    public static Set<String> getFieldSet(String fieldSet){
        Set<String> fields = new Set<String>();
        if(String.isNotBlank(fieldSet)){
            /*String lang;
            try{
                lang = FieloAlpha.OrganizationUtil.getLanguage();
            }catch(Exception e){}*/

            for(Object field : (List<Object>)JSON.deserializeUntyped(fieldSet)){
                /*if(field.type != 'SubComponent' && field.type != 'Multimedia'){
                    if(field.multiLanguage){
                        fields.add(field.apiName + '_' + lang + '__c');
                    }else{*/
                    Map<String, Object> attributesMap = (Map<String, Object>)field;
                    if(attributesMap.get('type') != 'Subcomponent'){
                        fields.add((String)attributesMap.get('apiName'));
                    }
                    /*}
                }else if(field.type == 'Multimedia'){
                    fields.add(field.multimediaField);
                }*/
            }
        }
        return fields;
    }
}