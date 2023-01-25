({
    validateAccountRecords: function(component, event) { 
        var isValid = true; 
        var ConList = component.get("v.ConList");
        for (var i = 0; i < ConList.length; i++) { 
            if (ConList[i].LastName == '' || ConList[i].LastName == null || ConList[i].LastName == undefined) {
                isValid = false;
                alert('Contact LastName cannot be blank on '+(i + 1)+' row number');
            }
        } 
        return isValid;    
    },
})