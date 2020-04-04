trigger A01_DaylySales_Totaling on A01_DaylySales__c (before insert,after insert,before update, after update) {

    if (Trigger.isUpdate || Trigger.isInsert) {
        //更新の場合
        if (Trigger.isBefore) {
            //登録前
            A01_DaylySales_TotalingHandler.checkItemValue(Trigger.new,Trigger.isInsert);
        }
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                //金額計算を行った上で、月次売上を更新する
                A01_DaylySales_TotalingHandler.calculationPriceForUpdate(Trigger.new);
            }
            if (Trigger.isUpdate) {
                //金額計算を行った上で、月次売上を更新する
                A01_DaylySales_TotalingHandler.calculationPriceForUpdate(Trigger.new,Trigger.old);
            }
        }
    }
}