public without sharing class Programs {

    public static void formatSiteDomain(List<FieloPLT__Program__c> programs){
        for(FieloPLT__Program__c p : programs){
            if(p.SiteURL__c != null && p.SiteURL__c != ''){
                p.SiteDomain__c = p.SiteURL__c.replace('http://','').replace('https://','').replace('.secure.','.');
                if(p.SiteURL__c.lastIndexOf('/') != p.SiteURL__c.length()-1) p.SiteURL__c = p.SiteURL__c + '/';
                if(p.SiteDomain__c.lastIndexOf('/') == p.SiteDomain__c.length()-1)
                    p.SiteDomain__c = p.SiteDomain__c.subString(0,p.SiteDomain__c.lastIndexOf('/'));
            }
        }
    }
}