trigger SurveillanceContact on Task (after insert,after update) {

/*
    if (Trigger.isAfter) {
        list<Task> tkList = trigger.new;
        //newTask.Subject
        Task nTask = tkList.get(0);

        ReceivedFax__c faxObj = new ReceivedFax__c();
        string title = nTask.Subject;
        string[] titleArr = title.split('_');
        string caseId = titleArr[1];
        list<Case> lst = [select Id from case where CaseNumber =: caseId];
        faxObj.Matter__c = lst.get(0).Id;
        faxObj.Name = title;
        insert faxObj;
    }
    */
}