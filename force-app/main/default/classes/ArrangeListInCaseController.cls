public with sharing class ArrangeListInCaseController {

    /**内部データクラス*/
    public class ArrangeTableData{
        @AuraEnabled
        public List<Arrange__c> arrangeDataList;
        public Map<String,String> arrangeDataMap;

        public ArrangeTableData(List<Arrange__c> arrangeDataListSub){
            this.arrangeDataList = arrangeDataListSub;
            Map<String, String> arrangeDataMapSub = new Map<String, String>();
            for (Schema.SObjectField fieldInfo:Schema.getGlobalDescribe().get('Arrange__c').getDescribe().fields.getMap().values()) {
                arrangeDataMapSub.put(fieldInfo.getDescribe().getName(),fieldInfo.getDescribe().getLabel());
            }
            this.arrangeDataMap = arrangeDataMapSub;
        }
    }
    //画面手配リストデータ検索/
    @AuraEnabled
    public static ArrangeTableData initArrangeList(Id recordId){
        return new ArrangeTableData(getArrangeList(recordId));
    }
    public static List<Arrange__c> getArrangeList(Id parentId){
        return new List<Arrange__c> ([
            select Id ,Name 
              from Arrange__c 
             where Id =: parentId
            order by Name
        ]);
    }
}