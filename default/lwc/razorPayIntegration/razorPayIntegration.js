import { LightningElement, track } from 'lwc';
import payAmount from '@salesforce/apex/RazorpayIntegration.payPayment'; 
export default class RazorPayIntegration extends LightningElement {
    @track amount;
    disablePay = true;
    currentURL = '';
    connectedCallback() { 
        let url = window.location.href;
        let urlParameters = url.split('&');
        try {
            let checkPaymentStatus = urlParameters[4];
            checkPaymentStatus = checkPaymentStatus.split('=')
            if (checkPaymentStatus[1] == 'paid') {
                alert('Amount Paid Successfully');
            }
        }
        catch (error) {
            console.log('nothing');
        }
    }
    setAmount(event) {
        this.amount = event.target.value;
        if (event.target.value.length > 0) {
            this.disablePay = false;
        }
        else {
            this.disablePay = true;
        }
    }
    pay() {
        this.currentURL = window.location.href;
        payAmount({ amount: this.amount, currentPageUrl: this.currentURL }).then((data) => { 
            if (data == null) {
                alert('Something Went Wrong');
            }
            else {
               // console.log(data)
               location.assign(data.short_url);
            }
        }).catch((error) => {
            console.log(error);
        })
    } 

}