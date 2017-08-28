global class FieloCMSPLT_UserCreation implements FieloPLT.UserCreation {

    global User getUser(FieloPLT__Member__c m, Id contactId){                
        String email = m.FieloPLT__Email__c;      
        String communityNickname = m.Name + String.valueOf(contactId).substring(12,15);   
        String subAlias = (m.Name.length()>4) ? m.Name.substring(0,4) : m.Name;
        String alias = subalias;                       
        String language = orgSettings.LanguageLocaleKey;
        String locale = orgSettings.LanguageLocaleKey;
        String timeZone = UserInfo.getTimeZone().getId();
        User u = new User(
                Username = email, Email = email, LastName = m.Name, Alias = alias, emailencodingkey='UTF-8', 
                ProfileId = profileId, contactId = contactId, LocaleSidKey = locale, TimeZoneSidKey = timeZone, LanguageLocaleKey = language,
                CommunityNickname = communityNickname);
                            
        return u;
    }

    private static Organization orgSettings {get{if(orgSettings == null){orgSettings = [SELECT DefaultLocaleSidKey, LanguageLocaleKey FROM Organization];}return orgSettings;}}        
    
    private static Id profileId {get{
                                    if(profileId == null){                                                                                
                                        profileId = [SELECT Id FROM Profile WHERE Name = 'Fielo Member Site'].get(0).Id;                                                                                                                                                            
                                    }
                                    return profileId;
                                }}        

}