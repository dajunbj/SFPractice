public class A01_CSVCreator {
 private static List<String> separateCommas(String input){
        List<String> results = input.split(',');

        for(String result : results) {
            result = result.trim();
        }

        return results;
    }

    @AuraEnabled
    public static List<String> dlCsvFileHelper(String csv_str) {
        //■CSVダウンロード
        //ヘッダ項目を追加する
        List<string> retList = new List<string>();
        retList.add('\'販売店\',\'年月\',\'売上\'');

        List<A01_MonthlySales__c> lst = [select Name,Monthly__c,MonthlySales__c from A01_MonthlySales__c];
 		//Handling fields with commas
        for(A01_MonthlySales__c rec : lst) {
            retList.add('\'' + rec.Name + '\',' +  '\'' + rec.Monthly__c + '\','+  '\'' + rec.MonthlySales__c + '\'');
        }
        return retList;
    }

    @AuraEnabled
    public static void uploadCsvData(String csv_str) {
        //■CSVアップロード(取込)
        system.debug(csv_str);
        string[] csvRecs = csv_str.split('\n');
        string[] itemVals = null;
        Integer recCount = 0;
        for (string vals : csvRecs) {
            //if (recCount > 0) {
                itemVals = vals.split(',');
                system.debug('----------------------------------');
                for (string val : itemVals) {
                    system.debug('XXX:'+val);
                }
            //}
            recCount += 1;
        }
    }

    public Pagereference dlPdfFileHelper(String csv_str){
        //■PDFダウンロード    
        //PDFページへ遷移
        system.Pagereference pageRef = new System.Pagereference('/apex/A01_MonthlySalesPdfPage');
        //PDF属性設定
        pageRef.getHeaders().put('content-disposition','attachment;filename=TestPdf.pdf');

        return pageRef;
    }

}