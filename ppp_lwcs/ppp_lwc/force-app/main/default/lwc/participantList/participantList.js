import { LightningElement, api, track, wire } from 'lwc';
import getParticipants from '@salesforce/apex/ParticipantListController.getParticipants';

export default class ParticipantList extends LightningElement {
    @api site;
    @track participants = [];

    @wire(getParticipants, { site: '$site' })
    wiredParticipants({ error, data }) {
        if (data) {
            this.participants = data;
        }
    }

    handleAdd(event) {
        this.dispatchEvent(new CustomEvent('addparticipant', { detail: event.target.dataset.id }));
    }
}
