public without sharing class FieloCMSPLT_Programs {

    public static void formatSiteDomain(List<FieloPLT__Program__c> programs){
        for(FieloPLT__Program__c p : programs){
            if(p.FieloCMSPLT_SiteURL__c != null && p.FieloCMSPLT_SiteURL__c != ''){
                p.FieloCMSPLT_SiteDomain__c = p.FieloCMSPLT_SiteURL__c.replace('http://','').replace('https://','').replace('.secure.','.');
                if(p.FieloCMSPLT_SiteURL__c.lastIndexOf('/') != p.FieloCMSPLT_SiteURL__c.length()-1) p.FieloCMSPLT_SiteURL__c = p.FieloCMSPLT_SiteURL__c + '/';
                if(p.FieloCMSPLT_SiteDomain__c.lastIndexOf('/') == p.FieloCMSPLT_SiteDomain__c.length()-1)
                    p.FieloCMSPLT_SiteDomain__c = p.FieloCMSPLT_SiteDomain__c.subString(0,p.FieloCMSPLT_SiteDomain__c.lastIndexOf('/'));
            }
        }
    }
}