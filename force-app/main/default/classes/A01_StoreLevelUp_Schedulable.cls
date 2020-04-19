global class A01_StoreLevelUp_Schedulable implements Schedulable {
    global void execute(SchedulableContext ctx) {
        date sysDate = system.today();

        system.debug('システム日付：'+sysDate);
        if (sysDate.day() == 1) {
            //1日の場合、先月の売り上げにより、全部店舗のラベルを調整する
            doSomething();
        }
    }
    private void doSomething() {
        //営業中の店舗を検索する
        list<A01_Store__c> storeList = [select Id,StoreLevel__c,StoreNo__c from A01_Store__c where OpenStatus__c = '営業中'];

        list<string> storeIds = new list<string>();
        for(A01_Store__c rec : storeList) {
            storeIds.add(rec.Id);
        }
        
        
        date sysDate = system.today();
        //1か月前の1日
        date monthlyDate = sysDate.addMonths(-1);
        //月次売上の情報を検索する
        list<A01_MonthlySales__c> monthlySalesList = [select Id,StoreR__r.StoreNo__c,MonthlySales__c from A01_MonthlySales__c where StoreR__r.Id in :storeIds and Monthly__c = :monthlyDate];
        

        Map<String,Decimal> storeSalesMap = new Map<String,Decimal>();
        for (A01_MonthlySales__c rec : monthlySalesList) {
            //各店舗の月次売上をMapに保存する
            storeSalesMap.put(rec.StoreR__r.StoreNo__c, rec.MonthlySales__c);
        }

        Set<string> keyVals = storeSalesMap.keySet();
        Decimal salesVal = 0;
        for(A01_Store__c rec : storeList) {
            if (keyVals.contains(rec.StoreNo__c)) {
                salesVal = storeSalesMap.get(rec.StoreNo__c);
                if (salesVal <= 100000) {
                    rec.StoreLevel__c = '一般店舗';
                } else if (salesVal > 100000 && salesVal <= 500000) {
                    rec.StoreLevel__c = '中級店舗';
                } else {
                    rec.StoreLevel__c = '上級店舗';
                }
            }
        }
        update storeList;
    }
}