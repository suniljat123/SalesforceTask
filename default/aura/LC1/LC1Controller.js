({
	onClickHandler : function(component, event, helper) {
		component.set('v.var1', event.getSource().get('v.label'));
	},
    doInIt : function(component, event, helper) {
		component.set('v.var1', 'Sunil ');
	}
    
})