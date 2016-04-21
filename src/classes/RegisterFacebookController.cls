public with sharing class RegisterFacebookController {
	public Site__c program {get{if(program == null) program = SiteUtil.getSiteProgram(new List<String>{'FacebookAplicationId__c','RequestAutorization__c'}); return program;} set;}
}