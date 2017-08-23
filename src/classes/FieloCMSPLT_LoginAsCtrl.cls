public with sharing class FieloCMSPLT_LoginAsCtrl {

	public PageReference login(){
		/*//get user id and hash from browser
		String userId = system.currentPageReference().getParameters().get('testUser');
		String hash = system.currentPageReference().getParameters().get('hash');

		//get the user custom setting and validates hash and expiration date
		SessionCache__c fe = SessionCache__c.getInstance(userId);
		if(fe.Hash__c != null && fe.Hash__c != '' && hash == fe.Hash__c && fe.ExpirationDate__c >= System.now()){
			//set the temporary password
	    	String pass = system.resetPassword(userId, false).getPassword() + system.now().millisecond();
	      	system.setPassword(userId, pass);

	      	//login
	      	return Site.login([SELECT UserName FROM User WHERE Id =: userId].UserName, pass, null);	      	
		}else{
			//shows error message in the page
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,Label.LoginAsError));
		}*/

		return null;
	}
}