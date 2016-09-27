
{
  "plugins" : [ {
    "Name" : "Platform Plugin",
    "FieloCMS__ResourceId__c" : "08136000001YelSAAS",
    "components" : [ {
      "recordTypeName" : "Record",
      "Name" : "Redemption Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-redemption-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPLT__Status__c,FieloPLT__Points__c,FieloPLT__TotalItems__c",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloPLT__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Redemption__c",
      "FieloCMS__Layouts__c" : "View"
    }, {
      "recordTypeName" : "List",
      "Name" : "Transactions",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-transactions",
      "FieloCMS__DataClass__c" : "TransactionAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPLT__Points__c,FieloPLT__Processed__c,FieloPLT__Status__c,FieloPLT__Type__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Transaction__c",
      "FieloCMS__Layouts__c" : "Grid;Table"
    }, {
      "recordTypeName" : "List",
      "Name" : "Banner",
      "FieloCMS__AdditionalFields__c" : "Category__c,Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-banner",
      "FieloCMS__DataClass__c" : "BannerAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__AttachmentId__c,FieloPLT__Image__c,FieloPLT__Event__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[  {         \"apiName\": \"ViewImage\",         \"label\": \"ViewImage\",         \"fieldName\": \"FieloPLT__AttachmentId__c\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\",         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Banner__c",
      "FieloCMS__Layouts__c" : "Grid;Slider"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Reward Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-reward-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__AttachmentId__c,FieloPLT__Intangible__c,FieloPLT__Segment__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"AddtoCart\",\"label\": \"Add to Cart\", \"reflectionClass\": \"AddToCartController\", \"type\": \"Subcomponent\",\"closeOrder\":\"false\",\"detailUrl\":\"\"},{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloPLT__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Reward__c",
      "FieloCMS__Layouts__c" : "View"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Organization Account",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-organization-account",
      "FieloCMS__DataClass__c" : "MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__OrganizationName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__LoyaltyAge__c,FieloPLT__MemberCode__c,FieloPLT__Preference__c,FieloPLT__TotalValue__c,FieloPLT__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"UploadImage\",         \"label\": \"UploadImage\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageUpload\",         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Member__c",
      "FieloCMS__Layouts__c" : "View"
    }, {
      "recordTypeName" : "List",
      "Name" : "Organization Members",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-organization-members",
      "FieloCMS__DataClass__c" : "MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__IsBlocked__c,FieloPLT__Status__c,FieloPLT__IsManager__c,FieloPLT__Name__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedById,SystemModstamp,LastActivityDate,LastViewedDate,LastReferencedDate,FieloPLT__LoyaltyAge__c,FieloPLT__MemberCode__c,FieloPLT__Preference__c,FieloPLT__TotalValue__c,FieloPLT__Type__c,FieloPLT__imageId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"reflectionClass\":\"BlockUnblockMemberController\",\"type\":\"Subcomponent\",\"label\":\"Block/Unblock\",\"apiName\":\"BlockUnblock\"},{\"reflectionClass\":\"ToggleManagerController\",\"type\":\"Subcomponent\",\"label\":\"Toggle Manager\",\"apiName\":\"ToggleManager\"},{\"reflectionClass\":\"HandleInvitationsMembersController\",\"type\":\"Subcomponent\",\"label\":\"Handle Invitations\",\"apiName\":\"HandleInvitations\"}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Member__c",
      "FieloCMS__Layouts__c" : "Grid;Table"
    }, {
      "recordTypeName" : "List",
      "Name" : "Content Feed",
      "FieloCMS__AdditionalFields__c" : "Category__c,Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-content-feed",
      "FieloCMS__DataClass__c" : "NewsAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPLT__Body__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__AttachmentId__c,FieloPLT__Image__c,FieloPLT__IsActive__c,FieloPLT__Segment__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloPLT__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__News__c",
      "FieloCMS__Layouts__c" : "Grid;Slider;Table"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Get Points",
      "FieloCMS__AdditionalFields__c" : "TransactionType__c",
      "FieloCMS__ControlClass__c" : "TransactionAPI",
      "FieloCMS__CssClasses__c" : "fielo-get-points",
      "FieloCMS__DataClass__c" : "TransactionAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__Code__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloPLT__Approved__c,FieloPLT__AttachmentId__c,FieloPLT__BranchCode__c,FieloPLT__Date__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.captcha\", \"type\": \"Subcomponent\", \"secretKey\":\"XXX\", \"siteKey\":\"XXX\"}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Transaction__c",
      "FieloCMS__Layouts__c" : "Edit"
    }, {
      "recordTypeName" : "List",
      "Name" : "Member Selection",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-member-selection",
      "FieloCMS__DataClass__c" : "MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__Name__c,FieloPLT__OrganizationAccountName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__LoyaltyAge__c,FieloPLT__Preference__c,FieloPLT__TotalValue__c,FieloPLT__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[{\"reflectionClass\":\"SelectMemberController\",\"type\":\"Subcomponent\",\"label\":\"Login as Member\",\"apiName\":\"LoginAsMember\",\"memberType\":\"Member\"},{\"reflectionClass\":\"SelectMemberController\",\"type\":\"Subcomponent\",\"label\":\"Login as Organization\",\"apiName\":\"LoginAsOrganization\",\"memberType\":\"Organization\"}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Member__c",
      "FieloCMS__Layouts__c" : "Table"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Content Feed Detail",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-content-feed-detail",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__ExtractText__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloPLT__AttachmentId__c,FieloPLT__Image__c,FieloPLT__Segment__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"ViewImage\",\"label\": \"ViewImage\", \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\", \"type\": \"Subcomponent\", \"fieldName\":\"FieloPLT__AttachmentId__c\",\"showLabel\":false}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__News__c",
      "FieloCMS__Layouts__c" : "View"
    }, {
      "recordTypeName" : "List",
      "Name" : "Filter by Category",
      "FieloCMS__AdditionalFields__c" : "Category__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-filter fielo-filter--is-category",
      "FieloCMS__DataClass__c" : "CategoryAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloPLT__AttachmentId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Category__c",
      "FieloCMS__Layouts__c" : "Menu",
      "FieloCMS__RelatedListName__c" : "FieloPLT__Categories__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Filter by Tag",
      "FieloCMS__AdditionalFields__c" : "Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-filter fielo-filter--is-tag",
      "FieloCMS__DataClass__c" : "TagAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,FieloPLT__AttachmentId__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Tag__c",
      "FieloCMS__Layouts__c" : "Menu"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Account",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-account",
      "FieloCMS__DataClass__c" : "MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__FirstName__c,FieloPLT__LastName__c,FieloPLT__Email__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__LoyaltyAge__c,FieloPLT__MemberCode__c,FieloPLT__Preference__c,FieloPLT__TotalValue__c,FieloPLT__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"UploadImage\",         \"label\": \"UploadImage\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageUpload\",         \"type\": \"Subcomponent\"     },     {         \"apiName\": \"ViewImage\",         \"label\": \"View Image\",         \"fieldName\": \"FieloPLT__imageId__c\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\",         \"showLabel\": false,         \"type\": \"Subcomponent\"     } ,{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.captcha\", \"type\": \"Subcomponent\", \"secretKey\":\"XXX\", \"siteKey\":\"XXX\"}]",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__Member__c",
      "FieloCMS__Layouts__c" : "View;Edit;Markup"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Platform Login",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__ViewClass__c" : "MemberAPI",
      "FieloCMS__Visibility__c" : "Public",
      "FieloCMS__sObject__c" : "FieloCMS__Navigation__c",
      "FieloCMS__RelatedListName__c" : "FieloCMS__Navigations__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Segment Navigation",
      "FieloCMS__AdditionalFields__c" : "FieloCMS__IsAppMenu__c,FieloCMS__Navigation__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-navigation",
      "FieloCMS__DataClass__c" : "NavigationAPI",
      "FieloCMS__DefaultFields__c" : "Name",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloCMS__Navigation__c",
      "FieloCMS__Layouts__c" : "Menu",
      "FieloCMS__RelatedListName__c" : "FieloCMS__Navigations__r"
    }, {
      "recordTypeName" : "List",
      "Name" : "Catalog",
      "FieloCMS__AdditionalFields__c" : "Category__c,FilterBySegment__c,Tag__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-catalog",
      "FieloCMS__DataClass__c" : "RewardAPI",
      "FieloCMS__DefaultFields__c" : "Name,FieloPLT__PointsCant__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,LastViewedDate,LastReferencedDate,FieloPLT__AttachmentId__c,FieloPLT__Image__c,FieloPLT__Intangible__c,FieloPLT__Segment__c",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Subcomponents__c" : "[     {         \"apiName\": \"AddtoCart\",         \"closeOrder\": \"false\",         \"detailUrl\": \"\",         \"label\": \"Add to Cart\",         \"reflectionClass\": \"AddToCartController\",         \"type\": \"Subcomponent\"     },     {         \"apiName\": \"ViewImage\",         \"fieldName\": \"FieloPLT__AttachmentId__c\",         \"label\": \"ViewImage\",         \"reflectionClass\": \"FieloCMS.Subcomponents.ImageView\",         \"showLabel\": false,         \"type\": \"Subcomponent\"     },     {         \"apiName\": \"Tags\",         \"fieldName\": \"FieloPLT__AttachmentId__c\",         \"label\": \"Tags\",         \"reflectionClass\": \"TagAPI\",         \"showLabel\": false,         \"type\": \"Subcomponent\"     } ]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Reward__c",
      "FieloCMS__Layouts__c" : "Grid;Slider;Table"
    }, {
      "recordTypeName" : "Record",
      "Name" : "Register",
      "FieloCMS__AdditionalFields__c" : "AccountCRMMode__c,AccountOwner__c,Account__c,Program__c",
      "FieloCMS__ControlClass__c" : "MemberAPI",
      "FieloCMS__CssClasses__c" : "fielo-register",
      "FieloCMS__DataClass__c" : "MemberAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__Email__c,FieloPLT__FirstName__c,FieloPLT__LastName__c",
      "FieloCMS__ExcludeFields__c" : "Id,OwnerId,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__LoyaltyAge__c,FieloPLT__MemberCode__c,FieloPLT__Preference__c,FieloPLT__TotalValue__c,FieloPLT__Type__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Record",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.captcha\", \"type\": \"Subcomponent\", \"secretKey\":\"XXX\", \"siteKey\":\"XXX\"}]",
      "FieloCMS__Visibility__c" : "Both",
      "FieloCMS__sObject__c" : "FieloPLT__Member__c",
      "FieloCMS__Layouts__c" : "Edit"
    }, {
      "recordTypeName" : "List",
      "Name" : "Redemption Items",
      "FieloCMS__AdditionalFields__c" : "ParameterName__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-redemption-items",
      "FieloCMS__DataClass__c" : "RedemptionItemAPI",
      "FieloCMS__DefaultFields__c" : "FieloPLT__RewardItem__c,FieloPLT__DeliveredDate__c,FieloPLT__ExpirationDate__c,FieloPLT__Status__c,FieloPLT__UniqueCode__c,FieloPLT__VoucherLink__c",
      "FieloCMS__ExcludeFields__c" : "Id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,FieloPLT__Code__c",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "List",
      "FieloCMS__Visibility__c" : "Private",
      "FieloCMS__sObject__c" : "FieloPLT__RedemptionItem__c",
      "FieloCMS__Layouts__c" : "Grid;Table"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Register Step 2",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__Subcomponents__c" : "[{\"apiName\": \"Captcha\",\"label\": \"Captcha\", \"reflectionClass\": \"FieloCMS.Subcomponents.Captcha\", \"type\": \"Subcomponent\"}]",
      "FieloCMS__ViewClass__c" : "MemberAPI",
      "FieloCMS__Visibility__c" : "Public"
    }, {
      "recordTypeName" : "Widget",
      "Name" : "Shopping Cart",
      "FieloCMS__AdditionalFields__c" : "ParameterName__c,RedirectPage__c",
      "FieloCMS__ControlClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__CssClasses__c" : "fielo-shopping-cart",
      "FieloCMS__DataClass__c" : "FieloCMS.StandardAPI",
      "FieloCMS__Icon__c" : "FieloCms_Salesforce-vendor/images/sections/one_column.jpg",
      "FieloCMS__RecordType__c" : "Widget",
      "FieloCMS__ViewClass__c" : "RedemptionAPI",
      "FieloCMS__Visibility__c" : "Private"
    } ],
    "models" : [ {
      "Name" : "My Profile (Contributor)",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NZrfAAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"My Profile (Contributor)\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 100, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 101, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Organization Account\", \"Name\" : \"Organization Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"FieloPLT__OrganizationName__c\\\",\\\"label\\\":\\\"Organization Name\\\",\\\"showLabel\\\":true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Post\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Organization Profile\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Account\", \"Name\" : \"Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"First Name\\\",\\\"apiName\\\":\\\"FieloPLT__FirstName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Last Name\\\",\\\"apiName\\\":\\\"FieloPLT__LastName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"E-Mail\\\",\\\"apiName\\\":\\\"FieloPLT__Email__c\\\",\\\"type\\\":\\\"EMAIL\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Profile\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Reward Detail",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NZrVAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Reward Detail\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 96, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 97, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Reward Detail\", \"Name\" : \"Reward Detail\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"Name\\\",\\\"label\\\":\\\"Reward Name\\\",\\\"showLabel\\\":true},{\\\"type\\\":\\\"TEXTAREA\\\",\\\"apiName\\\":\\\"FieloPLT__Description__c\\\",\\\"label\\\":\\\"Description\\\",\\\"showLabel\\\":true},{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPLT__PointsCant__c\\\",\\\"label\\\":\\\"Points\\\",\\\"showLabel\\\":true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Home",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NZrQAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Home\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 95, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 0, \"FieloCMS__Width__c\" : \"3\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Filter by Category\", \"Name\" : \"Filter by Category\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Category Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Vertical\", \"FieloCMS__Layout__c\" : \"Menu\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : false, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Filter by Category\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] }, { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Width__c\" : \"9\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Catalog\", \"Name\" : \"Catalog\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Reward Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":false,\\\"fieldName\\\":\\\"FieloPLT__AttachmentId__c\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"FieloCMS.Subcomponents.ImageView\\\",\\\"label\\\":\\\"ViewImage\\\",\\\"apiName\\\":\\\"ViewImage\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Points\\\",\\\"apiName\\\":\\\"FieloPLT__PointsCant__c\\\",\\\"type\\\":\\\"DOUBLE\\\"},{\\\"showLabel\\\":true,\\\"detailUrl\\\":\\\"\\\",\\\"closeOrder\\\":\\\"false\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"AddToCartController\\\",\\\"label\\\":\\\"Add to Cart\\\",\\\"apiName\\\":\\\"AddtoCart\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Grid\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Catalog\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "My Profile (Individual Account)",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NZraAAG\", \"recordTypeName\" : \"Page\", \"Name\" : \"My Profile (Individual Account)\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 98, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 99, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Account\", \"Name\" : \"Account\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"First Name\\\",\\\"apiName\\\":\\\"FieloPLT__FirstName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Last Name\\\",\\\"apiName\\\":\\\"FieloPLT__LastName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"required\\\":false,\\\"readOnly\\\":false,\\\"inlineHelpText\\\":\\\"\\\",\\\"placeholder\\\":\\\"\\\",\\\"autocomplete\\\":\\\"\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"E-Mail\\\",\\\"apiName\\\":\\\"FieloPLT__Email__c\\\",\\\"type\\\":\\\"EMAIL\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Form\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Profile\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Transactions\", \"Name\" : \"Transactions\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Transaction Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Points\\\",\\\"apiName\\\":\\\"FieloPLT__Points__c\\\",\\\"type\\\":\\\"DOUBLE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Processed\\\",\\\"apiName\\\":\\\"FieloPLT__Processed__c\\\",\\\"type\\\":\\\"BOOLEAN\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPLT__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Type\\\",\\\"apiName\\\":\\\"FieloPLT__Type__c\\\",\\\"type\\\":\\\"PICKLIST\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Transactions\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Redemption Items\", \"Name\" : \"Redemption Items\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Unique Code\\\",\\\"apiName\\\":\\\"FieloPLT__UniqueCode__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Reward Item\\\",\\\"apiName\\\":\\\"FieloPLT__RewardItem__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Delivered Date\\\",\\\"apiName\\\":\\\"FieloPLT__DeliveredDate__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"ExpirationDate\\\",\\\"apiName\\\":\\\"FieloPLT__ExpirationDate__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPLT__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Voucher Link\\\",\\\"apiName\\\":\\\"FieloPLT__VoucherLink__c\\\",\\\"type\\\":\\\"STRING\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 3, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"My Redemptions\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
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
      "Name" : "Login & Register",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NZrLAAW\", \"recordTypeName\" : \"Page\", \"Name\" : \"Login & Register\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 92, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 0, \"FieloCMS__Width__c\" : \"6\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Platform Plugin.Platform Login\", \"Name\" : \"Platform Login\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Login\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] }, { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Width__c\" : \"6\", \"components\" : [ ] } ] } ] } ] }"
    }, {
      "Name" : "Select Member",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nvl8AAC\", \"recordTypeName\" : \"Page\", \"Name\" : \"Select Member\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 100, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 101, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Member Selection\", \"Name\" : \"Member Selection\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Name\\\",\\\"apiName\\\":\\\"FieloPLT__Name__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"memberType\\\":\\\"Member\\\",\\\"apiName\\\":\\\"LoginAsMember\\\",\\\"label\\\":\\\"Login as Member\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"SelectMemberController\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Organization Account Name\\\",\\\"apiName\\\":\\\"FieloPLT__OrganizationAccountName__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"showLabel\\\":true,\\\"memberType\\\":\\\"Organization\\\",\\\"apiName\\\":\\\"LoginAsOrganization\\\",\\\"label\\\":\\\"Login as Organization\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"SelectMemberController\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Select the member\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Delegate Administration",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001NvIDAA0\", \"recordTypeName\" : \"Page\", \"Name\" : \"Delegate Administration\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 108, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 109, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Organization Members\", \"Name\" : \"Organization Members\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Name\\\",\\\"apiName\\\":\\\"FieloPLT__Name__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Blocked\\\",\\\"apiName\\\":\\\"FieloPLT__IsBlocked__c\\\",\\\"type\\\":\\\"BOOLEAN\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPLT__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Is Manager\\\",\\\"apiName\\\":\\\"FieloPLT__IsManager__c\\\",\\\"type\\\":\\\"BOOLEAN\\\"},{\\\"showLabel\\\":true,\\\"apiName\\\":\\\"BlockUnblock\\\",\\\"label\\\":\\\"Block/Unblock\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"BlockUnblockMemberController\\\"},{\\\"showLabel\\\":true,\\\"apiName\\\":\\\"HandleInvitations\\\",\\\"label\\\":\\\"Handle Invitations\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"HandleInvitationsMembersController\\\"},{\\\"showLabel\\\":true,\\\"apiName\\\":\\\"ToggleManager\\\",\\\"label\\\":\\\"Toggle Manager\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"reflectionClass\\\":\\\"ToggleManagerController\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Organization Members\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Shopping Cart",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nv9LAAS\", \"recordTypeName\" : \"Page\", \"Name\" : \"Shopping Cart\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 100, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 101, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Platform Plugin.Shopping Cart\", \"Name\" : \"Shopping Cart\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Shopping Cart\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Redemption Close View",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nv9pAAC\", \"recordTypeName\" : \"Page\", \"Name\" : \"Redemption Close View\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 106, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 107, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Redemption Detail\", \"Name\" : \"Redemption Detail\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"RedemptionId\", \"FieloCMS__FieldSet__c\" : \"[{\\\"type\\\":\\\"STRING\\\",\\\"apiName\\\":\\\"Name\\\",\\\"label\\\":\\\"Code\\\",\\\"showLabel\\\":true},{\\\"type\\\":\\\"PICKLIST\\\",\\\"apiName\\\":\\\"FieloPLT__Status__c\\\",\\\"label\\\":\\\"Status\\\",\\\"showLabel\\\":true},{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPLT__Points__c\\\",\\\"label\\\":\\\"Points\\\",\\\"showLabel\\\":true},{\\\"type\\\":\\\"DOUBLE\\\",\\\"apiName\\\":\\\"FieloPLT__TotalItems__c\\\",\\\"label\\\":\\\"Total Items\\\",\\\"showLabel\\\":true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Post\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Redemption Detail\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Redemption Items\", \"Name\" : \"Redemption Items\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Unique Code\\\",\\\"apiName\\\":\\\"FieloPLT__UniqueCode__c\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Reward Item\\\",\\\"apiName\\\":\\\"FieloPLT__RewardItem__c\\\",\\\"type\\\":\\\"REFERENCE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Delivered Date\\\",\\\"apiName\\\":\\\"FieloPLT__DeliveredDate__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"ExpirationDate\\\",\\\"apiName\\\":\\\"FieloPLT__ExpirationDate__c\\\",\\\"type\\\":\\\"DATE\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Status\\\",\\\"apiName\\\":\\\"FieloPLT__Status__c\\\",\\\"type\\\":\\\"PICKLIST\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Voucher Link\\\",\\\"apiName\\\":\\\"FieloPLT__VoucherLink__c\\\",\\\"type\\\":\\\"STRING\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Redemption Items\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false, \"ParameterName__c\" : \"RedemptionId\" } ] } ] } ] } ] }"
    }, {
      "Name" : "Content Feed Detail",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nv9VAAS\", \"recordTypeName\" : \"Page\", \"Name\" : \"New Page\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 100, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 101, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Record\", \"componentLibrary\" : \"Platform Plugin.Content Feed Detail\", \"Name\" : \"Content Feed Detail\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"showLabel\\\":true,\\\"label\\\":\\\"Extract Text\\\",\\\"apiName\\\":\\\"FieloPLT__ExtractText__c\\\",\\\"type\\\":\\\"TEXTAREA\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__LayoutMode__c\" : \"Post\", \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Content Feed Detail\", \"FieloCMS__Width__c\" : 0, \"AccountCRMMode__c\" : \"Standard Account\", \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Register Step 2",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nv9fAAC\", \"recordTypeName\" : \"Page\", \"Name\" : \"Register Step 2\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 104, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 105, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"Widget\", \"componentLibrary\" : \"Platform Plugin.Register Step 2\", \"Name\" : \"Register Step 2\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"View\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Register Step 2\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    }, {
      "Name" : "Content",
      "FieloCMS__Icon__c" : "fielo-icon-content",
      "FieloCMS__Type__c" : "Page",
      "FieloCMS__XMLReference__c" : "{ \"pages\" : [ { \"sourceId\" : \"a0w36000001Nv9QAAS\", \"recordTypeName\" : \"Page\", \"Name\" : \"Content\", \"FieloCMS__Icon__c\" : \"fielo-icon-content\", \"sections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 102, \"FieloCMS__Width__c\" : \"12\", \"subsections\" : [ { \"FieloCMS__ElementType__c\" : \"Div\", \"FieloCMS__IsBody__c\" : false, \"FieloCMS__Order__c\" : 103, \"FieloCMS__Width__c\" : \"12\", \"components\" : [ { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Banner\", \"Name\" : \"Banner\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"apiName\\\":\\\"ViewImage\\\",\\\"label\\\":\\\"ViewImage\\\",\\\"fieldName\\\":\\\"FieloPLT__AttachmentId__c\\\",\\\"reflectionClass\\\":\\\"FieloCMS.Subcomponents.ImageView\\\",\\\"type\\\":\\\"Subcomponent\\\",\\\"showLabel\\\":true}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Slider\", \"FieloCMS__Limit__c\" : 4, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 1, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Banner\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false }, { \"recordTypeName\" : \"List\", \"componentLibrary\" : \"Platform Plugin.Content Feed\", \"Name\" : \"Content Feed\", \"FieloCMS__Columns__c\" : 2, \"FieloCMS__Delay__c\" : 2500, \"FieloCMS__Desktop__c\" : true, \"FieloCMS__DetailParameter__c\" : \"id\", \"FieloCMS__FieldSet__c\" : \"[{\\\"linkToDetail\\\":true,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Name\\\",\\\"apiName\\\":\\\"Name\\\",\\\"type\\\":\\\"STRING\\\"},{\\\"linkToDetail\\\":false,\\\"orderBy\\\":\\\"disabled\\\",\\\"showLabel\\\":true,\\\"label\\\":\\\"Body\\\",\\\"apiName\\\":\\\"FieloPLT__Body__c\\\",\\\"type\\\":\\\"TEXTAREA\\\"}]]\", \"FieloCMS__IsAppMenu__c\" : false, \"FieloCMS__Layout__c\" : \"Table\", \"FieloCMS__Limit__c\" : 6, \"FieloCMS__Mobile__c\" : true, \"FieloCMS__Order__c\" : 2, \"FieloCMS__Paging__c\" : true, \"FieloCMS__ParameterName__c\" : \"paginatorBinding\", \"FieloCMS__Rows__c\" : 2, \"FieloCMS__Tablet__c\" : true, \"FieloCMS__Title__c\" : \"Content Feed\", \"FieloCMS__Width__c\" : 0, \"Facebook__c\" : false, \"FilterBySegment__c\" : false } ] } ] } ] } ] }"
    } ]
  } ]
}
