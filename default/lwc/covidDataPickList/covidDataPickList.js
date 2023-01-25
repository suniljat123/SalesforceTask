import { LightningElement, track } from 'lwc';
import getCovidDetail from '@salesforce/apex/Covid.getCovidDetails'
export default class CovidDataPickList extends LightningElement {
    @track statesData = [];
    @track districtsData = [];
    @track districtsDataList = [];
    @track statesDataList = [];
    @track dist = '';
    @track showState = false;
    @track districtList = false;
    @track showSpinner = true;
    @track index = 1;
    @track stateName = '';
    @track states = [];
    connectedCallback() {
        getCovidDetail({}).then((response) => {
            return JSON.parse(response);
        }).then((data) => {
            this.stateList = true;
            this.districtList = false;
            this.index = 1;
            for (let x in data) {
                this.statesData.push({
                    index: this.index, state: x, population: data[x].meta.population, tested: data[x].total.tested,
                    confirmed: data[x].total.confirmed, recovered: data[x].total.recovered
                });
                this.index = this.index + 1;
            }
            this.showSpinner = false;
        })
        this.states = this.statesData;
        
    }
    selectedDistrict(event) {
        let district = event.target.value;
        this.districtsDataList = [];
        this.showSpinner = true;
        getCovidDetail({}).then((response) => {
            return JSON.parse(response);
        }).then((data) => {
            this.index = 1;
            for (let x in data[this.stateName].districts) {
                if (x == district) {
                    try {
                        this.districtsDataList.push({
                            index: this.index, district: x, population: data[this.stateName].districts[x].meta.population, tested: data[this.stateName].districts[x].total.tested,
                            confirmed: data[this.stateName].districts[x].total.confirmed, recovered: data[this.stateName].districts[x].total.recovered
                        });
                        this.index = this.index + 1;
                    }
                    catch (error) {

                    }
                }

            }
            this.showSpinner = false;
            this.districtList = true;
        })

    }
    selectedState(event) {
        this.showSpinner = true;
        let y = event.target.value;
        this.stateName = event.target.value;
        this.showState = true;
        this.statesDataList = [];
        this.districtList = false;
        getCovidDetail({}).then((response) => {
            return JSON.parse(response);
        }).then((data) => {
            this.stateList = true;
            this.index = 1;
            this.districtsData = [];
            for (let x in data) {
                if (x == y) {
                    this.statesDataList.push({
                        index: this.index, state: x, population: data[x].meta.population, tested: data[x].total.tested,
                        confirmed: data[x].total.confirmed, recovered: data[x].total.recovered
                    });
                    for (let x1 in data[y].districts) {
                        try {
                            this.districtsData.push({
                                index: this.index, district: x1
                            });
                        }
                        catch (error) {

                        }
                    }
                }
            }
            this.showSpinner = false;
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
                        index: this.index, district: x, population: data[this.state].districts[x].meta.population, tested: data[this.state].districts[x].total.tested,
                        confirmed: data[this.state].districts[x].total.confirmed, recovered: data[this.state].districts[x].total.recovered
                    });
                    this.index = this.index + 1;
                }
                catch (error) {

                }
            }
        })
    }

}