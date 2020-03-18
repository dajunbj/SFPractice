public with sharing class A01_StoreMonthlySalesControl {
	public A01_StoreMonthlySalesControl() {

	}
	//販売店名
	public string inputStoreName { get; set; }
	//年月日
	public string inputMonth { get; set; }

	/** 選択値 */
	public String pickedStatus { get; set; }
	/** 選択オプション取得 */
	public List<SelectOption> getStatusList() {

		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('', ''));
		options.add(new SelectOption('未申請', '未申請'));
		options.add(new SelectOption('申請中', '申請中'));
		options.add(new SelectOption('承認済', '承認済'));
		return options;
	}
	//画面明細リストオブジェクト
	public list<A01_MonthlySales__c> searchResultList { get; set; }

	/**
	 * search 検索ボタンをクリックする
	 *
	 * @@ Return PageReference: Return 販売店売上一覧画面へ遷移
	 */
	public PageReference search() {

		ssc = new ApexPages.StandardSetController(Database.getQueryLocator(getSearchSql()));
		ssc.setPageSize(5);

		searchResultList = searchObjects(1);

		return null;
	}

	public Integer totalpage { get; set; }
	public ApexPages.StandardSetController ssc { get; set; }
	// 最初のページへ
	public void first() {
		ssc.first();
		searchResultList = searchObjects(ssc.getPageNumber());
	}
	// 前のページへ
	public void previous() {
		ssc.previous();
		searchResultList = searchObjects(ssc.getPageNumber());
	}
	// 次のページへ
	public void next() {
		ssc.next();
		searchResultList = searchObjects(ssc.getPageNumber());
	}
	// 最後のページへ
	public void last() {
		ssc.last();
		searchResultList = searchObjects(totalpage);
	}

	/* 検索を実施する */
	private list<A01_MonthlySales__c> searchObjects(integer pageCount) {

		integer startOffset =(pageCount - 1) * ssc.getPageSize();
		string sql = getSearchSql();
		//ページング条件設定
		sql += ' limit ' + ssc.getPageSize() + ' offset ' + startOffset;

		system.debug('SQLXXXXX' + sql);
		list<A01_MonthlySales__c> retList =(list<A01_MonthlySales__c>) Database.query(sql);

		totalpage = getPageCount(ssc.getResultSize(), ssc.getPageSize());


		return retList;
	}

	/* 検索SQLファイル作成 */
	private string getSearchSql() {
		string sql = 'select Id, StoreNoMonthly__c, StoreR__c, Monthly__c, MonthlySales__c, '
		+ 'MonthlyExpense__c, MonthlyCost__c, ApprovalStatus__c, Authorizer__c,'
		+ 'StoreR__r.StoreNo__c,StoreR__r.StoreName__c from A01_MonthlySales__c where Id != null ';

		if(string.isNotEmpty(inputMonth)) {
			sql += ' and Monthly__c = ' + '\'' + inputMonth + '\'';
		}
		if(string.isNotEmpty(pickedStatus)) {
			sql += ' and ApprovalStatus__c = ' + '\'' + pickedStatus + '\'';
		}
		sql += ' order by Monthly__c';
		return sql;
	}
	/**
	 * getPageCount ページ総件数の算出
	 *
	 * ## recordCounts (integer): recordCounts レコード件数}
	 * ## pageSize (integer): pageSize ページ毎のレコード件数}
	 * @@ Return integer: Return ページ件数
	 */
	private integer getPageCount(integer recordCounts, integer pageSize) {
		//総頁数
		integer pageCount = recordCounts / pageSize;
		//余りを算出する
		integer pageMod = math.mod(recordCounts, pageSize);

		if(pageMod > 0) {
			//余りがある場合、頁数に1を加算する
			pageCount ++;
		}
		return pageCount;
	}
	/* PDFファイル出力 */
	public Pagereference printPdf() {

		PageReference pdfPage = new PageReference('/apex/A01_StoreMonthlySalesPdf' + getUrlParam());
		pdfPage.setRedirect(false);

		return pdfPage;
	}
	/* CSVファイル出力 */
	public Pagereference printCsv() {

		PageReference csvPage = new PageReference('/apex/A01_StoreMonthlySalesCsv' + getUrlParam());
		csvPage.setRedirect(false);

		return csvPage;
	}

	private string getUrlParam() {
		string urlStoreName = '';
		string urlMonth = '';
		string urlStatus = '';
		if(string.isNotEmpty(inputStoreName)) {
			urlStoreName = inputStoreName;
		}
		if(string.isNotEmpty(inputMonth)) {
			urlMonth = inputMonth;
		}
		if(string.isNotEmpty(pickedStatus)) {
			urlStatus = pickedStatus;
		}

		return '?paramStoreName=' + urlStoreName + '&paramMonth=' + urlMonth + '&paramStatus=' + urlStatus;
	}
}