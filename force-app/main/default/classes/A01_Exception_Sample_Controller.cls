public class A01_Exception_Sample_Controller {

    /**異常：NullPointerException*/
    public static void tryNullPointerException() {
        string val = null;
        try {
            system.debug('XXXXXX001');
            val.split('x');
        } catch(System.DmlException e) {
            system.debug('XXXXXX001'+e);
            throw e;
        }
    }

    /**異常：DmlException*/
    public static void tryDmlException() {
        try {
            A01_Store__c store = new A01_Store__c();
            //store.Name = '大崎支店';
            //store.StoreNo__c = '1001';
            //store.StoreName__c = '大崎支店';
            store.StoreLevel__c = '一般店舗';
            store.Address__c = '大崎駅';
            store.PostalCode__c = '2120001';
            system.debug('XXXXXX002');
            insert store;
        } catch (System.DmlException e) {
            system.debug('XXXXXX002'+e);
            throw e;
        }
    }

    /**異常：ListException*/
    public static void tryListException() {
        try {
            List<String> lst = new List<String>();
            lst.add('文字列１');

            system.debug('XXXXXX003');
            system.debug(lst.get(2));
        } catch (System.DmlException e) {
            system.debug('XXXXXX003'+e);
            throw e;
        }
    }
 
    
}