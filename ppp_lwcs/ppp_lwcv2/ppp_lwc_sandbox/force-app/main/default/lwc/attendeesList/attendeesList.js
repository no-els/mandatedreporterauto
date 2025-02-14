import { LightningElement, api, wire } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getAttendees from '@salesforce/apex/WorkshopController.getAttendees';
import deleteAttendee from '@salesforce/apex/WorkshopController.deleteAttendee';

export default class AttendeesList extends LightningElement {
    @api workshopId;
    @wire (getAttendees, {workshopId: '$workshopId'}) attendeesList;
    handleClick(event) {
        const attendeeId = event.target.dataset.id;
        if (!attendeeId) {
            this.showNotification("Error", "Invalid attendee ID", "error");
            return;
        }
        deleteAttendee({ attendeeId })
            .then(result => {
                if (result === "Success") {
                    return refreshApex(this.attendeesList); // Refresh the list
                } else {
                    this.showNotification("Error", result, "error");
                }
            })
    }
    
}