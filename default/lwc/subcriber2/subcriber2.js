import { LightningElement } from 'lwc';
import pubSub from 'c/pubSub'; 
export default class Subcriber2 extends LightningElement {
     message;
    connectedCallback() {
        this.register();
    }  
    register() {
        window.console.log("Event Registered");
        pubSub.register('simple_event', this._handleEvent.bind(this));

    }
    _handleEvent(messageFromEvt) {
        window.console.log("Event Handled ");
        this.message = messageFromEvt;
    }
}