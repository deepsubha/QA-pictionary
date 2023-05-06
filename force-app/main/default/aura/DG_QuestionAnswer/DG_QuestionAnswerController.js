({
    checkUrlParams : function(component, event, helper) {
        console.log('Url params Received: '+component.get("v.roomCode")+':'+component.get("v.userId"));
    },

    selectQuesType: function (cmp, event) {
        var selectedOptionValue = event.getParam("value");
        //alert("Option selected with value: '" + selectedOptionValue + "'");
        cmp.set("v.selectedType", selectedOptionValue);
    }
})