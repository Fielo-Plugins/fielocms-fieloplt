public with sharing class AgreementAcceptController {

    public FieloAlpha__Agreement__c agreement {get;set;}
    public Boolean acceptAgreement {get;set;}

    private FieloAlpha__Member__c member;

    public AgreementAcceptController() {
        acceptAgreement = false;
        //looks for the current agreement and the logged in user
        member = [SELECT Id, FieloAlpha__Program__c FROM FieloAlpha__Member__c WHERE Id =: MemberService.getCurrentMemberId()];        
        agreement = [SELECT Id, FieloAlpha__Agreement__c FROM FieloAlpha__Agreement__c WHERE FieloAlpha__Status__c = 'Current' AND FieloAlpha__Program__c =: member.FieloAlpha__Program__c LIMIT 1];
    }

    public PageReference doSave(){
        //if the member exists and have accepted the agreement then updates the agreement for the member
        if(acceptAgreement){
            member.FieloAlpha__Agreement__c = agreement.Id;
            FieloAlpha.OrganizationUtil.validateReadOnlyFieldsMember(false);
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