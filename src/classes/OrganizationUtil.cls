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

            for(FieloCMS.Field field : getFieldsStructure(fieldSet)){
                /*if(field.type != 'SubComponent' && field.type != 'Multimedia'){
                    if(field.multiLanguage){
                        fields.add(field.apiName + '_' + lang + '__c');
                    }else{*/
                        fields.add(field.apiName);
                    /*}
                }else if(field.type == 'Multimedia'){
                    fields.add(field.multimediaField);
                }*/
            }
        }
        return fields;
    }

    public static List<FieloCMS.Field> getFieldsStructure(String fieldSet){
        List<FieloCMS.Field> fieldsList = new List<FieloCMS.Field>();
        if(fieldset != null){
            for(Object field : (List<Object>)JSON.deserializeUntyped(fieldSet)){
                FieloCMS.Field fieldn = new FieloCMS.Field();
                //fieldsList.add(new FieloCMS.Field((Map<String, Object>)field));
            }
        }
        return fieldsList;
    }

}