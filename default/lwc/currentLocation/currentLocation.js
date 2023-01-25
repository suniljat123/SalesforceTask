import { LightningElement, api, track } from 'lwc';
import getcountries from '@salesforce/apex/currentLocation.getCountries'
import getStates from '@salesforce/apex/currentLocation.getStates'
import getDistricts from '@salesforce/apex/currentLocation.getDistrict'
export default class CurrentLocation extends LightningElement {

    showLocation = false;
    @track statesData = [];
    @api isLoading = false;
    City;  
    @api Street;
    State;
    zoomLevel = 15;
    mapMarkers;
    @track countryCode = '';
    @track stateCode ='';
    @track countryData = [];
    @track districtData = []; 
    switchIsLoading() {
        this.isLoading = false;
        this.showLocation = true; 
    }
    connectedCallback() {  
        getcountries({}).then((response) => { 
            return JSON.parse(response);
        }).then((data) => { 
             for (let x in data) {
                this.countryData.push({
                     country: data[x].name, countryCode:data[x].iso2
                });  
            } 
        })
    } 
    selectedCountry(event) {
        this.statesData = [];
        this.districtData = [];
        this.countryCode = event.target.value;
        getStates({Country: this.countryCode}).then((response) => { 
            return JSON.parse(response);
        }).then((data) => { 
             for (let x in data) {
                 
                 this.statesData.push({
                     state: data[x].name, stateCode:data[x].iso2
                }); 
            } 
        })
    }
    selectedState(event) {
        this.districtData = [];
        this.stateCode = event.target.value; 
        getDistricts({country: this.countryCode, state: this.stateCode }).then((response) => {  
            return JSON.parse(response);
        }).then((data) => { 
             for (let x in data) { 
                 this.districtData.push({
                     district: data[x].name, districtCode:data[x].iso2
                }); 
            } 
        })
    }
    selectedDistrict(event) {
        this.City = event.target.value;  
    }
    searchLocation(event) {
        this.isLoading = true;  
        setTimeout(() => {
            this.switchIsLoading()
        }, 1000);
        this.mapMarkers = [];
        this.mapMarkers = [
            {
                location: {
                    // Location Information
                    City: this.City,
                    Country: this.countryCode, 
                    State: this.stateCode,
                    Street: this.Street,
                },
                title: this.City,
                description: this.Street,

            }

        ];
    }  
    setStreet(event) {
        this.Street = event.target.value;
    }

}