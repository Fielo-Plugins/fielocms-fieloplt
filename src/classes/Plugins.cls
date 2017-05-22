public class Plugins extends SObjectDomain {
	
	public Plugins(List<FieloCMS__Plugin__c> records){
		super(records);	
	}

	public override void onApplyDefaults(){
	}

	public override void onValidate(){
		for(FieloCMS__Plugin__c record : (List<FieloCMS__Plugin__c>) records){
		}
	}

	public override void onValidate(Map<Id,SObject> existingrecords){
		for(FieloCMS__Plugin__c record : (List<FieloCMS__Plugin__c>) records){
		}
	}

	public override void onBeforeInsert(){
		Boolean loadCSSJS = false;
		List<StaticResource> resourceList = [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = 'FieloCms_Plt_Components'];
		Id cmspltSR;
		if(!resourceList.isEmpty()){
			cmspltSR = resourceList.get(0).Id;
		}
		for(FieloCMS__Plugin__c record : (List<FieloCMS__Plugin__c>) records){
			if(record.FieloCMS__ResourceId__c == cmspltSR){
				loadCSSJS = true;
				break;
			}
		}

		String urlSR = getResourceURL(resourceList, 'FieloCms_Plt_Components');
		List<FieloCMS__Site__c> sites = new SitesSelector(new Set<String>{'Id'}).selectAll();
		for(FieloCMS__Site__c site : sites){
			site.FieloCMS__PluginCSS__c = urlSR;
			site.FieloCMS__PluginJS__c = urlSR;
		}

		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SobjectType>{FieloCMS__Site__c.SObjectType});
		uow.registerDirty(sites);
		uow.commitWork();
	}

	// Pass the resource name
	public static String getResourceURL(List<StaticResource> resourceList, String resourceName){

            // Checking if the result is returned or not
		if(resourceList.size() == 1){
			// Getting namespace
			String namespace = resourceList[0].NamespacePrefix;
			// Resource URL
			return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            }
            else return '';
	}

	public class Constructor implements SObjectDomain.IConstructable{
		
		public SObjectDomain construct(List<SObject> sObjectList){
			return new Plugins(sObjectList);
		}
	}	
}