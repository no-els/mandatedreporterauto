import { LightningElement , api } from 'lwc';

export default class WorkshopManager extends LightningElement {
    selectedWorkshopId="None";
    selectedWorkshopName="None";
    selectedWorkshopSite="None";
    selectedWorkshopDate="None";
    handleWorkshopSelect(event) {
        this.selectedWorkshopId = event.detail.id;
        this.selectedWorkshopName = event.detail.name;
        this.selectedWorkshopSite = event.detail.site;
        this.selectedWorkshopDate = event.detail.date;
        console.log('asdf',  this.selectedWorkshopSite)
    }
}