({
    disableCloseFocusedTab: function (component) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;

            alert(focusedTabId);
            sforce.console.refreshPrimaryTabById(focusedTabId, false);
        })
            .catch(function (error) {
                console.log(error);
            });
    },
    closeTab: function (component) {
        var workspaceAPI = component.find("workspace");

        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.disableTabClose({
                tabId: focusedTabId,
                disabled: false
            }).then(function (tabInfo) {
                workspaceAPI.closeTab({ tabId: focusedTabId });
                console.log(tabInfo);

            }).catch(function (error) {
                console.log(error);
            });

            workspaceAPI.closeTab({ tabId: focusedTabId });
        }).catch(function (error) {
            console.log(error);
        });
    }
    ,
    hiddenCloseButton: function (component) {
        var workspaceAPI = component.find("workspace");

        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.disableTabClose({
                tabId: focusedTabId,
                disabled: true
            }).then(function (tabInfo) {
                console.log(tabInfo);
            }).catch(function (error) {
                console.log(error);
            });
        }).catch(function (error) {
            console.log(error);
        });
    },
    showCloseButton: function (component) {
        var workspaceAPI = component.find("workspace");

        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.disableTabClose({
                tabId: focusedTabId,
                disabled: false
            }).then(function (tabInfo) {
                console.log(tabInfo);
            }).catch(function (error) {
                console.log(error);
            });
        }).catch(function (error) {
            console.log(error);
        });
    }
})