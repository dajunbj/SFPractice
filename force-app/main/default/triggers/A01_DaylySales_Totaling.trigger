trigger A01_DaylySales_Totaling on A01_DaylySales__c (before insert,before update, after insert,after update) {

    if (Trigger.isInsert) {
        //登録の場合
        if (Trigger.isBefore) {
            //登録前

        }
        if (Trigger.isAfter) {
            //登録後

        }
    }

    if (Trigger.isUpdate) {
        //更新の場合
        if (Trigger.isBefore) {
            //登録前

        }
        if (Trigger.isAfter) {
            //登録後

        }
    }
}