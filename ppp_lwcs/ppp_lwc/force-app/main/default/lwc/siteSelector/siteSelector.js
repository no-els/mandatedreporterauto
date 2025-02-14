import { LightningElement, track, wire } from 'lwc';
import getSites from '@salesforce/apex/SiteSelectorController.getSites';

export default class SiteSelector extends LightningElement {
    @track sites = [];
    selectedSite = '';

    @wire(getSites)
    wiredSites({ error, data }) {
        if (data) {
            this.sites = data.map(site => ({ label: site, value: site }));
        }
    }

    handleSiteChange(event) {
        this.selectedSite = event.detail.value;
        this.dispatchEvent(new CustomEvent('siteselect', { detail: this.selectedSite }));
    }
}
3