public with sharing class A01_Store_ClassicController {

    //店名
    public string selStoreName {get;set;}

    //都道府県
    public String prefectureNameSel {get;set;}
    public list<SelectOption> prefectureNameList {
        get{
            list<A01_Prefecture__c> prefectureNameList = [select Id,PrefectureNo__c	,PrefectureName__c from A01_Prefecture__c];
            List<SelectOption> options = new List<SelectOption>();
            for (A01_Prefecture__c rec : prefectureNameList) {
                options.add(new SelectOption(string.valueof(rec.PrefectureNo__c),rec.PrefectureName__c));
            }
            return options;
        }
    }

    public list<A01_Store__c> dataList {get;set;}

    public A01_Store_ClassicController() {
    }
    
    /**
     * 販売店一覧画面 検索
     */
    public Pagereference doSearch() {
        //情報取得
        dataList = getStoreInfoList();

        return null;
    }

    public list<A01_MonthlySales__c> outputList {get;set;}
    /**
     * CSV出力(指定販売店の月次売上情報)
     */
    public Pagereference doCsv() {
        
        outputList = getMonthlySalesInfoList();

        return Page.A01_Store_ClassicCsvPage.setRedirect(false);
    }

    /**
     * PDF出力(指定販売店の月次売上情報)
     */
    public Pagereference doPdf() {

        outputList = getMonthlySalesInfoList();

        System.PageReference pageRef = new System.PageReference('/apex/A01_Store_ClassicPdfPage');
        pageRef.getHeaders().put('content-disposition', 'attachment; filename=output.pdf');

        return pageRef;
    }

    /**
     *　販売店情報取得
     */
    private list<A01_Store__c> getStoreInfoList(){
        string queryString = 'select Id,StoreName__c,StoreNo__c,StoreManager__c,PrefectureR__r.PrefectureName__c from A01_Store__c';
        string paramString ='';

        if (string.isNotBlank(selStoreName)) {
            paramString += ' WHERE StoreName__c like ' + '\'%'+selStoreName + '%\'';
        }
        
        
        if (string.isNotBlank(prefectureNameSel)) {

            decimal param = Decimal.valueof(prefectureNameSel);

            list<A01_Prefecture__c> optList = [select Id,PrefectureNo__c,PrefectureName__c from A01_Prefecture__c where PrefectureNo__c=:param];

            string preName = optList.get(0).PrefectureName__c;
            if (string.isblank(paramString)) {
                paramString += ' WHERE PrefectureR__r.PrefectureName__c = ' + '\'' + preName + '\'';
            } else {
                paramString += ' AND PrefectureR__r.PrefectureName__c = ' + '\'' + preName + '\'';
            }
        }

        return System.Database.query(queryString + paramString);
    }

    //合計Bean
    public A01_Store_ClassicTotalizationBean totalBean {get;set;}

    public string pdfDate {get;set;}
      /**
       *　月次売上情報取得
       */
    private list<A01_MonthlySales__c> getMonthlySalesInfoList(){

        string queryString = 'select StoreR__r.StoreName__c,Monthly__c,MonthlySales__c,MonthlyCost__c,MonthlyExpense__c from A01_MonthlySales__c';
        string paramString ='';

        if (string.isNotBlank(selStoreName)) {
            paramString += ' WHERE StoreR__r.StoreName__c like ' + '\'%'+selStoreName + '%\'';
        }
 
        list<A01_MonthlySales__c> retList =  System.Database.query(queryString + paramString + ' order by StoreR__r.StoreName__c ASC,Monthly__c ASC');

        Decimal monthlyCost = 0;
        Decimal monthlyExpense = 0;
        Decimal monthlySales = 0;

        for (A01_MonthlySales__c rec:retList) {
            monthlyCost += rec.MonthlyCost__c;
            monthlyExpense += rec.MonthlyExpense__c;
            monthlySales += rec.MonthlySales__c;
        }

        if (retList.size() > 0) {
            totalBean = new A01_Store_ClassicTotalizationBean();
            //合計算出
            totalBean.MonthlyCost = monthlyCost;
            totalBean.MonthlyExpense = monthlyExpense;
            totalBean.MonthlySales = monthlySales;
        }   
    Datetime dt = Datetime.newInstance(2020, 3, 3);
    pdfDate = string.valueOf(dt);
    return retList;
}

    
    public integer pageNow {get;set;}
    public integer pageCount {get;set;}

    public List<SelectOption> getPageCountList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('5','5'));
        options.add(new SelectOption('10','10'));
        options.add(new SelectOption('20','20'));
        return options;
    }
        
    /**
     * 前頁
     */
    public Pagereference preRecord() {

        return null;
    }

    /**
     * 次頁
     */
    public Pagereference nextRecord() {
        return null;
    }
}