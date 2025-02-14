import { LightningElement, api, track, wire } from 'lwc';
import getWorkshops from '@salesforce/apex/WorkshopSelectorController.getWorkshops';

export default class WorkshopSelector extends LightningElement {
    @api site; 
    @track workshops = [];

    @wire(getWorkshops, { site: '$site' })
    wiredWorkshops({ error, data }) {
        if (data) {
            this.workshops = data.map(workshop => ({ label: workshop.Name, value: workshop.Id }));
        }
    }

    handleWorkshopChange(event) {
        this.dispatchEvent(new CustomEvent('workshopselect', { detail: event.detail.value }));
    }
}
