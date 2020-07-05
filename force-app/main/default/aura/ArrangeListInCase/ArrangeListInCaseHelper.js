({
	initScreenListData: function (component, helper, returnValue) {

		helper.initScreenCOlumns(component, returnValue.arrangeDataMap);
	},
	initScreenCOlumns: function (component, orderFieldMap) {
		var actionButtons = [
			{ label: "編集", name: "edit" },
			{ label: "削除", name: "delete" }
		];

		component.set("v.columnList", [
			{ type: "action", typeAttributes: { rowActions: actionButtons } },
			{ label: orderFieldMap["ID"], fieldName: "", type: "text", editable: false },
			{ label: orderFieldMap["Name"], fieldName: "", type: "text", editable: false },
			{ type: "action", typeAttributes: { rowActions: actionButtons } }
		]);
	}
})