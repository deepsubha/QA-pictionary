({
    checkUrlParams : function(component, event, helper) {
        console.log('Url params Received: '+component.get("v.roomCode")+':'+component.get("v.userId"));
    },

    selectWord: function(component, event, helper) {
        //console.log('exploring :::'+Math.floor(Math.random() * 10));
        helper.getWord(component);
    }
})