import { LightningElement, api } from 'lwc';
import Address from '@salesforce/schema/Lead.Address';
import getLatitudeLongitude from '@salesforce/apex/ContactTriggerHandler.getLatitudeLongitude';
import sendLocation from '@salesforce/apex/WhatsappIntegration.sendLocation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SendWhatsappMessage extends LightningElement {
    @api recordId;
    @api city = '';
    @api address = '';
    disableBtn = true;
    disableCity = true;
    message = '';
    variant = '';
    latitude = '';
    longitude = '';
    fullAddress = '';
    showSpinner = false;
    send(event) { 
        this.showSpinner = true;
        this.fullAddress = this.address + ',' + this.city;
        getLatitudeLongitude({ city: this.city }).then((response) => {
            let arr = [];
            
            response = response + '';
            arr = response.split(','); 
            this.latitude = arr[23];
            this.longitude = arr[24];
            sendLocation({ Latitude: this.latitude, Longitude: this.longitude, Address: this.fullAddress }).then((response) => { 
                this.showSpinner = false;
                if (response == true) { 
                    this.message = 'Message Sent Successfully';
                    this.variant = 'success';
                    this.showNotification();
                }
                else { 
                    this.message = 'Something Went Wrong';
                    this.variant = 'error';
                    this.showNotification();
                }
                
            }).catch((error) => {
                this.showSpinner = false;
                this.message = 'Something Went Wrong';
                this.variant = 'error';
                this.showNotification();
            })
        }).catch((error) => {
            this.showSpinner = false;
            this.message = 'Something Went Wrong';
            this.variant = 'error';
            this.showNotification();
        })
    }
    setAddress(event) {
        this.address = event.target.value;
        this.address = this.address.trim();
        this.city = this.city.trim();
        if (this.address.length > 0) {
            this.disableCity = false;
        }
        else {
            this.disableCity = true;
            this.disableBtn = true;
        }

    }
    setCity(event) {
        this.city = event.target.value;
        this.city = this.city.trim();
        if (this.city.length > 0) {
            this.disableBtn = false;
        }
        else {
            this.disableBtn = true;
        }
    }
    showNotification() {
        const evt = new ShowToastEvent({

            title: this.message, 
            variant: this.variant
        });
        this.dispatchEvent(evt);
    }

}