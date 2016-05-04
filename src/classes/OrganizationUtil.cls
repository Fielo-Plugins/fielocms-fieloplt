/**
* @brief Class is used get attributes particulars to the org
*/
public class OrganizationUtil {

  /**
    * @brief returns a list with the API names of the fields in a custom fieldset (comma separated)
    * @param String fieldSet
    */
    public static List<String> getFieldSet(String fieldSet){
        List<String> fields = new List<String>();
        if(fieldSet != null && fieldSet != ''){
            String lang;
            try{
                lang = OrganizationUtil.getLanguage();
            }catch(Exception e){}

            for(Field field : getFieldsStructure(fieldSet)){
                if(field.type != 'SubComponent' && field.type != 'Multimedia'){
                    if(field.multiLanguage){
                        fields.add(field.apiName + '_' + lang + '__c');
                    }else{
                        fields.add(field.apiName);
                    }
                }else if(field.type == 'Multimedia'){
                    fields.add(field.multimediaField);
                }
            }
        }
        return fields;
    }

    public static List<Field> getFieldsStructure(String fieldSet){
        List<Field> fieldsList = new List<Field>();
        if(fieldset != null){
            for(Object field : (List<Object>)JSON.deserializeUntyped(fieldSet)){
                fieldsList.add(new Field((Map<String, Object>)field));
            }
        }
        return fieldsList;
    }

}