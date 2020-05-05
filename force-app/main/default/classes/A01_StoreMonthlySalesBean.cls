/**
 * 販売店売上一覧面のBean 
 */
public with sharing class A01_StoreMonthlySalesBean {
    public A01_StoreMonthlySalesBean() {

    }
    public string recordId {get;set;}
    public string StoreName {get;set;}
    public string Monthly {get;set;}
    public Date MonthlyDay {get;set;}
    public Decimal MonthlySales {get;set;}
    public Decimal MonthlyExpense {get;set;}
    public Decimal MonthlyCost {get;set;}
    public string ApprovalStatus {get;set;}
    public string Authorizer {get;set;}

}
