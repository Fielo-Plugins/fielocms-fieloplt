/**
* @description
*/
global with sharing class FieloCMSPLT_MediaAPI implements FieloCMS.DataInterface{

    /**
    * @brief Method to get the data on execution
    * @param List<FieloCMS__Component__c> components
    * @return Map<Id, List<sObject>>
    **/
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){


        Map<Id,Object> newMapData = new Map<Id,Object>();

        Set<String> fieldSet = new Set<String>();
        Map<Id, Id> mapComponentRecord = new Map<Id, Id>();
        for(FieloCMS__Component__c c : components) {
            if(c.FieloCMS__ComponentLibrary__r.FieloCMS__RecordType__c == 'List'){
                newMapData.put(c.Id, FieloCMSPLT_MediaService.getMedia(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), c.FieloCMS__Tag__c, c.FieloCMS__Category__c, c.FieloCMS__Limit__c.intValue(), 0, c.FieloCMS__OrderBy__c, FieloCMSPLT_MemberService.getCurrentMemberId(), null));
            } else if(c.FieloCMS__ComponentLibrary__r.FieloCMS__RecordType__c == 'Record') {
                fieldSet.addAll( FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c) );
                if ( String.isBlank(c.FieloCMS__RecordId__c) ) {
                    mapComponentRecord.put( c.Id , ApexPages.CurrentPage().getParameters().get( c.FieloCMS__DetailParameter__c ) );
                } else {
                    mapComponentRecord.put( c.Id , c.FieloCMS__RecordId__c );
                }
            }
        }
        if ( !mapComponentRecord.isEmpty() ) {
            List<Id> records = mapComponentRecord.values();
            String query = 'SELECT ' + String.join( new List<String>(fieldSet) ,',') + ' FROM FieloCMS__Media__c WHERE Id IN :records ' ;
            Map<Id,SObject> mapRecords = new Map<Id,SObject>( Database.query( query ) );
            for(Id compId : mapComponentRecord.keySet() ) {
                newMapData.put( compId, mapRecords.get( mapComponentRecord.get(compId) ) );
            }
        }

        System.debug(newMapData);

        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){

        List<SObject> newData = new List<SObject>();
        if(String.isNotBlank(filters)){
            List<FieloCMSPLT_FilterService.FilterWrapper> filtersList = (List<FieloCMSPLT_FilterService.FilterWrapper>) JSON.deserialize(filters, List<FieloCMSPLT_FilterService.FilterWrapper>.class);
            //Map<String,Object> filtersMap = (Map<String,Object>) JSON.deserializeUntyped(filters);
            if(!filtersList.isEmpty()){
                for(Integer i = filtersList.size() - 1; i > 0; i--){
                    if(filtersList[i].field == 'FieloCMS__Category__c' || filtersList[i].field == 'FieloCMS__Tag__c'){
                        if(filtersList[i].value != null){
                            component.put(filtersList[i].field, filtersList[i].value);
                        }
                        filtersList.remove(i);
                    }else if(String.isBlank(filtersList[i].value)){
                        filtersList.remove(i);
                    }
                }
            }
            filters = JSON.serialize(filtersList);
        }

        //Prepare all the queries        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        return FieloCMSPLT_MediaService.getMedia(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), component.FieloCMS__Tag__c, component.FieloCMS__Category__c, component.FieloCMS__Limit__c.intValue(), offset, orderBy, FieloCMSPLT_MemberService.getCurrentMemberId(), filters);
    }
}
