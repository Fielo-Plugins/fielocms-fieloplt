public with sharing class FieloCMSPLT_RedemptionItemVouCtrl {

    public List<voucherItem> vouchers {get; set;}
    public String voucherCustomVoucher {get; set;}
    public FieloPLT__Program__c program {get; set;}

    public String imageId {get{
        List<Document> docs = [SELECT Id FROM Document WHERE DeveloperName = 'FieloLogoSmallBackEnd' LIMIT 1];
        if(docs.size() > 0){
            return docs[0].Id;
        }
        return null;}}

    public String docURL{get{
        if(docURL == null){
                //docURL = OrganizationUtil.getDocURL();
            }
            return docURL;
        } set;}
    public String orgId{get{return UserInfo.getOrganizationId();}set;}//this is used in the component instead of using $Organization.Id directly in VisualForce because using the attribute the image can be cached


    public with sharing class voucherItem {

        public FieloPLT__RedemptionItem__c redemptionItem {get;set;}
        public String image{get;set;}
        public Integer voucherNum {get;set;}
        public String instructionsReward{get;set;}
        public String instructionsVoucher{get;set;}

        public voucherItem (FieloPLT__RedemptionItem__c redemptionItem, String imageId, Integer i ,String instructionsVoucher, String instructionsReward ) {
            this.redemptionItem = redemptionItem;
            this.image = imageId;
            this.voucherNum = i;
            this.instructionsVoucher = instructionsVoucher;
            if(redemptionItem.FieloPLT__Reward__r.FieloCMSPLT_InstructionsRichText__c != null){
                this.instructionsReward = redemptionItem.FieloPLT__Reward__r.FieloCMSPLT_InstructionsRichText__c;
            }else{
                this.instructionsReward = instructionsReward;
            }
        }
    }

    public FieloCMSPLT_RedemptionItemVouCtrl(){
        String idOrden = ApexPages.currentPage().getParameters().get('ordenId');
        String voucherId = ApexPages.currentPage().getParameters().get('voucherId');

        if(String.isNotBlank(idOrden) || String.isNotBlank(voucherId)){
            List<FieloPLT__RedemptionItem__c> redemptionItem;
            String query = 'SELECT Name, FieloPLT__Redemption__r.FieloPLT__Member__r.FieloPLT__Program__c, LastModifiedDate, Id, FieloPLT__Redemption__c, FieloPLT__Quantity__c, FieloPLT__Status__c, FieloPLT__Reward__c, FieloPLT__Reward__r.FieloPLT__Image__c, FieloPLT__Reward__r.FieloCMSPLT_InstructionsRichText__c, FieloPLT__Reward__r.FieloPLT__UniqueVoucher__c, FieloPLT__UniqueCode__c, FieloPLT__Reward__r.Name, FieloPLT__Code__c, CreatedDate, CreatedById';
            List<Schema.FieldSetMember> fieldsRedemptionItem = Schema.SObjectType.FieloPLT__RedemptionItem__c.fieldSets.FieloCMSPLT_Voucher.getFields();

            for(Schema.FieldSetMember f : fieldsRedemptionItem){
                if(!query.contains(f.getFieldPath())){
                    query += ', '+f.getFieldPath();
                }
            }

            query += ' FROM FieloPLT__RedemptionItem__c';

            if(String.isNotBlank(idOrden)){
                query += ' WHERE FieloPLT__Redemption__c =: idOrden';
            }else if(String.isNotBlank(voucherId)){
                query += ' WHERE Id =: voucherId';
            }
            redemptionItem = Database.query(query);
            if(!redemptionItem.isEmpty()){
                program = new FieloCMSPLT_ProgramsSelector(new Set<String>{'FieloCMSPLT_ShowVoucherCode__c', 'FieloCMSPLT_CustomVoucherCss__c', 'FieloCMSPLT_VoucherInstructions__c', 'FieloCMSPLT_RewardInstructions__c'}).selectById(new Set<Id>{redemptionItem[0].FieloPLT__Redemption__r.FieloPLT__Member__r.FieloPLT__Program__c})[0];
            }else{
                program = new FieloCMSPLT_ProgramsSelector(new Set<String>{'FieloCMSPLT_ShowVoucherCode__c', 'FieloCMSPLT_CustomVoucherCss__c', 'FieloCMSPLT_VoucherInstructions__c', 'FieloCMSPLT_RewardInstructions__c'}).selectByDefault();
            }

            voucherCustomVoucher = program.FieloCMSPLT_CustomVoucherCss__c;

            vouchers = new List<voucherItem>();
            Integer i = 0;
            for(FieloPLT__RedemptionItem__c r : redemptionItem){
                i++;
                vouchers.add(new voucherItem(r, r.FieloPLT__Reward__r.FieloPLT__Image__c, i, program.FieloCMSPLT_VoucherInstructions__c, program.FieloCMSPLT_RewardInstructions__c));
                i = ( i == 2 )?0:i;
            }
        }
    }
}