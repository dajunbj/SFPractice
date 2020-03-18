public class A01_StoreMonthlySalesPdfControl {
	public list<A01_MonthlySales__c> pdfList { get; set; }
	ApexPages.StandardSetController controller { get; set; }
	//引数・店名
	public string paramStoreName { get; set; }
	//引数・年月
	public string paramMonth { get; set; }
	//引数・承認ステータス
	public string paramStatus { get; set; }
	//ファイル名
	public string filename { get; set; }

	public Pagereference execute() {
		system.debug('XXXXfunck');
		string param1 = ApexPages.currentPage().getParameters().get('paramStoreName');
		//年月
		string param2 = ApexPages.currentPage().getParameters().get('paramMonth');
		//承認ステータス
		string param3 = ApexPages.currentPage().getParameters().get('paramStatus');

		string sql = getSearchSql(param1, param2, param3);

		//ページング条件設定
		pdfList =(list<A01_MonthlySales__c>) Database.query(sql);
		
		filename = 'PDF_Sample';
		//ヘッダ情報設定
		return null;
	}

	/* 検索SQLファイル作成 */
	private string getSearchSql(string inputStoreNm, string inputMonth, string pickedStatus) {

		string sql = 'select Id, StoreR__r.StoreName__c ,Monthly__c, MonthlySales__c, MonthlyExpense__c, MonthlyCost__c, ApprovalStatus__c from A01_MonthlySales__c where Id != null ';

		if(inputMonth != null && string.isNotEmpty(inputMonth)) {
			sql += ' and Monthly__c = ' + '\'' + inputMonth + '\'';
		}
		
		if(pickedStatus != null && string.isNotEmpty(pickedStatus)) {
			sql += ' and ApprovalStatus__c = ' + '\'' + pickedStatus + '\'';
		}
		sql += ' order by Monthly__c';
		return sql;
	}
}