import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import GetOtherCmpName from "@salesforce/messageChannel/GetOtherCmpName__c";
import JigsawContactId from '@salesforce/schema/Contact.JigsawContactId';
import { getDataConnectorSourceFields } from 'lightning/analyticsWaveApi';
export default class LWCParent2 extends LightningElement {
    Name = '';
    subscription = null;
    @wire(MessageContext)
    messageContext;
    connectedCallback() {
        console.log("hii");
        this.subscribeToMessageChannel();
    }
    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            GetOtherCmpName,
            (message) => this.handleMessage(message)
        );
    }
    handleMessage(message) {
        this.ariaRoleDescription("Message=>" + JigsawContactId.stringify(message));
    }
}