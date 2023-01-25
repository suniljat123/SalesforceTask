import { getDataConnectorSourceFields } from 'lightning/analyticsWaveApi';
import { publish,MessageContext } from 'lightning/messageService';
import GetOtherCmpName from "@salesforce/messageChannel/GetOtherCmpName__c";

import { LightningElement,api ,track,wire} from 'lwc';

export default class LWCParent extends LightningElement {
    @track Name = '';
    @wire(MessageContext)
    messageContext;
    setName(event) { 
        this.Name = event.target.value;
        const payload = {
            getFirstName: this.Name
        }
        publish(this.messageContext, GetOtherCmpName, payload);
    }  
}