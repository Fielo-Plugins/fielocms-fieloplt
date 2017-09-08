public with sharing class FieloCMSPLT_LoginAsBackendCtrl {

    public PageReference redirect(){                
        /*//get member Id
        String memberId = system.currentPageReference().getParameters().get('memberId');
        //look for the site url of the program's member
        FieloPLT__Member__c member = [SELECT FieloPLT__Program__r.FieloCMSPLT_SiteURL__c, FieloPLT__Program__c, Name FROM FieloPLT__Member__c WHERE Id =: memberId];

        User siteUser;
        //look if exists the test user
        try{
            siteUser = [SELECT Id, UserName FROM User WHERE UserName =: ('site_' + UserInfo.getUserName())];            
        }catch(Exception e){}
        
        //if the user doesn't exist it creates it       
        if(siteUser == null){
            //Creacion  del usuario
            Id fieloAccountId = new AccountsSelector().selectFieloAccount().Id;

            if(fieloAccountId == null){
                UtilsPageMessage.writeInfo(String.format(Label.LoginAsNoFieloCRMAccount, new List<String>{'<a href=\'/001/e?acc2=Fielo\'>' + Label.CreateAFieloCRMAccount + '</a>'}));
                return null;
            }

            Profile fieloProfile = MemberUtil.getFieloProfile(member.FieloPLT__Program__c);
            FieloCMSPLT_Program__c program = new ProgramsSelector().selectById(new Set<Id>{member.FieloCMSPLT_Program__c})[0];
            
            String withSameLastName = String.valueOf([SELECT Id FROM User WHERE LastName =: UserInfo.getLastName()].size());
            siteUser = new User(Username = 'site_' + UserInfo.getUsername(), FirstName = UserInfo.getFirstName(), LastName = UserInfo.getLastName(), Email = 'site_' + UserInfo.getUserEmail(), CommunityNickname = 'site_' + UserInfo.getLastName() + withSameLastName);
        	
        	String subAlias = (siteUser.LastName.length()>4) ? siteUser.LastName.substring(0,4) : siteUser.LastName;
        	siteUser.Alias = (siteUser.FirstName != null) ? siteUser.FirstName.substring(0,1) + subalias : subalias;

        	siteUser.emailencodingkey = 'UTF-8';
        	siteUser.ProfileId = fieloProfile.Id;
            siteUser.LocaleSidKey = program.Locale__c != null && program.Locale__c != '' ? program.Locale__c : UserInfo.getLocale();
            siteUser.TimeZoneSidKey = program.TimeZone__c != null && program.TimeZone__c != '' ? program.TimeZone__c : UserInfo.getTimeZone().getID();
            siteUser.LanguageLocaleKey = program.Language__c;
            
            //insert the contact
        	Contact contact = new Contact(FirstName = siteUser.FirstName, LastName = siteUser.LastName, AccountId = fieloAccountId);
        	insert contact;

        	//set the relation to the contact and insert the user
        	siteUser.ContactId = contact.Id;
        	insert siteUser;            
        }               
                       
        //register log
        LoginAsLog__c log = new LoginAsLog__c(UserId__c = siteUser.Id);               
        Datetime dt = Datetime.now();
        log.Name = String.valueOf(dt.Year()) + String.valueOf(dt.month()) + String.valueOf(dt.day()) + String.valueOf(dt.hour()) + String.valueOf(dt.minute()) + String.valueOf(dt.second()) + UserInfo.getUserId();         
        log.FieloCMSPLT_MemberId__c = memberId;
        insert log;

        //set the custom setting with memberid, hash and expiration date
        FrontEndSessionData__c fe = FrontEndSessionData__c.getInstance(siteUser.Id);
        fe.FieloCMSPLT_MemberId__c = memberId;
        fe.Hash__c = String.valueOf(Crypto.getRandomLong());//String.ValueOf((dt.millisecond() * dt.Year())/(dt.minute()+1));
        fe.ExpirationDate__c = System.now().addMinutes(5);
        upsert fe;            

        //redirects to the site
        PageReference retPage;

        if(member.Program__r.FieloCMSPLT_SiteURL__c != null && member.Program__r.FieloCMSPLT_SiteURL__c != ''){
            String siteURL = member.Program__r.FieloCMSPLT_SiteURL__c;
            siteURL = siteURL.replace('http://', 'https://');
            if (siteURL.indexOf('https://') < 0){
                siteURL = 'https://' + siteURL;
            }
            retPage = new PageReference(siteURL + OrganizationUtil.getPrefixUnderScore() + 'LoginAs');
            retPage.getParameters().put('testUser',siteUser.Id);        
            retPage.getParameters().put('hash',fe.Hash__c);
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, Label.ErrorProgramSiteURLEmpty));
            return null;
        }

        return retPage;*/
        return null;

    }
}