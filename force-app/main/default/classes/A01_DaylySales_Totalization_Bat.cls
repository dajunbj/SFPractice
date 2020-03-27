public class A01_DaylySales_Totalization_Bat {
    public A01_DaylySales_Totalization_Bat() {}
    
    public string main(boolean flg,string storeName) {
        if (!flg) {
            return '1日ではないので、実施できません。';
        }
        //①販売店の日次売上を抽出する
        list<A01_DaylySales__c> retList = getDaylySalesListInfo(storeName);

        //②日次の情報を集計して、月次売上に登録する
        if (retList != null) {
            calculateMonthlySales(retList);
            return '登録が成功しました。';
        } else {
            return '検索結果はありません。';
        }
    }

    private list<A01_DaylySales__c> getDaylySalesListInfo(string storeName){
        list<A01_DaylySales__c> lst = 
            [select Id,Name,Day__c,StoreR__r.Id,StoreR__r.StoreNo__c,Sales__c,CostSalary__c,CostHydroelectric__c,CostRental__c,Profit__c from A01_DaylySales__c
            where StoreR__r.Name = :storeName];
        if (lst.size() > 0) {
            return lst;
        } else {
            return null;
        }
    }

    private void calculateMonthlySales(list<A01_DaylySales__c> daylyList){
        Decimal sales = 0;
        for (A01_DaylySales__c daylyRec : daylyList) {
            sales += daylyRec.Sales__c;  //A01_日次売上・売上
        }
        //月次売上の登録
        A01_MonthlySales__c insertData = new A01_MonthlySales__c();
        insertData.MonthlySales__c = sales;  //月次売上
        insertData.Monthly__c = string.valueof(system.Date.today()).replaceAll('-', '').left(6); //年月
        insertData.StoreR__c = daylyList.get(0).StoreR__r.Id;        //販売店情報
        insertData.StoreNoMonthly__c = daylyList.get(0).StoreR__r.StoreNo__c+'202003';//店番_年月
        insert insertData;
        
    }
}