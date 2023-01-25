import { LightningElement,api } from 'lwc';
import pubSub from 'c/pubSub'; 
export default class Publisher extends LightningElement {
    @api name;
    handleClick() {
        window.console.log("Event Firing..."); 
        pubSub.fire('simplevt', this.name);
        pubSub.fire('simple_event', this.name);
        
        window.console.log("Event Fired...");
    }
    changedInput(event) { 
        this.name = event.target.value;
    }
}