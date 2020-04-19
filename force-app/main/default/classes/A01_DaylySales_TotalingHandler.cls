public class A01_DaylySales_TotalingHandler {

    public static void checkItemValue(A01_DaylySales__c[] arr, boolean isInsertFlg) {
        date ymd = arr[0].Day__c;

        for (A01_DaylySales__c obj : arr) {
            //月次の売上の必須入力チェック
            if (obj.Sales__c == null) {
                obj.Sales__c.addError('日次売上・売上に金額をご記入ください。');
            }
        }

        if (isInsertFlg) {
            //新規登録の場合、同じの年月日が存在すれば、エラーとなります。
            list<A01_DaylySales__c> retList = [select Id,Name,StoreR__r.Id from A01_DaylySales__c where StoreR__c =:arr[0].StoreR__c and Day__c =: ymd];
 
            if (retList.size() > 0) {
                //年月日の存在チェック
                arr[0].Day__c.addError('年月日はすでに登録されましたので、年月日をご変更ください。');
            }
        }

        for (A01_DaylySales__c rec : arr) {
            //TriggerのBeforeにはTrigger.New or Trigger.Oldを直接に更新できません。
            rec.CalculationStatus__c = '集計済';
            rec.CostSalary__c = 2000;
        }
    }

    //-------------------更新
    /**
     * 日次売上が新規登録される場合
     */
    public static void calculationPriceForInsert(A01_DaylySales__c[] arrNew){

        //月次集計年月日の算出
        Date inputDt = getMonthlyFirstDay(arrNew[0]);

        list<A01_MonthlySales__c> monthlyList = [select Id,MonthlySales__c,StoreR__r.Id,Monthly__c from A01_MonthlySales__c where StoreR__c = :arrNew[0].StoreR__c and Monthly__c = :inputDt];

        A01_MonthlySales__c obj = null;
        if (monthlyList.size() == 0) {
            //新規登録
            insert setMonthlyDataInfoForInsert(arrNew,inputDt);
        } else {
            //更新
            update setMonthlyDataInfoForUpdate(monthlyList,arrNew,null);
        }
        
 
    }

    /**
     * 日次売上が更新される場合
     */
    public static void calculationPriceForUpdate(A01_DaylySales__c[] arrNew,A01_DaylySales__c[] arrOld) {
        //月次集計年月日の算出
        Date inputDt = getMonthlyFirstDay(arrNew[0]);

        list<A01_MonthlySales__c> monthlyList = [select Id,MonthlySales__c,StoreR__r.Id,Monthly__c from A01_MonthlySales__c where StoreR__c = :arrNew[0].StoreR__c and Monthly__c = :inputDt];
        A01_MonthlySales__c obj = null;
        if (monthlyList.size() == 0) {
            //新規登録
            insert setMonthlyDataInfoForInsert(arrNew,inputDt);
        } else {
            A01_MonthlySales__c resultForUpdate = setMonthlyDataInfoForUpdate(monthlyList,arrNew,arrOld);
            //更新
            update resultForUpdate;
        }
 
    }
    
    private static Date getMonthlyFirstDay(A01_DaylySales__c newDaylyInfo) {
        Date dt = newDaylyInfo.Day__c;
        Integer saleYear = dt.year();
        Integer saleMonth = dt.month();
        Integer saleDay = 1;
        return Date.newInstance(saleYear, saleMonth, saleDay);
    }

    private static A01_MonthlySales__c setMonthlyDataInfoForInsert(A01_DaylySales__c[] arrNew,Date inputDt) {
        A01_MonthlySales__c retObj = new A01_MonthlySales__c();
        retObj.Name = string.valueof(arrNew[0].StoreR__c) + string.valueof(inputDt);
        retObj.StoreR__c = arrNew[0].StoreR__c;//販売店情報
        retObj.Monthly__c = inputDt;//月次集計年月日
        retObj.ApprovalStatus__c = '未申請';//承認ステータス
        retObj.MonthlySales__c = arrNew[0].Sales__c;//月次売上
        return retObj;
    }

    private static A01_MonthlySales__c setMonthlyDataInfoForUpdate(list<A01_MonthlySales__c> monthlyDataList,A01_DaylySales__c[] arrNew,A01_DaylySales__c[] arrOld) {

        A01_MonthlySales__c retObj = monthlyDataList.get(0);
        //売上の合計を設定する
        if (arrOld == null) {
            retObj.MonthlySales__c += arrNew[0].Sales__c;//月次売上
        } else {
            retObj.MonthlySales__c += arrNew[0].Sales__c - arrOld[0].Sales__c;//月次売上
        }

        return retObj;
    }


}