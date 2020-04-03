public class A01_DaylySales_TotalingHandler {

    public static void checkItemValue(A01_DaylySales__c[] arr) {
        for (A01_DaylySales__c obj : arr) {
            if (obj.Sales__c == null) {
                obj.Sales__c.addError('日次売上・売上に金額をご記入ください。');
            }

        }
    }

    public static void calculationPriceForUpdate(A01_DaylySales__c[] arr) {
        //日次売上の年月を取得する
        Integer saleYear = 0;
        Integer saleMonth = 0;
        Integer saleDay = 1;
        A01_DaylySales__c daylyObj = arr[0];
        Id inputId = daylyObj.StoreR__r.Id;

        //月次売上
        Decimal salesAmount = 0;

        //月次売上の更新
        for (A01_DaylySales__c obj : arr) {
            if (saleYear != 0) {
                Date dt = obj.Day__c;
                saleYear = dt.year();
                saleMonth = dt.month();
            }
            salesAmount += obj.Sales__c;
        }

        Date inputDt = Date.newInstance(saleYear, saleMonth, saleDay);
        List<A01_MonthlySales__c> monthlyList = [select Id,MonthlySales__c from A01_MonthlySales__c where StoreR__r.Id = :inputId and Monthly__c = :inputDt];
        system.debug('XXXXX'+monthlyList.size());
        A01_MonthlySales__c obj = null;

        if (monthlyList.size() == 0) {

            //新規登録
            obj = new A01_MonthlySales__c();
            obj.Name = string.valueof(inputId) + string.valueof(inputDt);
            obj.StoreR__c = inputId;//販売店情報
            obj.Monthly__c = system.Date.today();//月次集計年月日
            obj.ApprovalStatus__c = '未申請';//承認ステータス
            obj.MonthlySales__c = salesAmount;//月次売上

            insert obj;

        } else {

            //更新
            obj = monthlyList.get(0);
            //売上の合計を設定する
            obj.MonthlySales__c = salesAmount;//月次売上

            update obj;

        }
    }
}