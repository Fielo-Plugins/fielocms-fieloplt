/**
 * @brief      Interfaz para implementar una nueva capa de datos para algun componente del cms
 * @details    Esta interfaz implementa dos metodos los cuales se usan para la carga inicial de datos, y luego para paginadores en caso de vistas o componentes de tipo lista
 */
global interface CMSDataInterface {    
    
    /**
     * @brief       Metodo donde se define la logica de datos para la carga inicial de datos de un componente
     * @details     Dado una lista de componentes, se asocia el correspondiente set de datos a mostrar en el sitio para cada componente
     * @version     10.0     
     * @param       components  registros de configuracion de los componentes que contengan en su configuracion de "DataReflection" el uso de esta clase     
     * @returns     Mapa que contiene como key el id de cada componente que se recibio y como value, el set de datos en cualquier formato
     * @retval      Map<Id, Object> Para todo componente ingresado el mapa debe devolver un key en el mapa siempre y cuando encuentre datos para ese componente
     *                      <ul>
     *                         <li> Object = El tipo de dato puede ser cualquiera pero debe mantener consistencia con la capa de View ya que los datos se envian directamente a la interfaz ViewInterface
     *                      </ul>
     */
    Map<Id, Object> getBulkData(List<CMSComponent__c> components);
    
    /**
     * @brief       Metodo donde se define la logica de datos para las acciones posteriores a la carga inicial que son pedidas desde el sitio
     * @details     Dado un componente y una serie de filtros se devuelve un set de datos a mostrar en el sitio
     * @param       component   registro de configuracion del componente que esta llamando la API
     * @param       pageNumber  indice de numero de pagina desde donde se quiere devolver los datos
     * @param       orderBy     campo por el cual se quiere ordenar el set de registros
     * @param       filters     Json con filtros adicionales provenientes del sitio
     * @returns     Lista de datos en base a los filtros y la configuracion del componente
     * @retval      List<Object> La lista puede ser de cualquier tipo de dato
     * @code{.java}
     *      public class DataCustomImplementation implements FieloEE.DataInterface{
     *
     *          public Map<Id, Object> getBulkData(List<FieloEE__Component__c> components){
     *              return null;
     *          }
     *          
     *          public List<sObject> getData(Component__c component, Integer pageNumber, String orderBy, String filters){
     *              List<String> fieldSet = FieloEE.OrganizationUtil.getFieldSet(c.FieloEE__FieldSet__c);        
     *              List<CustomObject__c> records = CustomAPI.getRecords(fieldset, pageNumber, orderBy, filters);
     *              return records;
     *          }          
     *      }
     * @endcode
     */
    List<sObject> getData(CMSComponent__c component, Integer pageNumber, String orderBy, String filters);
}