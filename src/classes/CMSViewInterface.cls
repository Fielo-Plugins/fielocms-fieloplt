/**
 * @brief      Interfaz para implementar una nueva capa de view para algun componente del cms
 * @details    Esta interfaz implementa dos metodos los cuales se usan para la carga inicial de componentes y subcomponentes, y luego para paginadores en caso de vistas o componentes de tipo lista
 */
global interface CMSViewInterface {
    
    /**
     * @brief       Metodo donde se define la logica de renderizado para un componente
     * @details     Dado un componente, un conjunto de datos y un registro de configuracion se devuelve un componente de visualforce
     * @param       component               registro de configuracion del componente que contenga en su configuracion de "ViewReflection" el uso de esta clase
     * @returns     Componente visualforce para mostrar en el sitio
     */
    ApexPages.Component getComponent(CMSComponent__c component);
    
}