
{
  "plugins" : [ {
    "Name" : "Platform Plugin",
    "components" : [ {
      "recordTypeName" : "Record",
      "Name" : "Redemption Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-redemption-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloAlpha__Status__c,FieloAlpha__Points__c,FieloAlpha__TotalItems__c",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"AddtoCart\",\"label\": \"Add to Cart\", \"reflectionClass\": \"FieloCMS_EE.AddToCartController\", \"type\": \"Subcomponent\",\"closeOrder\":\"false\",\"detailUrl\":\"\"},{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Redemption__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Transactions",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-transactions",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.TransactionAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloAlpha__Processed__c,FieloAlpha__Status__c,FieloAlpha__Type__c,FieloAlpha__Points__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Transaction__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Banner",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__Category__c,FieloCMS_EE__Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-banner",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.BannerAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__AttachmentId__c,FieloAlpha__Image__c,FieloAlpha__Event__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"AddtoCart\",         \"closeOrder\": \"False\",         \"detailurl\": \"\",         \"label\": \"Add to Cart\",         \"reflectionClass\": \"FieloCMS_EE.AddToCartController\",         \"type\": \"Subcomponent\"     },     {         \"apiName\": \"ViewImage\",         \"label\": \"ViewImage\",         \"fieldName\": \"FieloAlpha__AttachmentId__c\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\",         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Banner__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Reward Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-reward-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__AttachmentId__c,FieloAlpha__Intangible__c,FieloAlpha__RedemptionRule__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"AddtoCart\",\"label\": \"Add to Cart\", \"reflectionClass\": \"FieloCMS_EE.AddToCartController\", \"type\": \"Subcomponent\",\"closeOrder\":\"false\",\"detailUrl\":\"\"},{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Reward__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Organization Account",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-organization-account",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__OrganizationName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__LoyaltyAge__c,FieloAlpha__MemberCode__c,FieloAlpha__Preference__c,FieloAlpha__TotalValue__c,FieloAlpha__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"UploadImage\",         \"label\": \"UploadImage\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageUpload\",         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Member__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Organization Members",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-organization-members",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__Name__c,FieloAlpha__Blocked__c,FieloAlpha__FieloAccountStatus__c,FieloAlpha__IsManager__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedById,SystemModstamp,LastActivityDate,LastViewedDate,LastReferencedDate,FieloAlpha__LoyaltyAge__c,FieloAlpha__MemberCode__c,FieloAlpha__Preference__c,FieloAlpha__TotalValue__c,FieloAlpha__Type__c,FieloAlpha__imageId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"reflectionClass\":\"FieloCMS_EE.BlockUnblockMemberController\",\"type\":\"Subcomponent\",\"label\":\"Block/Unblock\",\"apiName\":\"BlockUnblock\"},{\"reflectionClass\":\"FieloCMS_EE.ToggleManagerController\",\"type\":\"Subcomponent\",\"label\":\"Toggle Manager\",\"apiName\":\"ToggleManager\"},{\"reflectionClass\":\"FieloCMS_EE.HandleInvitationsMembersController\",\"type\":\"Subcomponent\",\"label\":\"Handle Invitations\",\"apiName\":\"HandleInvitations\"}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Member__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Content Feed",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__Category__c,FieloCMS_EE__Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-content-feed",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.NewsAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloAlpha__Body__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__AttachmentId__c,FieloAlpha__Image__c,FieloAlpha__IsActive__c,FieloAlpha__RedemptionRule__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__News__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Get Points",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__TransactionType__c",
      "FieloCMS__ControlClass__c" : "FieloCMS_EE.TransactionAPI",
      "FieloCMS__CssClasses__c" : "fielo-get-points",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.TransactionAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__Code__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloAlpha__Approved__c,FieloAlpha__AttachmentId__c,FieloAlpha__BranchCode__c,FieloAlpha__Date__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.Captcha\", \"type\": \"Subcomponent\"}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Transaction__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Member Selection",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-member-selection",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__Name__c,FieloAlpha__OrganizationAccountName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__LoyaltyAge__c,FieloAlpha__Preference__c,FieloAlpha__TotalValue__c,FieloAlpha__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"reflectionClass\":\"FieloCMS_EE.SelectMemberController\",\"type\":\"Subcomponent\",\"label\":\"Login as Member\",\"apiName\":\"LoginAsMember\",\"memberType\":\"Member\"},{\"reflectionClass\":\"FieloCMS_EE.SelectMemberController\",\"type\":\"Subcomponent\",\"label\":\"Login as Organization\",\"apiName\":\"LoginAsOrganization\",\"memberType\":\"Organization\"}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Member__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Content Feed Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-content-feed-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__ExtractText__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloAlpha__AttachmentId__c,FieloAlpha__Image__c,FieloAlpha__RedemptionRule__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__News__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Filter by Category",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__Category__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-filter fielo-filter--is-category",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.CategoryAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloAlpha__AttachmentId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Category__c",
      "FieloCMS__RelatedListName__c" : "FieloAlpha__Categories__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Filter by Tag",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-filter fielo-filter--is-tag",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.TagAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloAlpha__AttachmentId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Tag__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Account",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-account",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__Email__c,FieloAlpha__FirstName__c,FieloAlpha__LastName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__LoyaltyAge__c,FieloAlpha__MemberCode__c,FieloAlpha__Preference__c,FieloAlpha__TotalValue__c,FieloAlpha__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"UploadImage\",         \"label\": \"UploadImage\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageUpload\",         \"type\": \"Subcomponent\"     },     {         \"apiName\": \"ViewImage\",         \"label\": \"View Image\",         \"fieldName\": \"FieloAlpha__imageId__c\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\",         \"showLabel\": false,         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__Member__c"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Platform Login",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__ViewClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__Visibility__c" : "Public",
      "FieloCMS__sObject__c" : "FieloCMS__Navigation__c",
      "FieloCMS__RelatedListName__c" : "FieloCMS__Navigations__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Segment Navigation",
      "FieloCMS__AdditionalFields__c" : "FieloCMS__IsAppMenu__c,FieloCMS__Navigation__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-navigation",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.NavigationAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloCMS__Navigation__c",
      "FieloCMS__RelatedListName__c" : "FieloCMS__Navigations__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Catalog",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__Category__c,FieloCMS_EE__FilterBySegment__c,FieloCMS_EE__Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-catalog",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.RewardAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloAlpha__PointsCant__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,LastViewedDate,LastReferencedDate,FieloAlpha__AttachmentId__c,FieloAlpha__Image__c,FieloAlpha__Intangible__c,FieloAlpha__RedemptionRule__c",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"AddtoCart\",\"label\": \"Add to Cart\", \"reflectionClass\": \"FieloCMS_EE.AddToCartController\", \"type\": \"Subcomponent\",\"closeOrder\":\"false\",\"detailUrl\":\"\"},{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false},\n{\"apiName\": \"Tags\",\"label\": \"Tags\", \"reflectionClass\": \"TagAPI\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloAlpha__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Reward__c"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Register",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__AccountCRMMode__c,FieloCMS_EE__AccountOwner__c,FieloCMS_EE__Account__c,FieloCMS_EE__Program__c",
      "FieloCMS__ControlClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__CssClasses__c" : "fielo-register",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__FirstName__c,FieloAlpha__LastName__c,FieloAlpha__Email__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__LoyaltyAge__c,FieloAlpha__MemberCode__c,FieloAlpha__Preference__c,FieloAlpha__TotalValue__c,FieloAlpha__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.Captcha\", \"type\": \"Subcomponent\"}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloAlpha__Member__c"
    }, {
      "recordTypeName" : "List",
      "Name" : "Redemption Items",
      "FieloCMS__AdditionalFields__c" : "FieloCMS_EE__ParemeterName__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-redemption-items",
      "FieloCMS__DataClass__c" : "FieloCMS_EE.RedemptionItemAPI",
      "FieloCMS__DefaultFields__c" : "FieloAlpha__UniqueCode__c,FieloAlpha__RewardItem__c,FieloAlpha__ExpirationDate__c,FieloAlpha__DeliveredDate__c,FieloAlpha__Status__c,FieloAlpha__VoucherLink__c",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloAlpha__Code__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloAlpha__RedemptionItem__c"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Register Step 2",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.Captcha\", \"type\": \"Subcomponent\"}]",
      "FieloCMS__ViewClass__c" : "FieloCMS_EE.MemberAPI",
      "FieloCMS__Visibility__c" : "Public"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Shopping Cart",
      "FieloCMS__AdditionalFields__c" : "FieloCMS__Page__c,FieloCMS_EE__ParemeterName__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-shopping-cart",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__ViewClass__c" : "FieloCMS_EE.RedemptionAPI",
      "FieloCMS__Visibility__c" : "Private"
    } ],
    "models" : [ {
      "Name" : "Blank Template",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Template",
      "FieloCMS__XMLReference__c" : "{     \"pages\": [         {             \"FieloCMS__Icon__c\": \"fielo-icon-content\",             \"recordTypeName\": \"Template\",             \"sections\": [                 {                     \"FieloCMS__ElementType__c\": \"Header\",                     \"FieloCMS__Width__c\": \"12\",                     \"subsections\": [                         {                             \"FieloCMS__ElementType__c\": \"Div\",                             \"FieloCMS__IsBody__c\": false,                             \"FieloCMS__Order__c\": 0,                             \"FieloCMS__Width__c\": \"12\"                         }                     ]                 },                 {                     \"FieloCMS__ElementType__c\": \"Main\",                     \"FieloCMS__IsBody__c\": true,                     \"FieloCMS__Width__c\": \"12\"                 },                 {                     \"FieloCMS__ElementType__c\": \"Footer\",                     \"FieloCMS__Width__c\": \"12\",                     \"subsections\": [                         {                             \"FieloCMS__ElementType__c\": \"Div\",                             \"FieloCMS__IsBody__c\": false,                             \"FieloCMS__Order__c\": 0,                             \"FieloCMS__Width__c\": \"12\"                         }                     ]                 }             ]         }     ] }"
    }, {
      "Name" : "Blank Page",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{  \r\n   \"pages\":[  \r\n      {  \r\n         \"recordTypeName\":\"Page\",\r\n         \"sections\":[  \r\n            {  \r\n               \"FieloCMS__ElementType__c\":\"Div\",\r\n               \"FieloCMS__Width__c\":\"12\",\r\n               \"subsections\":[  \r\n                  {  \r\n                     \"FieloCMS__ElementType__c\":\"Div\",\r\n                     \"FieloCMS__Width__c\":\"12\"\r\n                  }\r\n               ]\r\n\r\n            }\r\n         ]\r\n      }\r\n   ]\r\n}"
    }, {
      "Name" : "My Profile (Individual Account)",
      "FieloCMS__Description__c" : "Page with component Account, Transactions and Redemptions Items for Individual Account Members",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQoFAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"My Profile (Individual)\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 19, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 20, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Account\", \"Name\" : \"Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"FieloAlpha__Email__c\\\", \\\"label\\\": \\\"E-Mail\\\", \\\"type\\\": \\\"EMAIL\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false},{ \\\"apiName\\\" : \\\"FieloAlpha__FirstName__c\\\", \\\"label\\\": \\\"First Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false},{ \\\"apiName\\\" : \\\"FieloAlpha__LastName__c\\\", \\\"label\\\": \\\"Last Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false},{\\\"apiName\\\":\\\"ViewImage\\\",\\\"label\\\":\\\"View Image\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"showLabel\\\":false,\\\"reflectionClass\\\":\\\"FieloCMS.Subcomponents.ImageView\\\",\\\"fieldName\\\":\\\"FieloAlpha__imageId__c\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Profile\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Transactions\", \"Name\" : \"Transactions\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Transaction Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Processed\\\",\\\"apiName\\\":\\\"FieloAlpha__Processed__c\\\",\\\"type\\\":\\\"BOOLEAN\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloAlpha__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Type\\\",\\\"apiName\\\":\\\"FieloAlpha__Type__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Purchase Value\\\",\\\"apiName\\\":\\\"FieloAlpha__Value__c\\\",\\\"type\\\":\\\"CURRENCY\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Transactions\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Redemption Items\", \"Name\" : \"Redemption Items\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Code\\\",\\\"apiName\\\":\\\"FieloAlpha__Code__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Delivered Date\\\",\\\"apiName\\\":\\\"FieloAlpha__DeliveredDate__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloAlpha__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Voucher Link\\\",\\\"apiName\\\":\\\"FieloAlpha__VoucherLink__c\\\",\\\"type\\\":\\\"STRING\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 3, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Redemptions\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Reward Detail",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQdmAAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"Catalog Detail\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 6, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 7, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Reward Detail\", \"Name\" : \"Reward Detail\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Reward Name\\\",\\\"apiName\\\":\\\"Name\\\"},{\\\"showLabel\\\":false,\\\"type\\\":\\\"DOUBLE\\\",\\\"label\\\":\\\"Points\\\",\\\"apiName\\\":\\\"FieloAlpha__PointsCant__c\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Post\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 0, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Person Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Shopping Cart",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQmJAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Shopping Cart\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 11, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 12, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Shopping Cart\", \"Name\" : \"Shopping Cart\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Grid\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Your Shopping Cart\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Register Step 2",
      "FieloCMS__Description__c" : "Page with component Register Step 2",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQo5AAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"RegisterStep2\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 17, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 18, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Register Step 2\", \"Name\" : \"Register Step 2\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Register Step 2\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Home (Catalog with Categories)",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQdhAAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"Home\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 5, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 0, \"FieloCMS__Width__c\" : \"3\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Filter by Category\", \"Name\" : \"Filter by Category\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"Name\\\",\\\"label\\\":\\\"Category Name\\\",\\\"showLabel\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Vertical\", \"FieloCMS__Layout__c\" : \"Menu\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : false, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Categories\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] }, { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Width__c\" : \"9\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Catalog\", \"Name\" : \"Catalog\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__DetailURL__c\" : \"FieloCMS__Component?pageId=a0w61000001JQdmAAG&componentId=a0r61000001yHwWAAU\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Reward Name\\\",\\\"apiName\\\":\\\"Name\\\"},{\\\"apiName\\\":\\\"ViewImage\\\",\\\"label\\\":\\\"ViewImage\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"showLabel\\\":false,\\\"fieldName\\\":\\\"FieloAlpha__AttachmentId__c\\\",\\\"reflectionClass\\\":\\\"FieloCMS.Subcomponents.ImageView\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"DOUBLE\\\",\\\"label\\\":\\\"Points\\\",\\\"apiName\\\":\\\"FieloAlpha__PointsCant__c\\\"},{\\\"showLabel\\\":false,\\\"detailUrl\\\":\\\"\\\",\\\"closeOrder\\\":\\\"false\\\",\\\"reflectionClass\\\":\\\"AddToCartController\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"label\\\":\\\"Add to Cart\\\",\\\"apiName\\\":\\\"AddtoCart\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Grid\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Delegate Administration",
      "FieloCMS__Description__c" : "Page with Organization Account component and Register component  to invite new contributors to the organization",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQyFAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Delegate Administration\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"FieloCMS__Title__c\" : \"Delegate Administration\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 23, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 24, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Organization Members\", \"Name\" : \"Organization Members\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"FieloAlpha__Name__c\\\", \\\"label\\\": \\\"Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"linkToDetail\\\": false, \\\"orderBy\\\": \\\"disabled\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloAlpha__Blocked__c\\\", \\\"label\\\": \\\"Blocked\\\", \\\"type\\\": \\\"BOOLEAN\\\" , \\\"linkToDetail\\\": false, \\\"orderBy\\\": \\\"disabled\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloAlpha__FieloAccountStatus__c\\\", \\\"label\\\": \\\"Status\\\", \\\"type\\\": \\\"PICKLIST\\\" , \\\"linkToDetail\\\": false, \\\"orderBy\\\": \\\"disabled\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloAlpha__IsManager__c\\\", \\\"label\\\": \\\"Is Manager\\\", \\\"type\\\": \\\"BOOLEAN\\\" , \\\"linkToDetail\\\": false, \\\"orderBy\\\": \\\"disabled\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"BlockUnblockMember\\\", \\\"label\\\": \\\"Block/Unblock\\\", \\\"type\\\": \\\"Subcomponent\\\" , \\\"showLabel\\\": true, \\\"reflectionClass\\\": \\\"BlockUnblockMemberController\\\" },{ \\\"apiName\\\" : \\\"HandleInvitationsMembers\\\", \\\"label\\\": \\\"Handle Invitations\\\", \\\"type\\\": \\\"Subcomponent\\\" , \\\"showLabel\\\": true, \\\"reflectionClass\\\": \\\"HandleInvitationsMembersController\\\" },{ \\\"apiName\\\" : \\\"ToggleManager\\\", \\\"label\\\": \\\"Toggle Manager\\\", \\\"type\\\": \\\"Subcomponent\\\" , \\\"showLabel\\\": true, \\\"reflectionClass\\\": \\\"ToggleManagerController\\\" }]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 5, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : false, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Organization Members\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Register\", \"Name\" : \"Register\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"FieloAlpha__Email__c\\\", \\\"label\\\": \\\"E-Mail\\\", \\\"type\\\": \\\"EMAIL\\\" , \\\"required\\\": false, \\\"readOnly\\\": false, \\\"placeholder\\\": \\\"\\\" , \\\"autocomplete\\\": \\\"\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloAlpha__FirstName__c\\\", \\\"label\\\": \\\"First Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"required\\\": false, \\\"readOnly\\\": false, \\\"placeholder\\\": \\\"\\\" , \\\"autocomplete\\\": \\\"\\\" , \\\"showLabel\\\": true},{ \\\"apiName\\\" : \\\"FieloAlpha__LastName__c\\\", \\\"label\\\": \\\"Last Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"required\\\": false, \\\"readOnly\\\": false, \\\"placeholder\\\": \\\"\\\" , \\\"autocomplete\\\": \\\"\\\" , \\\"showLabel\\\": true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"Edit\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Invite New Contributor\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Content",
      "FieloCMS__Description__c" : "Page with component Banner y Content Feed",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQnHAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Banners y Content Feed\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 15, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 16, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Banner\", \"Name\" : \"Banner\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"ViewImage\\\", \\\"label\\\": \\\"ViewImage\\\", \\\"type\\\": \\\"Subcomponent\\\" , \\\"showLabel\\\": false, \\\"reflectionClass\\\": \\\"FieloCMS.Subcomponents.ImageView\\\" , \\\"fieldName\\\": \\\"FieloAlpha__AttachmentId__c\\\" }]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Slider\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Banner\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Content Feed\", \"Name\" : \"Content Feed\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Body\\\",\\\"apiName\\\":\\\"FieloAlpha__Body__c\\\",\\\"type\\\":\\\"TEXTAREA\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Grid\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Content Feed\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Register & Login",
      "FieloCMS__Description__c" : "Page with Component Register & Login",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQdrAAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"Login & Register\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 10, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 0, \"FieloCMS__Width__c\" : \"6\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Platform Login\", \"Name\" : \"Platform Login\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Platform Login\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] }, { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Width__c\" : \"6\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Register\", \"Name\" : \"Register\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"E-Mail\\\",\\\"apiName\\\":\\\"FieloAlpha__Email__c\\\",\\\"type\\\":\\\"EMAIL\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"First Name\\\",\\\"apiName\\\":\\\"FieloAlpha__FirstName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Last Name\\\",\\\"apiName\\\":\\\"FieloAlpha__LastName__c\\\",\\\"type\\\":\\\"STRING\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"Edit\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Register New Member\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "My Profile (Contributor)",
      "FieloCMS__Description__c" : "Page with Organization Account & Account component for contributors members",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQoKAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"My Profile (Contributor)\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 21, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 22, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Organization Account\", \"Name\" : \"Organization Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Organization Name\\\",\\\"apiName\\\":\\\"FieloAlpha__OrganizationName__c\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"City\\\",\\\"apiName\\\":\\\"FieloAlpha__City__c\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Country\\\",\\\"apiName\\\":\\\"FieloAlpha__Country__c\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"label\\\":\\\"Neighborhood\\\",\\\"apiName\\\":\\\"FieloAlpha__Neighborhood__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Street\\\",\\\"apiName\\\":\\\"FieloAlpha__Street__c\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"State/Province\\\",\\\"apiName\\\":\\\"FieloAlpha__State__c\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Zip/Postal Code\\\",\\\"apiName\\\":\\\"FieloAlpha__ZipCode__c\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Post\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Account\", \"Name\" : \"Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{ \\\"apiName\\\" : \\\"FieloAlpha__Email__c\\\", \\\"label\\\": \\\"E-Mail\\\", \\\"type\\\": \\\"EMAIL\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false},{ \\\"apiName\\\" : \\\"FieloAlpha__FirstName__c\\\", \\\"label\\\": \\\"First Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false},{ \\\"apiName\\\" : \\\"FieloAlpha__LastName__c\\\", \\\"label\\\": \\\"Last Name\\\", \\\"type\\\": \\\"STRING\\\" , \\\"showLabel\\\": true, \\\"autocomplete\\\": \\\"\\\" , \\\"placeholder\\\": \\\"\\\" , \\\"readOnly\\\": false, \\\"required\\\": false}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Account\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Select Member",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w61000001JQyKAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Select Member\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 25, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 26, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Member Selection\", \"Name\" : \"Member Selection\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"STRING\\\",\\\"label\\\":\\\"Name\\\",\\\"apiName\\\":\\\"FieloAlpha__Name__c\\\"},{\\\"reflectionClass\\\":\\\"SelectMemberController\\\",\\\"memberType\\\":\\\"Member\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"Subcomponent\\\",\\\"label\\\":\\\"Login as Member\\\",\\\"apiName\\\":\\\"LoginAsMember\\\"},{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloAlpha__OrganizationAccountName__c\\\",\\\"label\\\":\\\"Organization Account Name\\\",\\\"showLabel\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"linkToDetail\\\":false},{\\\"reflectionClass\\\":\\\"SelectMemberController\\\",\\\"memberType\\\":\\\"Organization\\\",\\\"showLabel\\\":false,\\\"type\\\":\\\"Subcomponent\\\",\\\"label\\\":\\\"Login as Organization\\\",\\\"apiName\\\":\\\"LoginAsOrganization\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : false, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    } ]
  } ]
}