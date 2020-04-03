@isTest
public class A01_DaylySales_Totalization_BatTest {
    static testMethod void testGetDaylySalesListInfo001(){
        insertData('大崎支店');

        A01_DaylySales_Totalization_Bat bat = new A01_DaylySales_Totalization_Bat(); 
        string retMessage = bat.main(true,'大崎支店');


        //登録結果の抽出
        list<A01_MonthlySales__c> exceptedList = [select Id,Name,StoreR__r.Name,MonthlySales__c from A01_MonthlySales__c];
        A01_MonthlySales__c exceptedData = exceptedList.get(0);


        //登録結果と予想値の確認
        system.assertEquals('登録が成功しました。', retMessage);
        system.assertEquals(300, exceptedData.MonthlySales__c);
        system.assertEquals('大崎支店', exceptedData.StoreR__r.Name);
    }

    static testMethod void testGetDaylySalesListInfo002(){
        insertData('大崎支店');

        A01_DaylySales_Totalization_Bat bat = new A01_DaylySales_Totalization_Bat(); 
        string retMessage = bat.main(false,'大崎支店');

        list<A01_MonthlySales__c> exceptedList = [select Id,Name,StoreR__r.Name,MonthlySales__c from A01_MonthlySales__c];

        system.assertEquals('1日ではないので、実施できません。', retMessage);
        system.assertEquals(0, exceptedList.size());
    }

    static testMethod void testGetDaylySalesListInfo003(){
        insertData('大阪支店');

        A01_DaylySales_Totalization_Bat bat = new A01_DaylySales_Totalization_Bat(); 
        string retMessage = bat.main(true,'大崎支店');

        list<A01_MonthlySales__c> exceptedList = [select Id,Name,StoreR__r.Name,MonthlySales__c from A01_MonthlySales__c];

        system.assertEquals('検索結果はありません。', retMessage);
        system.assertEquals(0, exceptedList.size());
    }

    private static void insertData(string name) {
        A01_Store__c store = new A01_Store__c();
        store.name = name;
        store.StoreNo__c = '1001';
        
        store.StoreName__c = name;
        store.Address__c = '大崎駅';
        store.PostalCode__c = '212-0055';
        insert store;

        list<A01_DaylySales__c> insList = new list<A01_DaylySales__c>(); 
        A01_DaylySales__c dayInfo = new A01_DaylySales__c();
        integer index = 0;
        while (index < 3) {
            index ++;
            dayInfo = new A01_DaylySales__c();
            dayInfo.Name = name;
            dayInfo.StoreR__c = store.Id;
            dayInfo.Day__c = system.today().addDays(index);
            dayInfo.Sales__c = 100;
            dayInfo.CostSalary__c = 100;
            dayInfo.CostHydroelectric__c = 100;
            dayInfo.CostRental__c = 100;
            dayInfo.Profit__c = 100;
            insList.add(dayInfo);
        }
        insert insList;

    }
}