import { LightningElement, track, wire } from 'lwc';
import searchWorkshops from '@salesforce/apex/WorkshopController2.searchWorkshops';

export default class WorkshopSearch extends LightningElement {
    @track searchTerm = '';
    @track workshops;
    @track error;

    handleSearch(event) {
        this.searchTerm = event.target.value;
        
        if (this.searchTerm.length > 2) { // Avoid too many queries
            this.fetchWorkshops();
        } else {
            this.workshops = null; // Clear results if search term is too short
        }
    }

    fetchWorkshops() {
        searchWorkshops({ searchTerm: this.searchTerm })
            .then(result => {
                this.workshops = result;
                this.error = null;
            })
            .catch(error => {
                this.error = 'Error fetching workshops';
                this.workshops = null;
            });
    }
}
