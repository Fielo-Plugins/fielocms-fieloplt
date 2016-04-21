//NO DOCUMENT
/**
* @author Alejandro Spinelli
* @date   22/06/2012
* @description Class of test to create components of fielo
*/
@isTest
global without sharing class MockUpFactory {

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a reward
    * @return Reward__c
    */
    global static Reward__c createPrize(String name, Integer points, Decimal prizeValue){
        Reward__c reward = new Reward__c(Name = name, PointsCant__c = points, Price__c = prizeValue, VoucherCreationMode__c = 'Controlled By Quantity');
        insert reward;
        Attachment a = new Attachment(name = 'test', Body = Blob.valueOf('test'), parentId = reward.Id);
        insert a;
        return reward;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a reward, with an amount of stock, and setting the creationMode
    * @return Reward__c
    */
    public static Reward__c createReward(String name, Integer points, Integer stock, String creationMode, Boolean uniqueVoucher, Id programId){
        Reward__c reward = new Reward__c(Name = name, PointsCant__c = points, Site__c = programId);
        reward.VoucherCreationMode__c = creationMode;
        if(creationMode == 'Controlled By Quantity'){
            reward.Stock__c = stock;
            reward.UniqueVoucher__c = uniqueVoucher;
            insert reward;
        }else if(creationMode == 'Controlled By Item'){
            reward.UniqueVoucher__c = uniqueVoucher;
            insert reward;
            createPreloadItems(reward, stock);
            //create reward items
        }else{//creation mode = 'unlimited'
            reward.UniqueVoucher__c = uniqueVoucher;
            insert reward;
        }

        Attachment a = new Attachment(name = 'test', Body = Blob.valueOf('test'), parentId = reward.Id);
        insert a;
        reward = [SELECT Name, PointsCant__c, CondenserId__c, VoucherCreationMode__c, UniqueVoucher__c FROM Reward__c WHERE Id =: reward.Id];

        return reward;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a member
    * @param String name
    * @param String identificationCode
    * @return Member__c
    */
    global static Member__c createMember(String name, String identificationCode, String identificationType){
        Member__c member = new Member__c(IdentificationType__c = identificationType, IdentificationCode__c = identificationCode, LastName__c = name, FirstName__c = name);
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert member;
        return [SELECT IdentificationType__c, IdentificationCode__c, LastName__c, FirstName__c, User__c, Points__c FROM Member__c WHERE Id =: member.Id];
    }

    /**
    * @author Agustín Gallardo
    * @date   05/06/2013
    * @description creates a member
    * @param String firstName
    * @param String lastName
    * @param String identificationCode
    * @param Date birthdate
    * @param String memberCode
    * @return Member__c
    */
    public static Member__c createMember(String firstName, String lastName, String identificationCode, String identificationType, Date birthdate){
        Member__c member = new Member__c(IdentificationType__c = identificationType, IdentificationCode__c = identificationCode, LastName__c = lastName, FirstName__c = firstName, Birthdate__c = birthDate);
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert member;
        return [SELECT IdentificationType__c, IdentificationCode__c, LastName__c, FirstName__c, User__c, Points__c FROM Member__c WHERE Id =: member.Id];
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a member
    * @param String name
    * @param String identificationCode
    * @param Id programId
    * @return Member__c
    */
    public static Member__c createMember(String name, String identificationCode, String identificationType, Id programId){
        Member__c member = new Member__c(IdentificationType__c = identificationType, IdentificationCode__c = identificationCode, LastName__c = name, FirstName__c = name, Site__c = programId);
        //allow to edit the read only fields
        MemberTrigger.validateReadOnlyFields = false;
        insert member;
        return [SELECT IdentificationType__c, IdentificationCode__c, LastName__c, FirstName__c, User__c, Points__c, Site__c FROM Member__c WHERE Id =: member.Id];
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a reward item related to a specific reward
    * @param Reward__c reward
    * @return RewardItem__c
    */
    global static RewardItem__c createItem(Reward__c reward){
        RewardItem__c item = new RewardItem__c(Reward__c = reward.id);
        insert item;
        return item;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a reward item to a general reward
    * @return RewardItem__c
    */
    global static RewardItem__c createItem(){
        return createItem(createPrize('prizeMock',1,1));
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates reward items for a preloaded reward
    * @param Reward__c reward
    * @param Integer quantity
    * @return List<RewardItem__c>
    */
    private static Integer lastRewardItemCode = 1;
    private static void createPreloadItems(Reward__c r, Integer stock){
        List<RewardItem__c> newItems = new List<RewardItem__c>();
        for(Integer i = 0; i < stock; i++){
            newItems.add(new RewardItem__c(Code__c = String.valueOf(lastRewardItemCode), Reward__c = r.Id, Status__c = 'Available'));
            lastRewardItemCode++;
        }

        insert newItems;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a list of reward items
    * @param Reward__c reward
    * @param Integer quantity
    * @return List<RewardItem__c>
    */
    global static List<RewardItem__c> createItems(Reward__c reward,Integer quantity){
        List<RewardItem__c> listItems = new List<RewardItem__c>();
        for(Integer i = 0 ; i < quantity ; i++){
            listItems.add(new RewardItem__c(Reward__c = reward.id));
        }
        insert listItems;
        return listItems;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a redemption related to a specific member
    * @param Member__c member
    * @return Redemption__c
    */
    global static Redemption__c createOrder(Member__c member){
        Redemption__c redemption = new Redemption__c(Member__c = member.id, Member__r = member, Status__c = 'Open');
        insert redemption;
        return redemption;
    }

    /**
    * @author Agustín Gallardo
    * @date   24/05/2013
    * @description creates a redemption related to a specific member and reward.
    * @param Member__c member, Reward__c reward
    * @return Redemption__c
    */
     global static Redemption__c createRedemption(Member__c member, Reward__c reward){
        Redemption__c redemption = new Redemption__c(Member__c = member.id, Member__r = member, Status__c = 'Open');
        insert redemption;
        RedemptionUtil.addRedemptionItem(redemption, reward, 1);
        return redemption;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a redemption item
    * @param RewardItem__c rewardItem
    * @param Redemption__c redemption
    * @return RedemptionItem__c
    */
    global static RedemptionItem__c createOrderItem(RewardItem__c rewardItem, Redemption__c redemption){
        createRedemptionRule();
        RedemptionItem__c item = new RedemptionItem__c(RewardItem__c = rewardItem.id, Redemption__c = redemption.Id);
        insert item;
        return item;
    }

    /**
    * @author Leonardo Teren
    * @date   10/07/2013
    * @description creates a redemption item
    * @param Reward__c reward
    * @param Redemption__c redemption
    * @return RedemptionItem__c
    */
    public static RedemptionItem__c createRedemptionItem(Reward__c reward, Redemption__c redemption){
        RedemptionItem__c item = new RedemptionItem__c(Reward__c = reward.Id, Redemption__c = redemption.Id);
        insert item;
        return item;
    }


    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a portal user
    * @param String lastName
    * @param Id userId
    * @return User
    */
    global static Account createFieloAccount(Id ownerId){
        //creates an account with a specific owner
        Account a = new Account(name = 'Fielo', OwnerId = ownerId, Number_of_Contacts__c = 0);
        insert a;
        return a;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a portal user
    * @param String lastName
    * @param Id contactId
    * @return User
    */
    global static User createPortalUser(Id accountId, String lastName){
        //looks for the customer portal profile
        List<Profile> profiles = [SELECT id FROM profile WHERE Name =: SiteUtil.getDefaultProgram().SiteProfile__c LIMIT 1];

        if(!profiles.isEmpty()){
            Contact c = new Contact(Lastname = lastName, AccountId = accountId, Email = 'test@test.com');
            insert c;

            //creates the portal user
            User u = new User(Username = 'prueba@prueba.com',LastName = 'prueba1',
                            CommunityNickname = 'prueba', alias='pru1', FirstName = 'test',
                            Email = 'prueba@prueba.com', emailencodingkey = 'UTF-8',
                            localesidkey = 'en_US', languagelocalekey = 'en_US',
                            timezonesidkey = 'America/Los_Angeles', profileId=profiles.get(0).id, ContactId=c.Id);
            insert u;
            return u;
        }

        return null;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a standard user
    * @param String username
    * @param UserRole userRole
    * @return User
    */
    global static User createUser(String username, UserRole userRole){
        //looks for the standard profile
        List<Profile> profiles = [SELECT id FROM profile WHERE Name = 'Standard User' OR Name = 'Usuário Padrão' limit 1];

        if(!profiles.isEmpty()){
            String shortUserName = username.substring(0,username.indexOf('@'));
            String alias =(shortUserName.length()>8)?shortUserName.substring(0,5):shortUserName;
            User u = new User(Username = username,LastName = shortUserName, FirstName = 'test',
                            CommunityNickname = username, alias=alias,
                            Email = username, emailencodingkey = 'UTF-8',
                            localesidkey = 'en_US', languagelocalekey = 'en_US',
                            timezonesidkey = 'America/Los_Angeles', profileId=profiles.get(0).id,userRoleId = userRole.Id);
            insert u;
            return u;
        }

        return null;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates an administrator user
    * @return User
    */
    public static User createAdminUser(){
        Profile adminProfile = [SELECT Id FROM Profile WHERE UserType = 'Standard' AND PermissionsCustomizeApplication = true ORDER BY CreatedDate ASC limit 1];

        //creates the administrator user
        User adminUser = new User( email='system@aministrator.com', profileid = adminProfile.Id,
                UserName='system@aministrator.com', alias='admin_t', CommunityNickName='admin_Test',
                TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',
                LanguageLocaleKey='en_US', FirstName = 'System', LastName = 'Administrator');
        insert adminUser;

        return adminUser;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates an administrator user with admin role
    * @return User
    */
    global static User createRoleUser(){
        //looks for the administrator profile
        Profile adminProfile = [SELECT Id FROM Profile WHERE UserType = 'Standard' AND PermissionsCustomizeApplication = true ORDER BY CreatedDate ASC limit 1];

        //creates a generic role
        UserRole adminRole = new UserRole(Name = 'Admin');
        insert adminRole;

        //creates the administrator user
        User adminUser = new User( email='system@aministrator.com', profileid = adminProfile.Id,
                UserName='system@aministrator.com', alias='admin_t', CommunityNickName='admin_Test',
                TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',
                LanguageLocaleKey='en_US', FirstName = 'System', LastName = 'Administrator', userRoleId = adminRole.Id);
        insert adminUser;

        //returns the user
        return adminUser;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description increases the points of a member
    * @param Member__c member
    * @param Integer pointsValue
    * @return void
    */
    global static void createPoints(Member__c member, Integer pointsValue){
        TransactionTrigger.validateReadOnlyFields = false;
        Transaction__c adjustTransaction = new Transaction__c(Type__c = 'Adjust', SkipEngine__c = true, Value__c = pointsValue, Member__c = member.id);
        insert adjustTransaction;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a rule with a generic name
    * @return Rule__c
    */
    global static Rule__c createRule(){
        return createRule('test');
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a rule with a specific name
    * @param String ruleName
    * @return Rule__c
    */
    global static Rule__c createRule(String ruleName){
        Rule__c rule = new Rule__c(name = ruleName);
        insert rule;
        return rule;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a rule criteria
    * @param Rule__c rule
    * @return RuleCriteria__c
    */
    global static RuleCriteria__c createCriteria(Rule__c rule){
        RuleCriteria__c criteria = new RuleCriteria__c(FieldName__c='Name',Rule__c=rule.Id);
        insert criteria;
        return criteria;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates an action rule related to a specific rule
    * @param Rule__c rule
    * @return RuleAction__c
    */
    global static RuleAction__c createAction(Rule__c rule){
        RuleAction__c action = new RuleAction__c(Rule__c=rule.Id);
        insert action;
        return action;
    }

    /**
    * @author Alejandro Spinelli
    * @date   22/06/2012
    * @description creates a promotion
    * @return Promotion__c
    */
    global static Promotion__c createPromotion(){
        Promotion__c promotion = new Promotion__c();
        insert promotion;
        return promotion;
    }

    /**
    * @author Alejandro Spinelli
    * @date   12/07/2012
    * @description updates the settings with custom configuration
    * @return Void
    */
    global static void setCustomProperties(Boolean authorization){
        PublicSettings__c p = PublicSettings__c.getOrgDefaults();
        if(OrganizationUtil.hasPrefix('FieloEE')){
            p.PackagePrefix__c = 'FieloEE';
        }else if(OrganizationUtil.hasPrefix('FieloDEV')){
            p.PackagePrefix__c = 'FieloDEV';
        }
        upsert p;

        SiteUtil.createDefaultProgram();
        Site__c settings = SiteUtil.getDefaultProgram();
        settings.RequestAutorization__c = authorization;
        settings.ReferalTransactionStep1__c = false;
        settings.ReferalTransactionStep2__c = false;
        settings.RegistrationTransaction__c = false;
        settings.SiteURL__c = 'http://www.google.com';

        upsert settings;
    }


    /**
    * @author Diego Amarante
    * @date   03/10/2010
    * @description deactivate users to test method
    * @return Void
    */
    global static void deactivateUsers(){
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Fielo Member Site' limit 1];
        List<User> users = [SELECT Id, isActive FROM User WHERE profileId =: profile.Id];
        for(User u : users){
            u.IsActive = false;
        }
        update users;
    }

    /**
    * @author Diego Amarante
    * @date   03/10/2010
    * @description Creates a mockup Segment
    * @return Void
    */
    global static void createRedemptionRule(){
        RedemptionRule__c rRule = new RedemptionRule__c(isActive__c = true , Name = 'test');
        insert rRule;
        RedemptionRuleCriteria__c rCriteria = new RedemptionRuleCriteria__c(RedemptionRule__c = rRule.id,  Name = 'test', FieldName__c  = 'Name__c' , FieldType__c = 'Text', Operator__c = 'equals' , Values__c = 'a');
        insert rCriteria;
    }

    /**
    * @author Diego Amarante
    * @date   03/10/2010
    * @description Creates a mockup Segment Criteria
    * @return Void
    */
    public static void createRedemptionRulePointsCriteria(){
        RedemptionRule__c redemptionRule = new RedemptionRule__c(Name = 'testRedemptionRule', isActive__c = true);
        insert redemptionRule;
        RedemptionRuleCriteria__c criterias = new RedemptionRuleCriteria__c(RedemptionRule__c = redemptionRule.Id, Operator__c = 'greater than', NumberValue__c = 1, FieldType__c = 'Number', FieldName__c = 'Points__c');
        insert criterias;
    }

    /**
    * @author Diego Amarante
    * @date   03/10/2010
    * @description Creates a mockup default Promotion
    * @return Void
    */
    public static void createDefaultPromotion(Id programId){
        //create default promotion
        RecordType defaultPromRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Default_Promotion'];
        Promotion__c promotion = new Promotion__c(Name = 'Test Promotion', InitialDate__c = Date.today(), FinalDate__c = Date.today().addDays(7), RecordTypeId = defaultPromRecordType.Id, Site__c = programId);
        insert promotion;

        //create default Rule
        RecordType defaultRuleRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Default_Rule'];
        Rule__c defaultRule = new Rule__c(Name = 'Default Rule', ConvertionTypeTransaction__c = 'Fix Value', ConvertionValue__c = 10, Site__c = programId, Type__c = 'No Competition', RecordTypeId = defaultRuleRecordType.Id);
        insert defaultRule;
    }

    /**
    * @author Diego Amarante
    * @date   03/10/2010
    * @description Creates a mockup promotion, a mockup criteria and a mockup promotionRule
    * @return Void
    */
    public static void setupFieloConfigData(Date promotionDateBegin,Date promotionDateEnd){
        //Create Promotion
        Promotion__c promotion = new Promotion__c(name='Test Promotion',InitialDate__c=promotionDateBegin,FinalDate__c=promotionDateEnd);
        insert promotion;

        Rule__c rule1 = MockUpFactory.createRule('Test Rule 1');
        Rule__c rule2 = MockUpFactory.createRule('Test Rule 2');
        Rule__c rule3 = MockUpFactory.createRule('Test Rule 3');
        Rule__c rule4 = MockUpFactory.createRule('Test Rule 4');
        Rule__c rule5 = MockUpFactory.createRule('Test Rule 5');
        Rule__c rule6 = MockUpFactory.createRule('Test Rule 6');

        //Create Criteria
        List<RuleCriteria__c> criterias = new List<RuleCriteria__c>();
        criterias.add(new RuleCriteria__c(FieldName__c = 'Value__c'    , FieldType__c = 'Number'   , Operator__c = 'greater than', Rule__c = rule1.Id, NumberValue__c = 1           ));
        criterias.add(new RuleCriteria__c(FieldName__c = 'Value__c'    , FieldType__c = 'Number'   , Operator__c = 'equals'      , Rule__c = rule1.Id, NumberValue__c = 11          ));
        criterias.add(new RuleCriteria__c(FieldName__c = 'Member__c'  , FieldType__c = 'Text'     , Operator__c = 'equals'  , Rule__c = rule2.Id, Values__c = 'a'              ));
        criterias.add(new RuleCriteria__c(FieldName__c = 'CreatedDate' , FieldType__c = 'Date'     , Operator__c = 'greater than', Rule__c = rule3.Id, DateValue__c = System.today()));
        criterias.add(new RuleCriteria__c(FieldName__c = 'CreatedDate' , FieldType__c = 'Date'     , Operator__c = 'equals'      , Rule__c = rule3.Id, DateValue__c = System.today()));
        criterias.add(new RuleCriteria__c(FieldName__c = 'Processed__c', FieldType__c = 'Boolean'  , Operator__c = 'equals'      , Rule__c = rule4.Id, BooleanValue__c = false      ));
        criterias.add(new RuleCriteria__c(FieldName__c = 'Processed__c', FieldType__c = 'Boolean'  , Operator__c = 'equals'      , Rule__c = rule5.Id, BooleanValue__c = true       ));
        criterias.add(new RuleCriteria__c(FieldName__c = 'Value__c'    , FieldType__c = 'Number'   , Operator__c = 'equals'      , Rule__c = rule6.Id, Values__c = 'a'              ));
        insert criterias;

        //Create PromotionRule
        List<PromotionRule__c> promotionsRules = new List<PromotionRule__c>();
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule1.Id));
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule2.Id));
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule3.Id));
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule4.Id));
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule5.Id));
        promotionsRules.add(new PromotionRule__c(Promotion__c=promotion.Id,Rule__c = rule6.Id));
        insert promotionsRules;
    }


    public static void setupComponentLibrary(){
        List<ComponentsEnabled__c> clm = new List<ComponentsEnabled__c>();
        clm.add(new ComponentsEnabled__c(Name='Banner', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-banner', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Banner', RecordType__c='Banner', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Banner__c'));
        clm.add(new ComponentsEnabled__c(Name='Badges', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-currency', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Badges', RecordType__c='List', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Badge__c'));
        clm.add(new ComponentsEnabled__c(Name='Branches', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-currency', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Branches', RecordType__c='List', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Branch__c'));
        clm.add(new ComponentsEnabled__c(Name='Catalog', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-store', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Catalog', RecordType__c='Widget', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Reward__c'));
        clm.add(new ComponentsEnabled__c(Name='FilterByCategories', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-categories', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Filter by Categories', RecordType__c='Filter', RelatedListName__c='Categories__r', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Category__c'));
        clm.add(new ComponentsEnabled__c(Name='FilterByTags', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-tag', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Filter by Tags', RecordType__c='Filter', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Tag__c'));
        clm.add(new ComponentsEnabled__c(Name='ContentFeed', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-news', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Content Feed', RecordType__c='News', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'News__c'));
        clm.add(new ComponentsEnabled__c(Name='ContentFeedDetail', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-currency', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Content Feed Detail', RecordType__c='Detail', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'News__c'));
        clm.add(new ComponentsEnabled__c(Name='Content', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-content', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Content', RecordType__c='Content', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Component__c'));
        clm.add(new ComponentsEnabled__c(Name='GetPoints', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-award', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Get Points', RecordType__c='GetPoints', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Transaction__c'));
        clm.add(new ComponentsEnabled__c(Name='IncludePage', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-www', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Include Page', RecordType__c='IncludePage', RenderReflectionClass__c = 'ViewReflectionDefault'  , sObject__c = ''));
        clm.add(new ComponentsEnabled__c(Name='Login', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-login', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Login', RecordType__c='Login', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = ''));
        clm.add(new ComponentsEnabled__c(Name='Register', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-register', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Register', RecordType__c='Form', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Member__c'));
        clm.add(new ComponentsEnabled__c(Name='Account', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-profile', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Account', RecordType__c='DetailForm', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Member__c'));
        clm.add(new ComponentsEnabled__c(Name='Transactions', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-transactions', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Transactions', RecordType__c='List', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Transaction__c'));
        clm.add(new ComponentsEnabled__c(Name='RewardDetail', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-link', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Reward Detail', RecordType__c='Detail', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Reward__c'));
        clm.add(new ComponentsEnabled__c(Name='RedemptionDetail', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-shoppingCart', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Redemption Detail', RecordType__c='Detail', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Redemption__c'));
        clm.add(new ComponentsEnabled__c(Name='MemberDetail', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-currency', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Member Detail', RecordType__c='Detail', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Member__c'));
        clm.add(new ComponentsEnabled__c(Name='RegisterStep2', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='icon-gift', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Register Step 2', RecordType__c='Form', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Member__c'));
        clm.add(new ComponentsEnabled__c(Name='Navigation', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-link', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Navigation', RecordType__c='Navigation', RelatedListName__c='Navigations__r', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Navigation__c'));
        clm.add(new ComponentsEnabled__c(Name='NavigationDetail', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-link', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Navigation Detail', RecordType__c='Detail', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Navigation__c'));
        clm.add(new ComponentsEnabled__c(Name='Redemptions', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-currency', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Redemptions', RecordType__c='List', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'RedemptionItem__c'));
        clm.add(new ComponentsEnabled__c(Name='ContentFeedWidget', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-news', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Content Feed Widget', RecordType__c='Widget', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'News__c'));
        clm.add(new ComponentsEnabled__c(Name='ShoppingCart', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-shoppingCart', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Shopping Cart', RecordType__c='ShoppingCart', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Reward__c'));
        clm.add(new ComponentsEnabled__c(Name='BannerWidget', ControlReflectionClass__c='ControlReflectionDefault', Css__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', DataReflectionClass__c='DataReflectionDefault', Icon__c='fielo-icon-banner', Js__c='{backend=css/FontAwesome/css/font-awesome.min.css, desktop=, mobile=, tablet=}', Label__c='Banner widget', RecordType__c='Widget', RenderReflectionClass__c = 'ViewReflectionDefault', sObject__c = 'Banner__c'));
        insert clm;
    }

}