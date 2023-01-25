import { LightningElement, api, track } from 'lwc';
import getCovidDetail from '@salesforce/apex/Covid.getCovidDetails'
export default class Covid extends LightningElement { 
    @track statesData = [];
    @track districtsData = [];
    @track dist = ''; 
    @track stateList = false;
    @track districtList = false;
    @track showSpinner = true;
    @track state = '';
    @track index = 1;
    columnHeader = ['State', 'Pupulation', 'Tested', 'Confirmed','Recovered'];
    connectedCallback() {
        getCovidDetail({}).then((response) => {
            return JSON.parse(response);
        }).then((data) => {
            this.stateList = true;
            this.districtList = false;
            this.showSpinner = false;
            this.index = 1;
            for (let x in data) {  
                this.statesData.push({ 
                    index: this.index,state: x, population: data[x].meta.population, tested: data[x].total.tested,
                    confirmed: data[x].total.confirmed, recovered: data[x].total.recovered
                });
                this.index = this.index + 1;
            }
        })
    }
    showDistricts(event) {
        this.showSpinner = true;
        this.state = event.currentTarget.dataset.item;
        getCovidDetail({}).then((response) => {
            return JSON.parse(response);
        }).then((data) => {
            this.stateList = false;
            this.districtList = true;
            this.showSpinner = false;
            this.districtsData = []; 
            this.index = 1;
            for (let x in data[this.state].districts) { 
                try {
                    this.districtsData.push({
                        index: this.index,district: x, population: data[this.state].districts[x].meta.population, tested: data[this.state].districts[x].total.tested,
                        confirmed: data[this.state].districts[x].total.confirmed, recovered: data[this.state].districts[x].total.recovered
                    }); 
                    this.index = this.index + 1;
                }
                catch (error) {
                    
                }
            } 
        })
    }
    showState() {
        this.stateList = true;
            this.districtList = false;
            this.showSpinner = false;
    }
    exportContactData(){
        // Prepare a html table
        let doc = '<table>';
        // Add styles for the table
        doc += '<style>';
        doc += 'table, th, td {';
        doc += '    border: 1px solid black;';
        doc += '    border-collapse: collapse;';
        doc += '}';          
        doc += '</style>';
        // Add all the Table Headers
        doc += '<tr>';
        this.columnHeader.forEach(element => {            
            doc += '<th>'+ element +'</th>'           
        });
        doc += '</tr>';
        // Add the data rows
        this.statesData.forEach(record => {
            doc += '<tr>';
            doc += '<th>'+record.state+'</th>'; 
            doc += '<th>'+record.population+'</th>'; 
            doc += '<th>'+record.tested+'</th>';
            doc += '<th>' + record.confirmed + '</th>'; 
            doc += '<th>'+record.recovered+'</th>';
            doc += '</tr>';
        });
        doc += '</table>';
        var element = 'data:application/vnd.ms-excel,' + encodeURIComponent(doc);
        let downloadElement = document.createElement('a');
        downloadElement.href = element;
        downloadElement.target = '_self';
        // use .csv as extension on below line if you want to export data as csv
        downloadElement.download = 'Contact Data.xls';
        document.body.appendChild(downloadElement);
        downloadElement.click();
    }
}