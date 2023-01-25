import { LightningElement } from 'lwc';
import getUserData from '@salesforce/apex/Github.getUserData';
export default class GitHub extends LightningElement {
    username = '';
    searchBtn = true;
    userPopolated = false;
    showError = false;
    userId;
    loginName;
    followers;
    followings;
    imageURL;
    name;
    company;
    bio;
    location;
    public_repository;
    twitter_username;
    updateUserName(event) {
        this.username = event.target.value;
        this.username = this.username.trim(); 
        this.userPopolated = false;
        if (this.username.length > 0) {
            this.searchBtn = false;
        }
        else { 
            this.searchBtn = true;
        }
    }
    search() {
        getUserData({ userName: this.username }).then((response) => {
            return JSON.parse(response);
        }).then((data) => { 
            if (data == null) {
                this.showError = true;
                this.userPopolated = false; 
            }
            else {
                this.userId = data.id;
                this.loginName = data.login;
                this.followers = data.followers;
                this.followings = data.following;
                this.imageURL = data.avatar_url;
                this.company = data.company;
                this.name = data.name;
                this.bio = data.bio;
                this.location = data.location;
                this.public_repository = data.public_repos;
                this.twitter_username = data.twitter_username;
                this.userPopolated = true;
                this.showError = false;
            }
        })
    }
}