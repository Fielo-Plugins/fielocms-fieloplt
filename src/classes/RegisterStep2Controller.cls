global without sharing class RegisterStep2Controller {
        
    public FieloAlpha__Member__c member {get{
        if(member == null){     
            Id memberId = ApexPages.currentPage().getParameters().get('memberId');
            try{
                member = Database.query('SELECT ' + getFieldSet() + ' FROM FieloAlpha__Member__c WHERE Id =: memberId LIMIT 1');
            }catch(Exception e){}
        }
        return member;
    } set;}

    private String getFieldset(){
        List<String> fields = new List<String>{'Id'};
        for(Schema.FieldSetMember fsm : Schema.SObjectType.FieloAlpha__Member__c.fieldSets.FieloAlpha__RegistrationStep2.getFields()){
            fields.add(fsm.getFieldPath());
        }    
        return String.join(fields,',');
    }

    public Boolean showForm {get{if(!initLoaded) init(); return showForm;} private set;}
    public Boolean memberAlreadyRegistered {get{if(!initLoaded) init(); return memberAlreadyRegistered;} private set;}
    public Boolean memberInApproval {get{if(!initLoaded) init(); return memberInApproval;} private set;}
    public Boolean showContinue {get{if(!initLoaded) init(); return showContinue;} private set;}

    public String status {get{if(!initLoaded) init(); return status;} private set;}

    private Boolean initLoaded;
    public RegisterStep2Controller(){
        initLoaded = false;
    }

    private void init(){
        initLoaded = true;        
        Id memberId = member != null ? member.Id : null;        
        status = FieloAlpha.MemberService.validateStatus(memberId);
    }
    
    @RemoteAction
    global static FieloCMS.RemoteActionResult continueRegistration(Id memberId){
        SavePoint sp = Database.setSavepoint();
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try{
            FieloAlpha__Member__c member = new MembersSelector().selectById(new Set<Id>{memberId})[0];
            FieloAlpha.MemberService.finishRegistration(member);
            //MemberUtil.sendToApprove(new List<Member__c>{member});
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SucessAwardingApprovalRegistration)));
        }catch(FieloCustomException e){
            Database.rollback(sp);
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }catch(FieloAlpha.FieloCustomException e){
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }

    @RemoteAction
    global static FieloCMS.RemoteActionResult finishRegistration(SObject record, String password){    
        SavePoint sp = Database.setSavepoint();
        FieloCMS.RemoteActionResult result = new FieloCMS.RemoteActionResult();
        try{
            FieloAlpha__Member__c member = (FieloAlpha__Member__c)record;                
            FieloAlpha.MemberService.finishRegistration(member);
            if(!String.isBlank(password)){
                PageReference passResult = MemberService.setPasswordAndLogin(record.Id, password);
                result.redirectURL = passResult.getUrl();
            }else{
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.RegistrationSuccessExistingUser)));
            }
        }catch(DmlException e){            
            Database.rollback(sp);
            if(ApexPages.hasMessages()){
                result.redirectURL = '';
                for(ApexPages.Message m : ApexPages.getMessages()){
                    result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(m));
                }
            }else{
                result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
            }
        }catch(Exception e){            
            Database.rollback(sp);            
            result.addMessage(new FieloCMS.RemoteActionResult.RemoteActionMessage(e));
        }
        return result;                
    }  
}