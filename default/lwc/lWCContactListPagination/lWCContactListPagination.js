import { LightningElement, track } from 'lwc';
import getContact from '@salesforce/apex/LwcContactListPagination.getContacts';
import deleteContact from '@salesforce/apex/LwcContactListPagination.deleteContact'
const columns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' },
];
export default class LWCContactListPagination extends LightningElement {
    columns = columns;
    i = 0; //Page Number
    componentEmpty = false;
    componentNotEmpty = false;
    totalPages = 0;
    presentPage = 0;
    disableFirst = false;
    disablePrevious = false;
    disableNext = false;
    disableLast = false;
    spinnerDelete = false;
    @track ConList = [];
    @track allContactList;
    rowOffset = 0;
    connectedCallback() {
        getContact()
            .then(result => {
                this.allContactList = JSON.parse(JSON.stringify(result));
                if (this.allContactList.length > 0) {
                    this.componentNotEmpty = true;
                    this.setConList(0);
                    this.presentPage = 1;
                }
                else {
                    this.componentEmpty = true;
                }

            })
            .catch(error => {
                this.error = error;
            });

    }

    setConList(index) {
        if (index == 0) {
            this.disablePrevious = true;
        }
        else {
            this.disablePrevious = false;
        }
        let length = this.allContactList.length;
        this.totalPages = Math.ceil(length / 3);
        let endingIndex = Math.trunc(length / 3)*3;
        this.ConList = [];
        let count = 0; 
        if (index == endingIndex) { 
            this.presentPage = this.totalPages;
            this.disableLast = true;
            for (count = 0; count < length % 3; count++) {
                this.ConList.push(this.allContactList[index]);
                index++; 
            }
        }
        else {
            this.disableLast = false;
            for (count = 0; count < 3; count++) {
                this.ConList.push(this.allContactList[index]);
                index++; 
            }
        }
        if (this.presentPage == this.totalPages) {
            this.disableLast = true;
        }
    }
    deleteRow(event) {
        this.spinnerDelete = true;
        this.ConList.splice(event.target.value, 1);
        deleteContact({ conId: event.target.name }) // In the event.target.name there is a id of that selected Contact
            .then(result => {
                this.spinnerDelete = false;
                this.allContactList = JSON.parse(JSON.stringify(result));
                this.ConList = [];
                let sizeOfList = this.allContactList.length;
                if (sizeOfList == 0) {
                    this.presentPage = 0;
                    this.totalPages = 0;
                    this.componentEmpty = true;
                    this.componentNotEmpty = false
                }
                else if (sizeOfList % 3 == 0 && this.i == this.totalPages - 1) {
                    this.presentPage = this.presentPage - 1;
                    this.totalPages = this.totalPages - 1;
                    this.disableLast = true;
                    this.ConList = [];
                    this.i = this.i - 1;
                    let temp = this.i * 3;
                    this.setConList(temp); 
                }
                else {
                    let temp = this.i * 3;
                    this.setConList(temp);
                }
                if (sizeOfList == 3) {
                    this.disablePrevious = true;
                    this.disableLast = true;
                }

            })
            .catch(error => {
                this.error = error;
            }); 
    } 
    firstPage() {
        this.presentPage = 1;
        this.i = 0;
        this.setConList(0);
    }
    previousPage() {
        this.presentPage = this.presentPage - 1;
        this.i = this.i - 1;
        this.setConList(this.i * 3);
    }
    nextPage() {
        this.presentPage = this.presentPage + 1;
        this.i = this.i + 1;
        this.setConList(this.i * 3);
    }
    lastPage() {
        let len = this.allContactList.length;
        len = len / 3;
        this.i = Math.trunc(len);
        this.setConList(this.i * 3);
    }
}