import { LightningElement, wire } from 'lwc';
import searchWorkshops from '@salesforce/apex/WorkshopController.searchWorkshops';

export default class WorkshopSearch extends LightningElement {
    @wire (searchWorkshops, {searchTerm: '$workshopInput'}) workshops;
    workshopInput = "";
    currentWorkshopId="";
    workshopName="";
    workshopDate="";
    workshopSite="";
    handleInputChange(event) {
        this.workshopInput = event.target.value;
    }

    handleClick(event) {
        this.currentWorkshopId = event.target.dataset.id;
        this.workshopName = event.target.dataset.name;
        this.workshopDate = event.target.dataset.date;
        this.workshopSite = event.target.dataset.site;
        console.log(this.currentWorkshopId, this.workshopName, this.workshopDate, this.workshopSite, "AS", event.target.dataset);
        const selectEvent = new CustomEvent('workshopselect', {
            detail: 
                {id: this.currentWorkshopId,
                name: this.workshopName,
                date: this.workshopDate,
                site: this.workshopSite
                }


                });
        this.dispatchEvent(selectEvent);

    }
}