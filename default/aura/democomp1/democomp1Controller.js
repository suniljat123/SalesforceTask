({
	doinit : function(component, event, helper) {
		component.set('v.var1','sunil choudhary')
        var data={"name":"Sunil Choudhary","email":"sunil@gmail.com"};
        component.set('v.jsObject',data);
        component.set('v.wrapperobj',{'string1':'Sunil jat', 'intvalue':5556});
	}
})