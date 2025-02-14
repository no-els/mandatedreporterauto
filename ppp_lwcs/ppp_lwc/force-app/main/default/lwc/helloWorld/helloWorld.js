import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    currentDate = new Date().toLocaleDateString();
}
