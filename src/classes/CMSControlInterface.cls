/**
 * @brief      Interfaz para implementar una funcionalidad para acciones de componentes
 * @details    Esta interfaz implementa un metodo el cual se utiliza en casos de que se haga un componente nuevo que utiliza vistas standard de Fielo y aqui definir la logica luego de realizar cualquier submit
 */
global interface CMSControlInterface {
    /**
     * @brief       Metodo donde se define la logica de accion tras el submit para un componente custom
     * @details     Dado el registro con el cual se hace el submit y el registro de component con la correspondiente configuracion se define la logica, devolviendo una instancia 
     * @param       component   registro de configuracion del componente
     * @param       record      registro enviado por el formulario
     * @param       preComponentsJson   Json con los subcomponentes de validacion que fueron agregados en el fieldset
     * @param       posComponentsJson   Json con los subcomponentes de post action que fueron agregados en el fieldset
     * @returns     Estructura con url de redirect, mensajes de error y acciones de refresh
     * @retval      RemoteActionResult
     * @code{.java}
     *    public class ControlCustomImplementation implements FieloEE.ControlInterface{
     *      
     *        public FieloEE.RemoteActionResult remoteComponentAction(FieloEE__Component__c component, sObject record, String preSubComponentsJson, String posSubComponentsJson){        
     *            FieloEE.RemoteActionResult result = new FieloEE.RemoteActionResult();            
     *            
     *            List<Field> fieldSet = FieloEE.OrganizationUtil.getFieldsStructure(component, compReference.FieloEE__sObject__c);
     *            List<Field> preSubComponents = new List<Field>();
     *            List<Field> posSubComponents = new List<Field>();
     *            for(Field field : fieldSet){                    
     *                if(field.type == 'SubComponent'){
     *                    if(field.subtype == 'Pre'){
     *                        preSubComponents.add(field);
     *                    }else if(field.subtype == 'Post'){
     *                        posSubComponents.add(field);
     *                    }
     *                }
     *            }
     *
     *            try{
     *                //PRE VALIDATIONS
     *                FieloEE.ControlUtil.analizePreSubComponents(preSubComponents, preSubComponentsJson, component);            
     *                if(component.FieloEE__ComponentReference__c == 'CustomComponent1'){                
     *                    insert record;
     *                    result.redirectUtl = 'http://www.google.com';
     *                }else if(component.FieloEE__ComponentReference__c == 'CustomComponent2'){
     *                    update record;
     *                }
     *                //POS ACTIONS
     *                FieloEE.ControlUtil.analizePosSubComponents(posSubComponents, posSubComponentsJson, record, component, result);
     *            }catch(Exception e){
     *                result.addMessage(new FieloEE.RemoteActionResult.RemoteActionMessage());
     *            }
     *
     *            return result;
     *        }            
     *    }
     * @endcode
     */
    CMSRemoteActionResult remoteComponentAction(CMSComponent__c component, sObject record, String subcomponentsJson);
}