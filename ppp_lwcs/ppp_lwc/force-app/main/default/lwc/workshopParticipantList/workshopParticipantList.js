import { LightningElement, api, track, wire } from 'lwc';
import getWorkshopParticipants from '@salesforce/apex/WorkshopParticipantListController.getWorkshopParticipants';

export default class WorkshopParticipantList extends LightningElement {
    @api workshop;
    @track participants = [];

    @wire(getWorkshopParticipants, { workshop: '$workshop' })
    wiredParticipants({ error, data }) {
    if (data) {
        this.participants = data;
        console.log('🔄 Workshop Participants Loaded:', data);
    } else if (error) {
        console.error('❌ Error fetching participants:', error);
    }
}


    handleRemove(event) {
        this.dispatchEvent(new CustomEvent('removeparticipant', { detail: event.target.dataset.id }));
    }
}
