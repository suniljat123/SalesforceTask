import { LightningElement } from 'lwc'; 
import pubSub1 from 'c/pubSub';  
export default class Subscriber extends LightningElement {
    message;
    connectedCallback() {
        this.register();
    }  
    register() {
        window.console.log("Event Registered");
        pubSub1.register('simplevt', this.handleEvent.bind(this));

    }
    handleEvent(messageFromEvt) {
        window.console.log("Event Handled ");
        this.message = messageFromEvt;
    }

}