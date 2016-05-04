/**
 * @brief      Clase wrapper con toda la informacion de un campo agregado en un fieldset de un componente para ser mostrado en Front End
 * @details    Contiene datos relacionados con atributos propios de un campo, atributos de un subcomponente, multi language, visibilidad y seguridad
 */
global class CMSField{
    global String apiName {get;set;}
    global String label {get;set;}

    global Map<String,String> attributesMap {get; set;}

}