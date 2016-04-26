public class LoginService {
	
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
            throw new FieloCustomException(e.getMessage());            
        }
        
        //look for the member related to the username
        List<Member__c> member = [SELECT Site__c, Blocked__c FROM Member__c WHERE Email__c =: username AND Site__c =: SiteUtil.getProgramByDomain().Id];
        
        //if the member was not found throws an error
        if(member.isEmpty()){
            throw new FieloCustomException(Label.ErrorLoginProgramValidation);            
        }
        
        //if the member was found but is blocked thtrows an error
        if(member.get(0).Blocked__C){
            throw new FieloCustomException(Label.ErrorLoginMemberBlocked);                        
        }

        //login
        return Site.login(username, password, startUrl);
    }

    public static PageReference forgotPassword(String userName){        
        //Validates if the userName is not empty
        if(UtilsString.isEmpty(username)){
            throw new FieloCustomException(Label.UsernameIsRequired);
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
            throw new FieloCustomException(Label.ErrorMemberForgotPasswordInexist);            
        }
        
        Site.forgotPassword(username);

        return null;
    }
}