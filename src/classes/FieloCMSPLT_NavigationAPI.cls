global class FieloCMSPLT_NavigationAPI implements FieloCMS.DataInterface{

    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){
        Map<Id,Object> newMapData = new Map<Id,Object>();


        String siteId = Site.getSiteId();

        List<FieloCMS__Site__c> sites = [SELECT Id FROM FieloCMS__Site__c WHERE FieloCMS__SiteId__c =: siteId];
        if(!sites.isEmpty()){
            siteId = sites.get(0).Id;
        }                

        //Prepare all the queries
        for(FieloCMS__Component__c c : components){

            //como hay campos que necesito sí o sí traer en el query, me armo un set en low case de los campos
            Set<String> fieldsToQuery = new Set<String>();
            fieldsToQuery.add('fielocms__url__c');
            fieldsToQuery.add('fielocms__icon__c');
            fieldsToQuery.add('fielocms__cssclasses__c');

            for(String fieldName : FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)){
                fieldsToQuery.add(fieldName.toLowerCase());
            }

            newMapData.put(c.Id, FieloCMSPLT_NavigationService.getNavigations(c.FieloCMS__Navigation__c, fieldsToQuery, siteId, FieloCMSPLT_MemberService.getCurrentMemberId()));
        }

        System.debug(newMapData.values());

        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){
        return null;
    }

}