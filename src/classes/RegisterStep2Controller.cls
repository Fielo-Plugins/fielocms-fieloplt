global without sharing class RegisterStep2Controller {

    public Boolean showPassword {get; set;}
    public List<Field> fieldset {get; set;}    
    public Member__c member {get{
        if(member == null){     
            Id memberId = ApexPages.currentPage().getParameters().get('memberId');
            member = Database.query('SELECT ' + getFieldSet() + ' FROM FieloEE__Member__c WHERE Id =: memberId LIMIT 1');                
        }
        return member;
    } set;}

    private String getFieldset(){
        List<String> fields = new List<String>();
        for(Field field : fieldset){
            fields.add(field.apiName);
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
        status = MemberService.validateStatus(memberId);
    }
    
    @RemoteAction
    global static RemoteActionResult continueRegistration(Id memberId){
        RemoteActionResult result = new RemoteActionResult();
        try{
            Member__c member = new MembersSelector().selectById(new Set<Id>{memberId})[0];
            MemberService.finishRegistration(member);
            //MemberUtil.sendToApprove(new List<Member__c>{member});
            result.addMessage(new RemoteActionResult.RemoteActionMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, Label.SucessAwardingApprovalRegistration)));
        }catch(FieloCustomException e){
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
        }

        if(ApexPages.hasMessages()){
            result.redirectURL = '';
            for(ApexPages.Message m : ApexPages.getMessages()){
                result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
            }
        }

        return result;
    }

    @RemoteAction
    global static RemoteActionResult finishRegistration(SObject record, String password){    
        try{
            Member__c member = (Member__c)record;                
            MemberService.finishRegistration(member);
            if(showPassword){
                PageReference passResult = MemberService.setPasswordAndLogin(record.Id, (String)passwordJson.get('Password'));
                result.redirectURL = passResult.getUrl();
            }
        }catch(DmlException e){            
            Database.rollback(sp);
            if(ApexPages.hasMessages()){
                result.redirectURL = '';
                for(ApexPages.Message m : ApexPages.getMessages()){
                    result.addMessage(new RemoteActionResult.RemoteActionMessage(m));
                }
            }
            return result;
        }catch(Exception e){
            if(sp != null){
                Database.rollback(sp);
            }
            result.addMessage(new RemoteActionResult.RemoteActionMessage(e));
            return result;
        }                
    }  
}