import { LightningElement, track, api, wire } from 'lwc';
import searchContacts from '@salesforce/apex/ContactController.searchContacts';

export default class AddContactsToSession extends LightningElement {
    @api recordId; // Service Session ID passed from the flow
    @track searchTerm = '';
    @track contactOptions = [];
    @track selectedContacts = [];

    handleInputChange(event) {
        this.searchTerm = event.target.value;

        // Call Apex to get matching contacts
        searchContacts({ searchTerm: this.searchTerm })
            .then(result => {
                this.contactOptions = result;
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
            });
    }

    handleSelectContact(event) {
        const contactId = event.currentTarget.dataset.id;
        const contact = this.contactOptions.find(contact => contact.Id === contactId);

        // Add contact to selectedContacts if not already there
        if (!this.selectedContacts.find(c => c.Id === contactId)) {
            this.selectedContacts = [...this.selectedContacts, contact];
        }
    }

    removeSelectedContact(event) {
        const contactId = event.currentTarget.dataset.id;
        this.selectedContacts = this.selectedContacts.filter(contact => contact.Id !== contactId);
    }

    @api
    get contactIds() {
        // This getter will return an array of selected contact IDs
        return this.selectedContacts.map(contact => contact.Id).join(',');
    }

    handleSubmit() {
        // Emit the selected contacts and service session ID to the Flow
        const contactIds = this.selectedContacts.map(contact => contact.Id);
        this.dispatchEvent(new CustomEvent('submit', {
            detail: {
                contactIds,
                serviceSessionId: this.recordId // Assuming `recordId` is the Service Session ID
            }
        }));
    }
}