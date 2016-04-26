global without sharing class RegisterStep2Controller {

    public SObject member {get; set;}

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
        
        Member__c m = (Member__c)member;
        Id memberId = m != null ? m.Id : null;        
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

}