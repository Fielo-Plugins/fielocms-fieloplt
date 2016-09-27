public with sharing class AgreementAcceptController {

    public FieloPLT__Agreement__c agreement {get;set;}
    public Boolean acceptAgreement {get;set;}

    private FieloPLT__Member__c member;

    public AgreementAcceptController() {
        acceptAgreement = false;
        //looks for the current agreement and the logged in user
        member = [SELECT Id, FieloPLT__Program__c FROM FieloPLT__Member__c WHERE Id =: MemberService.getCurrentMemberId()];        
        agreement = [SELECT Id, FieloPLT__Agreement__c FROM FieloPLT__Agreement__c WHERE FieloPLT__Status__c = 'Current' AND FieloPLT__Program__c =: member.FieloPLT__Program__c LIMIT 1];
    }

    public PageReference doSave(){
        //if the member exists and have accepted the agreement then updates the agreement for the member
        if(acceptAgreement){
            member.FieloPLT__Agreement__c = agreement.Id;
            FieloPLT.OrganizationUtil.validateReadOnlyFieldsMember(false);
            try{
                upsert member;
            }catch(DMLException e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, e.getDMLMessage(0)));
                return null;                    
            }                
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error, 'You must accept the agreement to continue.'));
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