public with sharing class FieloCMSPLT_SegmentsSelectionCtrl {
	public List<Schema.FieldSetMember> displayedFields {get; set;}
    public List<SegmentWrapper> selectedSegments {get; set;}
    public List<SegmentWrapper> availableSegments {get; set;}
    public List<String> segmentsToSave {get; set;}
    public String objectName {get; set;}
   
    String Id {get; set;}
    private Id programId {get; set;}
    private SObject record {get; set;}
    private String query {get; set;}
    private String programField;


    public class SegmentWrapper{
        public FieloPLT__Segment__c segment {get; set;}
        public Boolean checkbox {get; set;}

        public SegmentWrapper(FieloPLT__Segment__c segment, Boolean checkbox){
            this.segment = segment;
            this.checkbox = checkbox;
        }
    }

    public FieloCMSPLT_SegmentsSelectionCtrl(){
        id = ApexPages.currentPage().getParameters().get('id');

        String objectPrefix = id.subString(0,3);
        objectName = getObjectName(objectPrefix);

        //obtengo el program del objeto correspondiente y así filtro por los segmentos que tienen el mismo programa o no tiene programa

        String recordQuery;

        if(String.isBlank(programField)){
            record = Database.query('SELECT ' + 'FieloCMSPLT_Segment__c' + ', ' + 'FieloCMSPLT_Segment__r.FieloPLT__RelatedSegments__c FROM ' + objectName + ' WHERE Id =: id' );
        }else{
            record = Database.query('SELECT ' + programField + ', ' + 'FieloCMSPLT_Segment__c' + ', ' + 'FieloCMSPLT_Segment__r' + '.FieloPLT__RelatedSegments__c FROM ' + objectName + ' WHERE Id =: id' );
        }

        programId = String.isBlank(programField) ? null : (Id)record.get(programField);

        FieloPLT__Segment__c segment = (FieloPLT__Segment__c)record.getSObject('FieloCMSPLT_Segment__r');
        String previousSegments;
        Set<String> setPreviousSegments = new Set<String>();

        if(segment != null){
            previousSegments = (String)segment.get('FieloPLT__RelatedSegments__c');
            if(previousSegments != null){
                for(String previousSegment : previousSegments.split(';')){
                    setPreviousSegments.add(previousSegment);
                }
            }else{//si tiene directamente un segment relacionado
                setPreviousSegments.add(((String)segment.get('Id')).substring(0, 15));
            }
        }

        //query all the existing segments for the program  (if it has)
        query = 'SELECT Id, ';

        for(Schema.FieldSetMember f : getFields()) {
            query += f.getFieldPath() + ', ';
        }

        query = query.removeEnd(', ');

        query += ' FROM FieloPLT__Segment__c WHERE';

        if(String.isBlank(programField)){
            query += ' FieloPLT__RelatedSegments__c = \'\' ORDER BY Name';
        }else if(programId == null){
            query += ' FieloPLT__Program__c = null AND FieloPLT__RelatedSegments__c = \'\' ORDER BY Name';
        }else{
            query += ' (FieloPLT__Program__c = null OR FieloPLT__Program__c =: programId) AND FieloPLT__RelatedSegments__c = \'\' ORDER BY Name';
        }

        System.debug(LoggingLevel.ERROR, query);

        List<FieloPLT__Segment__c> segs = Database.query(query);

        //add all the segments into the wrapper list and evaluates in each segment if it was related or not
        selectedSegments = new List<SegmentWrapper>();
        availableSegments = new List<SegmentWrapper>();

        for(FieloPLT__Segment__c seg : segs){
            //si ya estaba seleccionado, va a selected
            if(setPreviousSegments.contains(((String)seg.Id).substring(0,15))){
                SegmentWrapper segWrapper = new SegmentWrapper(seg, true);
                selectedSegments.add(segWrapper);
            }else{//si no va a available
                SegmentWrapper segWrapper = new SegmentWrapper(seg, false);
                availableSegments.add(segWrapper);
            }
        }
    }

    public PageReference addSelected(){
        Integer position = availableSegments.size() - 1;
        while(position >= 0){
            if(availableSegments.get(position).checkbox){
                selectedSegments.add(availableSegments.get(position));
                availableSegments.remove(position);
            }
            position--;
        }

        return null;
    }

    public PageReference save(){
        segmentsToSave = new List<String>();//blanqueo la lista, y voy a agregar los q estén chequeados
        for (SegmentWrapper segWrapper : selectedSegments){
            if(segWrapper.checkbox){
                //segment checked
                segmentsToSave.add(segWrapper.segment.Id);
            }
        }

        record.put('FieloCMSPLT_Segment__c', getMetaSegmentId(segmentsToSave, programId));
        update record;

        return null;

    }

    public PageReference cancel(){
        return new PageReference('/'+id);
    }

    public PageReference saveAndExit(){
        save();
        return cancel();
    }

    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.FieloPLT__Segment__c.FieldSets.FieloCMSPLT_SegmentsSelection.getFields();
    }

    /**
    * @author Agustín Gallardo
    * @date 14/08/2013
    * @param String idPrefix
    * @return String objectName
    * @description Returns a String with the objectName of param Id
    */
    public String  getObjectName(String idPrefix){
		//Done this way due to Security Review
		Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Set<String> keyPrefixSet = gd.keySet();
        for(String sObj : keyPrefixSet){
            Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
            if( idPrefix.equals( r.getKeyPrefix() ))
           		return r.getName();
        }
        return '';
    }

    public String getRecordName(){
        Sobject record;
        String recordname = '';

        try{
            record  = database.query('SELECT Name, Id FROM ' +  objectName + ' WHERE Id =: id');
            recordname = (String)record.get('Name');
        }catch(Exception ex){}

        return recordname;
    }

    public String getObjectLabel(){
         Id recordId = id;
         Schema.SObjectType token = recordId.getSObjectType();
         String objectLabel = token.getDescribe().getLabel();

         return objectLabel;
    }

    public PageReference remove(){
        String indexToRemove = apexpages.currentpage().getparameters().get('indexToRemove');
        Integer index = Integer.valueOf(indexToRemove);
        SegmentWrapper sw = selectedSegments.get(index);
        sw.checkbox = false;
        availableSegments.add(sw);
        selectedSegments.remove(index);

        return null;
    }

    public static Id getMetaSegmentId(List<String> selected, Id programId){
       if(selected.size() == 1){
           return (Id)selected[0];
       }else if(selected.isEmpty()){
           return null;
       }
       selected.sort();
       String segmentsCode = '';
       for(String segmentId : selected){
           segmentsCode += segmentId.substring(0, 15) +  ';';//siempre uso id's de 15 caracteres
       }
       segmentsCode = segmentsCode.removeEnd(';');

       List<FieloPLT__Segment__c> metasegment = [SELECT Id FROM FieloPLT__Segment__c WHERE (FieloPLT__Program__c = :programId OR FieloPLT__Program__c = null) AND FieloPLT__RelatedSegments__c =: segmentsCode AND Recordtype.DeveloperName = 'Metasegment' ];
       if(metasegment.isEmpty()){
           Id metasegmentRTId = [select Id FROM RecordType WHERE DeveloperName = 'Metasegment'].Id;
           FieloCMSPLT_SObjectUnitOfWork uow = new FieloCMSPLT_SObjectUnitOfWork(new List<Schema.SObjectType>{FieloPLT__Segment__c.SObjectType});
           FieloPLT__Segment__c newSegment = new FieloPLT__Segment__c(Name = 'Multiple', FieloPLT__Program__c = programId, FieloPLT__RelatedSegments__c = segmentsCode, RecordtypeId = metasegmentRTId, FieloPLT__IsActive__c = true);
           uow.registerNew(newSegment);
           uow.commitWork();
           return newSegment.Id;
       }

       return metasegment[0].Id;
   }
}