public with sharing class RedemptionItemVoucherController {

    public List<voucherItem> vouchers {get; set;}
    public String voucherCustomVoucher {get; set;}
    public FieloPLT__Program__c program {get; set;}

    public String imageId {get{
        List<Document> docs = [SELECT Id FROM Document WHERE DeveloperName = 'FieloLogoSmallBackEnd' AND NamespacePrefix =: OrganizationUtil.getPrefix() LIMIT 1];
        if(docs.size() > 0){
            return docs[0].Id;
        }
        return null;}}

    public String docURL{get{
        if(docURL == null){
                docURL = OrganizationUtil.getDocURL();
            }
            return docURL;
        } set;}
    public String orgId{get{return UserInfo.getOrganizationId();}set;}//this is used in the component instead of using $Organization.Id directly in VisualForce because using the attribute the image can be cached


    public with sharing class voucherItem {

        public RedemptionItem__c redemptionItem {get;set;}
        public Id imageId{get;set;}
        public Integer voucherNum {get;set;}
        public String instructionsReward{get;set;}
        public String instructionsVoucher{get;set;}

        public voucherItem (RedemptionItem__c redemptionItem, Id imageId, Integer i ,String instructionsVoucher, String instructionsReward ) {
            this.redemptionItem = redemptionItem;
            this.imageId = imageId;
            this.voucherNum = i;
            this.instructionsVoucher = instructionsVoucher;
            if(redemptionItem.Reward__r.Instructions__c != null){
                this.instructionsReward = redemptionItem.Reward__r.InstructionsRichText__c;
            }else{
                this.instructionsReward = instructionsReward;
            }
        }
    }

    public RedemptionItemVoucherController(){
        String idOrden = ApexPages.currentPage().getParameters().get('ordenId');
        String voucherId = ApexPages.currentPage().getParameters().get('voucherId');

        if(String.isNotBlank(idOrden) || String.isNotBlank(voucherId)){
            List<RedemptionItem__c> redemptionItem;
            String query = 'SELECT Name, FieloPLT__Redemption__r.FieloPLT__Member__r.FieloPLT__Program__c, LastModifiedDate, Id, Redemption__c, Quantity__c, Status__c, Reward__c, Reward__r.AttachmentId__c, Reward__r.InstructionsRichText__c, Reward__r.Instructions__c, Reward__r.UniqueVoucher__c, UniqueCode__c, Code__c, CreatedDate, CreatedById';
            List<Schema.FieldSetMember> fieldsRedemptionItem = Schema.SObjectType.RedemptionItem__c.fieldSets.getMap().get('Voucher').getFields();

            for(Schema.FieldSetMember f : fieldsRedemptionItem){
                if(!query.contains(f.getFieldPath().replace(OrganizationUtil.getPrefixUnderScore(),''))){
                    query += ', '+f.getFieldPath();
                }
            }

            query += ' FROM RedemptionItem__c';

            if(String.isNotBlank(idOrden)){
                query += ' WHERE Redemption__c =: idOrden';
            }else if(String.isNotBlank(voucherId)){
                query += ' WHERE Id =: voucherId';
            }
            redemptionItem = Database.query(query);
            if(!redemptionItem.isEmpty()){
                program = new ProgramsSelector(new Set<String>{'ShowVoucherCode__c', 'CustomVoucherCss__c', 'InstructionsVoucher__c', 'InstructionsReward__c'}).selectById(new Set<Id>{redemptionItem[0].FieloPLT__Redemption__r.FieloPLT__Member__r.FieloPLT__Program__c})[0];
            }else{
                program = new ProgramsSelector(new Set<String>{'ShowVoucherCode__c', 'CustomVoucherCss__c', 'InstructionsVoucher__c', 'InstructionsReward__c'}).selectByDefault();
            }

            voucherCustomVoucher = program.CustomVoucherCss__c;

            vouchers = new List<voucherItem>();
            Integer i = 0;
            for(RedemptionItem__c r : redemptionItem){
                i++;
                vouchers.add(new voucherItem(r, OrganizationUtil.getImageId(r.Reward__r.AttachmentId__c), i, program.InstructionsVoucher__c, program.InstructionsReward__c));
                i = ( i == 2 )?0:i;
            }
        }
    }
}