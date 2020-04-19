public class A01_StoreMonthlySalesDetailControl {
	//【申請】ボタン
	public boolean btnApplyFlg {get;set;}
	//【承認・否認】ボタン
	public boolean btnApproveFlg {get;set;}
	public string selStoreName { get; set; }
	public string selMonthly { get; set; }

	//画面明細リストオブジェクト
	public list<A01_DaylySales__c> searchResultList { get; set; }
	public A01_StoreMonthlySalesDetailControl() {
		selStoreName =(string) ApexPages.currentPage().getParameters().get('inputStoreName');
		selMonthly =(string) ApexPages.currentPage().getParameters().get('inputMonthly');

		string sql = 'select Id, StoreR__r.StoreName__c,' +
		'Day__c,' +
		'Sales__c,' +
		'Cost__c,' +
		'Profit__c,' +
		'CostHydroelectric__c,' +
		'CostSalary__c,' +
		'CostRental__c ' +
		'from A01_DaylySales__c ' +
		'where StoreR__r.StoreName__c = \'' + selStoreName + '\'' +
		' and Day__c like \'' + selMonthly + '%\'';
		system.debug('XXXXX' + sql);
		searchResultList = Database.query(sql);

		if(searchResultList.size() == 0) {
			//申請ボタンの非活性
			btnApplyFlg = false;
			//承認・否認ボタンの非活性
			btnApproveFlg = false;
			loadCsvFlg= 'true';
		} else {
			//申請ボタンの非活性
			btnApplyFlg = false;
			//承認・否認ボタンの非活性
			btnApproveFlg = true;
			loadCsvFlg= 'false';
		}

		getLoadFiles();
	}

	/*申請 */
	public Pagereference doRequest() {
		update searchResultList;
		return null;
	}

	/*承認 */
	public Pagereference doApproval() {
		return null;
	}

	/*否認 */
	public Pagereference doDenial() {
		return null;
	}

	public string fileName { get; set; }
	public Blob fileBody { get; set; }
	public List<Attachment> fileList { get; set; }

	public string loadCsvFlg { get; set; }
	private string [] itmsVal { get; set; }
	/* CSVファイル出力 */
	public Pagereference loadCsv() {
		Attachment att = new Attachment();
		att.Body = fileBody;
		att.Name = fileName;

		//att.ParentId = searchResultList.get(0).Id;
		//insert att;

		string fileContent = fileBody.toString();
		itmsVal = fileContent.split('n');
		List<A01_DaylySales__c> insList = new List<A01_DaylySales__c>();
		integer count = 0;
		for (string rowVal :itmsVal) {
			count ++;
			system.debug('XXXXX' + rowVal);
			string[] vals = rowVal.split(',');
			for (string val :vals) {
				/*
				 A01_DaylySales__c rec = new A01_DaylySales__c();

				 rec.name = 'TestData' + count;
				 rec.StoreNoDay__c = '1001_20191027';
				 rec.StoreR__c = '1';
				 rec.Day__c = '2';
				 rec.Sales__c = 3;
				 rec.Cost__c = 4;
				 rec.Profit__c = 5;
				 rec.CostHydroelectric__c = 6;
				 rec.CostSalary__c = 7;
				 rec.CostRental__c = 8;

				 insList.add(rec);
				 */
			}
		}
		/*
		 insert insList;
		 */

		getLoadFiles();
		att = null;
		return null;
	}
	private void getLoadFiles() {
		fileList = [select Id, Name, ParentId from Attachment];
	}
}