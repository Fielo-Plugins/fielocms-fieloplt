@isTest
public class FieloCMSPLT_MockupFactory{

    public static Id createComponentLibrary(){
        FieloCMS__Plugin__c plugin1 = new FieloCMS__Plugin__c( Name = 'Default', FieloCMS__Resource__c = 'www.url.com/static1', FieloCMS__ResourceContent__c = 'CSS' );
        insert new List<FieloCMS__Plugin__c> { plugin1};

        FieloCMS__ComponentLibrary__c componentLibrary1 = new FieloCMS__ComponentLibrary__c( Name = 'Default', FieloCMS__Plugin__c = plugin1.Id );
        insert new List<FieloCMS__ComponentLibrary__c> { componentLibrary1 };
        
        return componentLibrary1.Id;
    }

    public static Id createMenuSection(){
        //Crea una Pagina con un componente del plugin 1
        FieloCMS__Site__c site = new FieloCMS__Site__c(Name = 'Default');
        insert site;
        
        FieloCMS__Page__c page =  new FieloCMS__Page__c( Name = 'Default', FieloCMS__Site__c = site.Id);
        insert page;

        FieloCMS__Section__c section = new FieloCMS__Section__c(  FieloCMS__Page__c = page.Id);
        insert section;

        FieloCMS__Section__c subsection = new FieloCMS__Section__c( FieloCMS__Parent__c = section.Id);
        insert subsection;
        
        return subsection.Id;
    }

    public static Id createProgram(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;
        return program.Id;
    }

    public static Id createMember(String name, String email, Id programId, Id userId){
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = name, FieloPLT__Email__c = email, FieloPLT__Program__c = programId, FieloPLT__User__c = userId);
        insert member;
        FieloCMSPLT_MemberService.setCurrentMemberId(member.Id);
        return member.Id;
    }

    public static void setProgramAndMember(){
        FieloPLT__Program__c program = new FieloPLT__Program__c(Name = 'test');
        insert program;
        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = program.Id, FieloPLT__User__c = UserInfo.getUserId());
        insert member;
    }


    public static List<FieloPLT__Reward__c> createRewards(String basename, Integer count, Id programId, Integer points){
        List<FieloPLT__Reward__c> results = new List<FieloPLT__Reward__c>();
        for(Integer x = 0; x < count; x++){
            FieloPLT__Reward__c r = new FieloPLT__Reward__c();
            r.Name = basename + String.valueOf(x);
            r.FieloPLT__Program__c = programId;
            r.FieloPLT__Points__c = points;
            r.FieloPLT__Stock__c = count;
            results.add(r);
        }
        return results;
    }

    public static void createPoints(FieloPLT__Member__c member, Integer pointsValue){
        FieloPLT.SObjectService.enableAdminPermission(true);
        FieloPLT__Transaction__c adjustTransaction = new FieloPLT__Transaction__c(FieloPLT__Type__c = 'Adjust', FieloPLT__SkipEngine__c = true, FieloPLT__Value__c = pointsValue, FieloPLT__Member__c = member.id);
        insert adjustTransaction;        
        FieloPLT.SObjectService.enableAdminPermission(false);
    }
}