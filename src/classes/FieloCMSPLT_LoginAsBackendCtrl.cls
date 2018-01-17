public with sharing class FieloCMSPLT_LoginAsBackendCtrl {
    public PageReference redirect(){                
        //get member Id
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
            Id fieloAccountId;
            List<Account> aa  = [SELECT ID FROM Account WHERE Name ='Fielo'];            
            if ( aa.size() == 0 ) {
                // Account a = new Account( name ='Fielo');
                // insert a;
                // fieloAccountId = a.id;            
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Dont exist a Fielo Account'  ));            
                //return null;
            } else {
                fieloAccountId = aa.get(0).Id;            
            }

            Id profileId = [SELECT Id FROM Profile WHERE Name = 'Fielo Member Site'].get(0).Id;

            String withSameLastName = String.valueOf([SELECT Id FROM User WHERE LastName =: UserInfo.getLastName()].size());
            siteUser = new User(Username = 'site_' + UserInfo.getUsername(), FirstName = UserInfo.getFirstName(), LastName = UserInfo.getLastName(), Email = 'site_' + UserInfo.getUserEmail(), CommunityNickname = 'site_' + UserInfo.getLastName() + withSameLastName);
            
            String subAlias = (siteUser.LastName.length()>4) ? siteUser.LastName.substring(0,4) : siteUser.LastName;
            siteUser.Alias = (siteUser.FirstName != null) ? siteUser.FirstName.substring(0,1) + subalias : subalias;

            siteUser.emailencodingkey = 'UTF-8';
            siteUser.ProfileId = profileId;
            siteUser.LocaleSidKey = UserInfo.getLocale();
            siteUser.TimeZoneSidKey = UserInfo.getTimeZone().getID();
            siteUser.LanguageLocaleKey = UserInfo.getLanguage();
            
            //insert the contact
            Contact contact = new Contact(FirstName = siteUser.FirstName, LastName = siteUser.LastName, AccountId = fieloAccountId);
            insert contact;

            //set the relation to the contact and insert the user
            siteUser.ContactId = contact.Id;
            insert siteUser;            
        }               
                       
        //register log
/*        
        FieloCMSPLT_LoginAsLog__c log = new FieloCMSPLT_LoginAsLog__c(UserId__c = siteUser.Id);               
        Datetime dt = Datetime.now();
        log.Name = String.valueOf(dt.Year()) + String.valueOf(dt.month()) + String.valueOf(dt.day()) + String.valueOf(dt.hour()) + String.valueOf(dt.minute()) + String.valueOf(dt.second()) + UserInfo.getUserId();         
        log.FieloCMSPLT_MemberId__c = memberId;
        insert log;
*/

        //set the custom setting with memberid, hash and expiration date
        SessionCache__c fe = SessionCache__c.getInstance(siteUser.Id);
        fe.FieloCMSPLT_MemberId__c = memberId;
        fe.FieloCMSPLT_Hash__c = String.valueOf(Crypto.getRandomLong());//String.ValueOf((dt.millisecond() * dt.Year())/(dt.minute()+1));
        fe.FieloCMSPLT_ExpirationDate__c = System.now().addMinutes(5);
        upsert fe;            

        //redirects to the site
        PageReference retPage;

        if(member.FieloPLT__Program__r.FieloCMSPLT_SiteURL__c != null && member.FieloPLT__Program__r.FieloCMSPLT_SiteURL__c != ''){
            String siteURL = member.FieloPLT__Program__r.FieloCMSPLT_SiteURL__c;
            siteURL = siteURL.replace('http://', 'https://');
            if (siteURL.indexOf('https://') < 0){
                siteURL = 'https://' + siteURL;
            }
            retPage = new PageReference(siteURL + 'FieloCMSPLT_LoginAs');
            retPage.getParameters().put('testUser',siteUser.Id);        
            retPage.getParameters().put('hash',fe.FieloCMSPLT_Hash__c);
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Program SiteURL Empty'));
            return null;
        }

        return retPage;
        return null;

    }
}
