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

    /** 異常パターン①*/
    @isTest static void testCheckItemValue_Error_01() {
        System.Test.startTest();
        //データ作成
        try {
            createDataError();
        } catch(Exception e) {
            system.debug('XXXXX'+e.getMessage());
        }
        
    }
    //テストデータ準備
    private static void createDataNormal() {
        A01_DaylySales__c obj = new A01_DaylySales__c();
        obj.name = 'テスト名前';
        obj.Day__c = system.today();
        obj.CalculationStatus__c = '未集計';
        obj.Sales__c = 1000;
        insert obj;
    }
    //テストデータ準備
    private static void createDataError() {
        A01_DaylySales__c obj = new A01_DaylySales__c();
        obj.name = 'テスト名前';
        obj.Day__c = system.today();
        obj.CalculationStatus__c = '未集計';
        obj.Sales__c = 1000;
        insert obj;
    }


}