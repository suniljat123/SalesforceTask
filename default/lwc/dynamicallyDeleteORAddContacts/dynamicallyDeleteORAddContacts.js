import { LightningElement,api, wire ,track} from 'lwc';
import getContact from '@salesforce/apex/LWCDynamicallyDeledeOrAddContacts.getContact'; 
import saveContactList from '@salesforce/apex/LWCDynamicallyDeledeOrAddContacts.saveContactList';  
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DynamicallyDeleteORAddContacts extends LightningElement { 
    @track ConList;  
    @track delList=[];
    @api recordId;  
    @api deleteIdx;  
    connectedCallback() { 
        getContact({ accId: this.recordId })
            .then(result => {
                this.ConList = JSON.parse(JSON.stringify(result)) ; 
            })
            .catch(error => {
                this.error = error;
            });    
    } 
    saveContacts(event) {   
        saveContactList({ conList: this.ConList,deleteList :this.delList })
        .then(result => {
            this.ConList = JSON.parse(JSON.stringify(result)) ; 
        })
        .catch(error => {
            this.error = error;
        });      
    } 
    newRow(event) {  
         try{
            console.log('hii');
         var temp = this.ConList; 
        temp.push({
            sobjectType: 'Contact',
            FirstName : '',
            LastName : '',   
            Email :  '',
            Phone :  '', 
            AccountId : this.recordId   
        }); 
        this.ConList = temp;  
         }
         catch(e) {
            console.log('Catch');
            console.log(e);
         } 
    }
    deleteRow(event) {   
        this.isModalOpen = false; 
        if(this.ConList.length>1){ 
             var temp = this.ConList; 
             this.delList.push(temp[this.deleteIdx]);
             temp.splice(this.deleteIdx,1);
             this.conList=temp; 
        } 
    }
    handleFName(event) {  
        this.ConList[event.target.name].FirstName=event.target.value;
   }
   handleLName(event) {    
    this.ConList[event.target.name].LastName=event.target.value; 
    }
    handleEmail(event) {  
        this.ConList[event.target.name].Email=event.target.value;
    }
    handlePhone(event) {   
        this.ConList[event.target.name].Phone=event.target.value; 
    }@track isModalOpen = false;
    openModal(event) {
        this.deleteIdx=event.target.name; 
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() { 
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    } 
}