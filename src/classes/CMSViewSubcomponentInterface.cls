/**
 * @brief      Interfaz para implementar una nueva capa de view para algun subcomponente del cms
 */
global interface CMSViewSubcomponentInterface {
        
    /**
     * @brief       Metodo donde se define la logica de renderizado para un subcomponente
     * @details     Dado un componente, un Field con toda su informacion y un registro de datos se devuelve un componente de visualforce
     * @param       field           instancia de la clase Field donde esta toda la informacion del subcomponente a renderizar
     * @param       record          registro en el cual se va a instanciar el sub componente
     * @returns     Componente visualforce para mostrar en el sitio
     */
    ApexPages.Component getSubComponent(CMSField field, SObject record);
}