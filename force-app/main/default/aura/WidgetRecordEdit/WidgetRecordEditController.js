({
    onSave: function (component, event, helper) {

        component.find("recordLoader").saveRecord($A.getCallback(function (saveResult) {
            if (saveResult.state === "SUCCESS") {

                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was updated."
                });
                resultsToast.fire();

                var navigateEvent = $A.get("e.force:navigateToSObject");
                navigateEvent.setParams({ "recordId": component.get('v.recordId') });
                navigateEvent.fire();

                helper.closeTab(component);
            }
            else {
                // Basic error handling
                component.set('v.recordError',
                    'Error: ' + saveResult.state + ', message: ' + JSON.stringify(saveResult.error));
            }
        }));
    },
    onCancel: function (component, event, helper) {
        if (confirm("データが編集中ですが、タブを閉じてもよろしいでしょうか")) {
            helper.closeTab(component);            
        }
    },
    doInit: function (component, event, helper) {
        helper.hiddenCloseButton(component);
    },
    doneRendering: function (component, event, helper) {
        if (!component.get("v.isDoneRendering")) {
            component.set("v.isDoneRendering", true);
            
            window.setTimeout(
                $A.getCallback(function() {
                    helper.hiddenCloseButton(component);
                }), 1500
            );
        }
    }
/*
    hiddenClose: function (component, event, helper) {
        helper.hiddenCloseButton(component);
    },

    showClose: function (component, event, helper) {
        helper.showCloseButton(component);
    }
*/

})