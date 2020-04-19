@isTest
public class A01_DaylySales_TotalingHandlerTest {

    /** 正常パターン①*/
    @isTest static void testCheckItemValue_Normal_01() {
        System.Test.startTest();
        //データ作成
        createDataNormal();
        System.Test.stopTest();
        //テスト結果確認
        list<A01_DaylySales__c> retList = [select Id,name,CalculationStatus__c,Sales__c,Day__c,CostSalary__c  from A01_DaylySales__c];
        
        system.assertEquals('テスト名前', retList.get(0).name);
        system.assertEquals('集計済', retList.get(0).CalculationStatus__c);
        
    }

    /** 異常パターン1*/
    @isTest static void testCheckItemValue_Error_01() {
        string mess = '';
        //データ作成
        try {
            createDataError01();
        } catch(DmlException e) {
            mess = e.getDmlMessage(0);
        }
        system.assertEquals('日次売上・売上に金額をご記入ください。', mess);
    }
    /** 異常パターン2*/
    @isTest static void testCheckItemValue_Error_02() {
        System.Test.startTest();
        string mess = '';
        //データ作成
        try {
            createDataError02();
        } catch(DmlException e) {
            mess = e.getDmlMessage(0);
        }
        system.assertEquals('年月日はすでに登録されましたので、年月日をご変更ください。', mess);
    }
    //テストデータ準備(正常)
    private static void createDataNormal() {
        A01_DaylySales__c obj = new A01_DaylySales__c();
        obj.name = 'テスト名前';
        obj.Day__c = system.today();
        obj.CalculationStatus__c = '未集計';
        obj.Sales__c = 1000;
        insert obj;
    }
    //テストデータ準備(異常1)
    private static void createDataError01() {
        A01_DaylySales__c obj = new A01_DaylySales__c();
        obj.name = 'テスト名前';
        obj.Day__c = system.today();
        obj.CalculationStatus__c = '未集計';
        //obj.Sales__c = 1000;
        insert obj;
    }
    //テストデータ準備(異常2)
    private static void createDataError02() {
        A01_Store__c store = new A01_Store__c();
        store.Name = '大崎支店';
        store.StoreNo__c = '1001';
        store.StoreName__c = '大崎支店';
        store.StoreLevel__c = '一般店舗';
        store.Address__c = '大崎駅';
        store.PostalCode__c = '2120001';
        insert store;

        
        A01_DaylySales__c obj1 = new A01_DaylySales__c();
        obj1.name = 'テスト名前';
        obj1.Day__c = system.today();
        obj1.CalculationStatus__c = '未集計';
        obj1.Sales__c = 1000;
        obj1.StoreR__c = store.Id;
        insert obj1;
        A01_DaylySales__c obj2 = new A01_DaylySales__c();
        obj2.name = 'テスト名前';
        obj2.Day__c = system.today();
        obj2.CalculationStatus__c = '未集計';
        obj2.Sales__c = 1000;
        obj2.StoreR__c = store.Id;
        insert obj2;
    }


}
