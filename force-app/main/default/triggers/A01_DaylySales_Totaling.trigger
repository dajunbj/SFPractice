trigger A01_DaylySales_Totaling on A01_DaylySales__c (before insert,before update, after insert,after update) {

    if (Trigger.isUpdate) {
        //更新の場合
        if (Trigger.isBefore) {
            //登録前
            A01_DaylySales_TotalingHandler.checkItemValue(Trigger.new);
        }
        if (Trigger.isAfter) {
            //金額計算を行った上で、月次売上を更新する
            A01_DaylySales_TotalingHandler.calculationPriceForUpdate(Trigger.new);
        }
    }
}