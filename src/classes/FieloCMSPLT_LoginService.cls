public class FieloCMSPLT_LoginService {

    public static Pagereference login(String userName, String password, String startUrl){
        username = username.trim();
        try{
            //Checks if the user is inactive and activate it, after that redirects to the page to reactivate the user
            List<User> inactiveUsers = [SELECT Username, Name, IsActive, Id, Email From User where IsActive = false AND Username =: username limit 1];
            if(inactiveUsers.size() > 0){
                inactiveUsers.get(0).IsActive = true;
                update inactiveUsers;
            }
        }catch(exception e){
            throw new FieloCMSPLT_Exception(e.getMessage());
        }

        FieloPLT__Program__c program = FieloCMSPLT_ProgramService.getCurrentProgram();
        //look for the member related to the username
        List<FieloPLT__Member__c> membersByEmail = [SELECT FieloPLT__Status__c, FieloPLT__User__c, FieloPLT__Program__r.FieloCMSPLT_UseAgreement__c FROM FieloPLT__Member__c WHERE FieloPLT__Email__c =: username AND FieloPLT__Program__c =: program.Id];

        //if the member was not found throws an error
        if(membersByEmail.isEmpty()){
            throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorLoginProgramValidation);
        }

        //if the member was found but is blocked thtrows an error
        if(membersByEmail.get(0).FieloPLT__Status__c == 'Blocked'){
            throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorLoginMemberBlocked);
        }

        /*
        //check selection member page
        if(membersByEmail.get(0).FieloPLT__User__c != null){
            List<FieloPLT__Member__c> relatedMembers = new MembersSelector().selectRelatedMembers(UserInfo.getUserId(), program.Id);
            if(relatedMembers.size() > 1 && String.isNotBlank(program.FieloCMSPLT_MemberSelectionPage__c)){
                PageReference selectionPage = new PageReference('/FieloCMS__Page');
                selectionPage.getParameters().put('pageId',program.FieloCMSPLT_MemberSelectionPage__c);
                startUrl = selectionPage.getUrl();
            }
        }*/

        
        //login
        return Site.login(username, password, startUrl);
    }

    public static PageReference forgotPassword(String userName){
        //Validates if the userName is not empty
        if(String.isBlank(username)){
            throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_UsernameIsRequired);
            return null;
        }
        //looks if the user is inactive and then activates the user
        List<User> user = [SELECT Username, Name, IsActive, Id, Email FROM User WHERE Username =: username LIMIT 1];

        //if the user was found and is inactive then is activated and updated
        if(user.size() > 0){
            if(user.get(0).IsActive == false){
                user.get(0).IsActive = true;
                update user;
            }
        //if the user does not exist an error is returned
        }else{
            throw new FieloCMSPLT_Exception(Label.FieloCMSPLT_ErrorMemberForgotPasswordInexist);
        }

        Site.forgotPassword(username);

        return null;
    }
}