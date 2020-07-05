({
	myAction: function (component, event, helper) {
		var recordId = component.get("v.recordId");
		helper.callApex(component, helper, "c.initArrangeList", { "recordId": recordId }, hepler.initScreenListData);
	}
})