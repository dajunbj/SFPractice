public class A01_StoreMonthlySalesCsvControl {
	//CSVデータ
	public list<A01_MonthlySales__c> csvList { get; set; }
	ApexPages.StandardSetController controller { get; set; }
	//引数・店名
	public string paramStoreName { get; set; }
	//引数・年月
	public string paramMonth { get; set; }
	//引数・承認ステータス
	public string paramStatus { get; set; }
	//ファイル名
	public string csvFileName { get; set; }

	public Pagereference initCsv() {
		//店名
		string param1 = ApexPages.currentPage().getParameters().get('paramStoreName');
		//年月
		string param2 = ApexPages.currentPage().getParameters().get('paramMonth');
		//承認ステータス
		string param3 = ApexPages.currentPage().getParameters().get('paramStatus');
		//CSVデータ取得のSqlを作成する
        system.debug('1XXXXX'+param1);
        system.debug('2XXXXX'+param2);
        system.debug('3XXXXX'+param3);
		string sql = getSearchSql(param1, param2, param3);
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