public with sharing class ContactService {
	
	public List<Contact> getUnregisteredContacts(Id accountId, Integer offset, Integer quantity, String orderBy){
		return new ContactsSelector(new Set<String>(OrganizationUtil.getFieldSet(component.FieldSet__c))).selectByAccountAndWithoutMember(accountId, offset, component.Qant__c.intValue(), orderBy));
	}

}