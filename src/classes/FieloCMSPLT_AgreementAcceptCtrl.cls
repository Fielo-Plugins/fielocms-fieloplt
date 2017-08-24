public with sharing class FieloCMSPLT_AgreementAcceptCtrl {

    public Boolean showAgreement {get; set;}
    public FieloPLT__Agreement__c agreement {get; set;}

    public FieloCMSPLT_AgreementAcceptCtrl(){
        //looks for the current agreement and the logged in user
        FieloPLT__Member__c member = new FieloCMSPLT_MembersSelector(new Set<String>{'Id', 'FieloPLT__Agreement__c', 'FieloPLT__Program__c'}).selectById(new Set<Id>{FieloCMSPLT_MemberService.getCurrentMemberId()})[0];
        List<FieloPLT__Agreement__c> agreements = new FieloCMSPLT_AgreementsSelector(new Set<String>{'Id', 'FieloPLT__Agreement__c '}).selectCurrentByProgram(member.FieloPLT__Program__c);
    
        showAgreement = false;
        if(!agreements.isEmpty()){
            //chequeo si el member tiene el último agreement aceptado
            agreement = agreements[0];
            showAgreement = member.FieloPLT__Agreement__c != agreements[0].Id;
        }
    }

    public static PageReference doSave(){
        FieloPLT__Member__c member = new FieloCMSPLT_MembersSelector(new Set<String>{'Id', 'FieloPLT__Agreement__c', 'FieloPLT__Program__c'}).selectById(new Set<Id>{FieloCMSPLT_MemberService.getCurrentMemberId()})[0];
        List<FieloPLT__Agreement__c> agreements = new FieloCMSPLT_AgreementsSelector(new Set<String>{'Id'}).selectCurrentByProgram(member.FieloPLT__Program__c);
        //if the member exists and have accepted the agreement then updates the agreement for the member
        member.FieloPLT__Agreement__c = agreements[0].Id;
        FieloPLT.SObjectService.enableAdminPermission(true);
        try{
            upsert member;
        }catch(DMLException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, e.getDMLMessage(0)));
            return null;                    
        }                

        //if no errors checks then returns to the ret url
        if(!ApexPages.hasMessages()){
            String retUrl = ApexPages.currentPage().getParameters().get('retUrl');
            if(retUrl != null){
                return new PageReference('/' + retUrl);
            }
        }
        return null;
    }
        
}
