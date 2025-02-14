import { LightningElement, wire , api} from 'lwc';
import getContacts from '@salesforce/apex/WorkshopController.getContacts';
import addAttendee from '@salesforce/apex/WorkshopController.addAttendee';

export default class PossibleAttendeesList extends LightningElement {
    searchTerm="";
    @api selectedWorkshopId;
    @wire (getContacts, {searchTerm: '$searchTerm'}) possibleAttendeesList;
    handleInputChange(event) {
        this.searchTerm = event.target.value;
    }
    handleClick(event) {
        const contactId = event.target.dataset.id;
        const workshopId = this.selectedWorkshopId;
        /*todo add logic to create attendee. must enforce uniqueness on frontend and backend*/
        if (this.selectedWorkshopId == null || this.selectedWorkshopId == "None") {
            alert("Please select a workshop first");
            return;
        }
        addAttendee({workshopId: workshopId, contactId: contactId})
        console.log("attendee added");

    }
}