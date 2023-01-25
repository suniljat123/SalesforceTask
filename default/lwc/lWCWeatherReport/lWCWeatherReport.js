import { LightningElement, track } from 'lwc';
import getReport from '@salesforce/apex/WeatherIntegration.for1Day';
import get15DaysData from '@salesforce/apex/WeatherIntegration.for15Days';
import FirstName from '@salesforce/schema/Contact.FirstName';
export default class LWCWeatherReport extends LightningElement {
    @track city = 'ajmer';
    @track temp = '';
    @track index = '';
    @track scene = '';
    @track date = '';
    @track time = '';
    @track weatherData = [];
    @track value = '';
    next15DaysData = false;
    todayData = false;
    blank = true;
    showSpinner = false;
    today(event) {
        this.getData();
        this.showSpinner = true;
        this.next15DaysData = false;
        this.todayData = true;

    }
    next15Days() {
        this.showSpinner = true;
        this.todayData = false;
        this.next15DaysData = true;
        this.getWeatherData();
    }
    tomorrow() {
        this.showSpinner = true;
        this.getWeatherData();
        this.next15DaysData = false;
        this.todayData = true;
    }

    getWeatherData() {
        this.weatherData = [];
        get15DaysData({ city: this.city }).then((response) => {
            this.city = this.city.toUpperCase();
            return JSON.parse(response);
        }).then((data) => {
            this.temp = data.locations[Object.keys(data.locations)].values[1].temp;
            this.temp = (this.temp - 32) * (5 / 9);
            this.temp = this.temp + '';
            this.index = this.temp.indexOf(".");
            this.temp = this.temp.substring(0, this.index); //yha temp ko 2 decimal tk set kiya
            this.scene = data.locations[Object.keys(data.locations)].values[1].conditions;
            this.date = data.locations[Object.keys(data.locations)].values[0].datetimeStr;
            this.date += '';
            this.index = this.date.indexOf("T");
            let idx = this.index + 1;
            this.time = this.date.substring(idx, idx + 5);
            this.date = this.date.substring(0, this.index);
            this.showSpinner = false;
            for (let i = 0; i < 16; i++) {
                let dayDate = data.locations[Object.keys(data.locations)].values[i].datetimeStr + '';
                dayDate = dayDate.substring(0, 10);
                let maxTemp = data.locations[Object.keys(data.locations)].values[i].maxt;
                maxTemp = (maxTemp - 32) * (5 / 9);
                maxTemp = maxTemp + '';
                let idx = maxTemp.indexOf(".");
                maxTemp = maxTemp.substring(0, idx);
                let minTemp = data.locations[Object.keys(data.locations)].values[i].mint;
                minTemp = (minTemp - 32) * (5 / 9);
                minTemp = minTemp + '';
                idx = minTemp.indexOf(".");
                minTemp = minTemp.substring(0, idx);
                this.weatherData.push({
                    date: dayDate, maxt: maxTemp, mint: minTemp,
                    Condition: data.locations[Object.keys(data.locations)].values[i].conditions
                });
            }
        }).catch((error) => {
            console.log(error);
            console.log("error");
            this.showSpinner = false;
        })
    }
    setLocation(event) {
        this.blank = true;
        this.todayData = false;
        if (event.keyCode === 13) {
            this.blank = false;
            this.city = event.target.value;
            this.getData();
            this.showSpinner = true;

        }
        else if ((this.city == event.target.value.toUpperCase()) && this.city.length > 0) {
            this.blank = false;
            this.todayData = true;
        }
    }
    getData(event) {
        this.next15DaysData = false;
        this.todayData = true;
        getReport({ city: this.city }).then((response) => {
            this.city = this.city.toUpperCase();
            return JSON.parse(response);
        }).then((data) => {
            this.temp = data.locations[Object.keys(data.locations)].values[0].temp;
            this.temp = (this.temp - 32) * (5 / 9);
            this.temp = this.temp + '';
            this.index = this.temp.indexOf(".");
            this.temp = this.temp.substring(0, this.index);
            this.scene = data.locations[Object.keys(data.locations)].values[0].conditions;
            this.date = data.locations[Object.keys(data.locations)].values[0].datetimeStr;
            this.date += '';
            this.index = this.date.indexOf("T");
            let idx = this.index + 1;
            this.time = this.date.substring(idx, idx + 5);
            this.date = this.date.substring(0, this.index);
            
            this.showSpinner = false;
            this.todayData = true;
        }).catch((error) => {
            console.log(error);
            console.log("error");
            this.showSpinner = false;
        })
    }

}