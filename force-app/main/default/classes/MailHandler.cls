global class MailHandler implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(
    Messaging.InboundEmail email, 
    Messaging.InboundEnvelope envelope) {
    System.debug('XXXXX Start');
    
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    system.debug('XXXXX'+email);
    
    try {
        ReceivedFax__c faxObj = new ReceivedFax__c();
        string title = email.subject;
        string[] titleArr = title.split('_');
        string caseId = titleArr[1];

        //問合せ/案件の情報を検索する
        list<Case> lst = [select Id from case where CaseNumber =: caseId];
        faxObj.Matter__c = lst.get(0).Id;

        faxObj.Name = title;
        faxObj.Title__c = title;
        faxObj.mail__c = email.fromAddress;
        System.debug('XXXXX メールアドレス'+email.fromAddress);
        insert faxObj;
        
        //添付ファイル作成
        list<Messaging.InboundEmail.BinaryAttachment>	atts = email.binaryAttachments;
        Attachment att =  new Attachment(
          name = atts.get(0).fileName,
          ParentId = faxObj.Id,  //添付ファイルの関連【受信Fax】のIDを設定する
          Body = atts.get(0).body
        );
        System.debug('XXXXX 添付ファイル'+att);
        System.debug('XXXXX 添付ファイル'+atts.get(0).body);
        insert att;

        System.debug('XXXXX End');
    } catch (QueryException e) {
      System.debug('XXXXX Exception'+e);
      result.success = false;
      return result;
    }
    result.success = true;
    return result;
  }
}