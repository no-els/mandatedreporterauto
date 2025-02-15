import { LightningElement , api , wire } from 'lwc';
import getAttendees from '@salesforce/apex/WorkshopController.getAttendees';

export default class WorkshopManager extends LightningElement {
    selectedWorkshopId="None";
    selectedWorkshopName="None";
    selectedWorkshopSite="None";
    selectedWorkshopDate="None";
    attendees;
    wiredAttendees;

    @wire(getAttendees, { workshopId: '$selectedWorkshopId' })
    wiredAttendeesData(result) {
        this.wiredAttendees = result;
        if (result.data) {
            this.attendees = result.data;
        }
    }
    handleWorkshopSelect(event) {
        this.selectedWorkshopId = event.detail.id;
        this.selectedWorkshopName = event.detail.name;
        this.selectedWorkshopSite = event.detail.site;
        this.selectedWorkshopDate = event.detail.date;
        console.log('asdf',  this.selectedWorkshopSite)
    }
    refreshData() {
        console.log("Refreshing attendees list...");
        return refreshApex(this.wiredAttendees);
    }
}