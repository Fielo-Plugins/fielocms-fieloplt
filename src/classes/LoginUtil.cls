/**
 * @brief      API para el modulo de Login
 * @details    La API contiene metodos estaticos para realizar acciones como login y forgotpassword, principalmente para ser utilizadas en el site
 */
global class LoginUtil {
	
    /**
     * @brief       Metodo para realizar el login
     * @details     Dado un UserName, password y una url de inicio el sistema realiza todas las validaciones necesarias y luego de eso realiza el login del usuario.
     * @version     10.0     
     * @param       userName        username del usuario
     * @param       password        password del usuario
     * @param       startUrl        url de inicio despues de hacer el login
     * @returns     Url de login
     * @retval      PageReference   
     *                      <ul>
     *                         <li> PageReference = Operacion exitosa, devuelve url de login
     *                         <li> null = Caso que haya habido algun error durante el logueo
     *                      </ul>
     * @warning     En caso de que el user este inactivo, el metodo lo activa primero y luego intenta loguearlo
     * @warning     El metodo verifica que exista un member que tenga como mail el username ingresado y corresponda al programa del sitio, tambien verifica que el mismo no este bloqueado
     * @exception   FieloCustomException    Si el usuario esta inactivo y falla la actualizacion al activarlo.
     *                                      Si el member no fue encontrado en ese programa o si el member esta bloqueado
     * @test
     * @code     
     *          try{
     *              FieloEE.LoginUtil.login('test@test.com','123456','/CustomPage');
     *          }catch(FieloCustomException e){
     *              ApexPages.addMessage(new ApexPages.Message(severity.ERROR, e.getMessage()));
     *          }
     * @endcode
     */ 
	global static Pagereference login(String userName, String password, String startUrl){
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

    /**
     * @brief       Metodo para resetear la password para un member
     * @details     Dado un UserName el sistema realiza validaciones y luego resetea la password del usuario
     * @param       userName        username del usuario
     * @returns     PageReference   Devuelve valor null     
     * @warning     En caso de que el user este inactivo, el metodo lo activa primero y luego intenta resetear la password
     * @warning     El sistema envia un mail al usuario con la password temporal
     * @return      PageReference       Valor null
     * @exception   FieloCustomException    Si el usuario esta inactivo y falla la actualizacion al activarlo.
     * @code{.java}
     *          try{
     *              FieloEE.LoginUtil.forgotPassword('test@test.com');
     *          }catch(FieloCustomException e){
     *              ApexPages.addMessage(new ApexPages.Message(severity.ERROR, e.getMessage()));
     *          }
     * @endcode
     */  
    global static PageReference forgotPassword(String userName){        
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