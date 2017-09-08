public class FieloCMSPLT_Plugins extends FieloCMSPLT_SObjectDomain {
	
	public FieloCMSPLT_Plugins(List<FieloCMS__Plugin__c> records){
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
		loadCSSJS();
	}

	public override void onBeforeUpdate(Map<Id,SObject> existingrecords){
		loadCSSJS();
	}

	//for every site, put the CSS and JS information taking into account the static resources
	private static void loadCSSJS(){
		//query all static resources whose name starts with FieloPlugin_
		List<StaticResource> resourceList = [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name Like 'FieloPlugin_%'];

		List<FieloCMS__Site__c> sites = new FieloCMSPLT_SitesSelector(new Set<String>{'Id'}).selectAll();
		//limpio
		for(FieloCMS__Site__c site : sites){
			site.FieloCMS__PluginCSS__c = '';
			site.FieloCMS__PluginJS__c = '';
		}

		for(FieloCMS__Site__c site : sites){
			for(StaticResource sr : resourceList){
				String urlSR = getResourceURL(sr);
				site.FieloCMS__PluginCSS__c += urlSR + '\n';
				site.FieloCMS__PluginJS__c += urlSR + '\n';		
			}
		}
		FieloCMSPLT_SObjectUnitOfWork uow = new FieloCMSPLT_SObjectUnitOfWork(new List<Schema.SobjectType>{FieloCMS__Site__c.SObjectType});
		uow.registerDirty(sites);
		uow.commitWork();
	}

	// Pass the resource name
	public static String getResourceURL(StaticResource resource){

		// Getting namespace
		String namespace = resource.NamespacePrefix;
		// Resource URL
		return '/resource/' + resource.SystemModStamp.getTime() + '/' + (String.isNotBlank(namespace) ? namespace + '__' : '') + resource.Name; 
	}

	public class Constructor implements FieloCMSPLT_SObjectDomain.IConstructable{
		
		public FieloCMSPLT_SObjectDomain construct(List<SObject> sObjectList){
			return new FieloCMSPLT_Plugins(sObjectList);
		}
	}	
}