import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LWCCalculator extends LightningElement {
    @track textvalue = '';
    changedInput(event) {
        this.textvalue = event.target.value;
        let len = this.textvalue.length;
        if (event.keyCode === 13) { 
            try {
                this.textvalue = eval(this.textvalue);
            }
            catch (e) { 
            const evt = new ShowToastEvent({
            title: "Syntax Error",
            message: "Check Your Expression",
            variant: "error",
        });
        this.dispatchEvent(evt);
        }
        }
        if (this.textvalue[len - 1] == '1' || this.textvalue[len - 1] == '5' || this.textvalue[len - 1] == '9' ||
            this.textvalue[len - 1] == '2' || this.textvalue[len - 1] == '6' || this.textvalue[len - 1] == '0' ||
            this.textvalue[len - 1] == '3' || this.textvalue[len - 1] == '7' || this.textvalue[len - 1] == '4' ||
            this.textvalue[len - 1] == '8' || this.textvalue[len - 1] == '+' || this.textvalue[len - 1] == '-' ||
            this.textvalue[len - 1] == '*' || this.textvalue[len - 1] == '/' || this.textvalue[len - 1] == '.') {
            //Nothing
        }
        else if (this.textvalue[len - 1] == 'C' || this.textvalue[len - 1] == 'c') {
            this.textvalue = '';
        }
        else if (this.textvalue[len - 1] == '=') { 
            this.textvalue = this.textvalue.substring(0, len - 1);
            event.target.value = this.textvalue;
            try {
                this.textvalue = eval(this.textvalue);
            }
           catch (e) { 
            const evt = new ShowToastEvent({
            title: "Syntax Error",
            message: "Check Your Expression",
            variant: "error",
        });
        this.dispatchEvent(evt);
        }
        }
        else {
            this.textvalue = this.textvalue.substring(0, len - 1);
            event.target.value = this.textvalue;

        }
    }
    takeInput(event) {
        if (event.target.value != '=' && event.target.value != 'C') {
            this.textvalue = this.textvalue + event.target.value;
        }
        else if (event.target.value == 'C') {
            this.textvalue = '';
        }

    }
    showResult(event) {
        try {
            this.textvalue = eval(this.textvalue);
        }
        catch (e) { 
            const evt = new ShowToastEvent({
            title: "Syntax Error",
            message: "Check Your Expression",
            variant: "error",
        });
        this.dispatchEvent(evt);
        }
    }
    handlePaste(event) {
        event.preventDefault();
    } 
}