public with sharing class FieloCMSPLT_ContactService{

    public static List<Contact> getUnregisteredContacts(Id accountId, Integer offset, Integer quantity, String orderBy){       
        String query = String.format(
                'select {0} ' +
                  'from Contact ' +
                  'where AccountId =: accountId ',
                new List<String> {'Id, Name'});

        if(orderBy != null){
            query += ' ORDER BY ' + orderBy;
        }

        if(quantity != null){
            query += ' LIMIT ' + String.valueOf(quantity);
        }

        if(offset != null){
            query += ' OFFSET ' + String.valueOf(offset);
        }

        return (List<Contact>) Database.query(query);
    }

}