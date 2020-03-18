public class A01_StoreMonthlySalesCsvControl {
	//CSVデータ
	public list<string> csvList { get; set; }
	ApexPages.StandardSetController controller { get; set; }
	//引数・店名
	public string paramStoreName { get; set; }
	//引数・年月
	public string paramMonth { get; set; }
	//引数・承認ステータス
	public string paramStatus { get; set; }
	//ファイル名
	public string csvFileName { get; set; }

	public Pagereference execute() {
		//店名
		string param1 = ApexPages.currentPage().getParameters().get('paramStoreName');
		//年月
		string param2 = ApexPages.currentPage().getParameters().get('paramMonth');
		//承認ステータス
		string param3 = ApexPages.currentPage().getParameters().get('paramStatus');

		csvList = new list<string>();
		//CSVデータ取得のSqlを作成する

		string sql = getSearchSql(param1, param2, param3);

		//ページング条件設定
		list<A01_MonthlySales__c> retList =(list<A01_MonthlySales__c>) Database.query(sql);
		//ヘッダ情報設定
		csvList.add('店名,年月,月次売上,月次費用,月次原価,承認ステータス' + '\n');
		for (A01_MonthlySales__c rec :retList) {
			String line = rec.StoreR__r.StoreName__c + ','
			+ rec.Monthly__c + ','
			+ rec.MonthlySales__c + ','
			+ rec.MonthlyExpense__c + ','
			+ rec.MonthlyCost__c + ','
			+ rec.ApprovalStatus__c + '\n';
			csvList.add(line);
		}
		csvFileName = 'CSV_Sample';
		return null;
	}

	/* 検索SQLファイル作成 */
	private string getSearchSql(string inputStoreNm, string inputMonth, string pickedStatus) {

		string sql = 'select Id, StoreR__r.StoreName__c ,Monthly__c, MonthlySales__c, MonthlyExpense__c, MonthlyCost__c, ApprovalStatus__c from A01_MonthlySales__c where Id != null ';

		if(string.isNotBlank(inputMonth)) {
			sql += ' and Monthly__c = ' + '\'' + inputMonth + '\'';
		}
		
		if(string.isNotBlank(pickedStatus)) {
			sql += ' and ApprovalStatus__c = ' + '\'' + pickedStatus + '\'';
		}
		sql += ' order by Monthly__c';

		return sql;
	}

}