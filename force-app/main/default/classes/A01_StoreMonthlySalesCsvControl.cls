public class A01_StoreMonthlySalesCsvControl {
	//CSVデータ
	public list<A01_MonthlySales__c> csvList { get; set; }
	
	//ファイル名
	public string csvFileName { get; set; }

	//一覧画面の引数：店名
	public string csvParamsStoreName { get; set; }
	public string csvParamsMonth { get; set; }
	public string csvParamsPickedStatus { get; set; }

	public Pagereference initCsv() {
		
		//CSVデータ取得のSqlを作成する
		system.debug('1XXXXX'+csvParamsStoreName);
		system.debug('2XXXXX'+csvParamsMonth);
		system.debug('3XXXXX'+csvParamsPickedStatus);
		
		string sql = getSearchSql(csvParamsStoreName, csvParamsMonth, csvParamsPickedStatus);
		csvList = [select Id, StoreR__r.StoreName__c,Monthly__c,MonthlySales__c,MonthlyCost__c,MonthlyExpense__c from A01_MonthlySales__c where Id != null limit 1000];
 		csvFileName = 'CSV_Sample';
		return null;
	}

	/* 検索SQLファイル作成 */
	private string getSearchSql(string inputStoreNm, string inputMonth, string pickedStatus) {

		string sql = 'select Id, StoreR__r.StoreName__c ,Monthly__c, MonthlySales__c, MonthlyExpense__c, MonthlyCost__c, ApprovalStatus__c from A01_MonthlySales__c where Id != null limit 10';

		if(string.isNotBlank(inputMonth)) {
			sql += ' and Monthly__c = ' + '\'' + inputMonth + '\'';
		}
		
		if(string.isNotBlank(pickedStatus)) {
			//sql += ' and ApprovalStatus__c = ' + '\'' + pickedStatus + '\'';
		}
		//sql += ' order by Monthly__c';

		return sql;
	}

}