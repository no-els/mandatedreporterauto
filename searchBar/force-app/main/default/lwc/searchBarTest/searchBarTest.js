import { LightningElement, track, api, wire } from 'lwc';
import searchContacts from '@salesforce/apex/ContactController.searchContacts';
import addContactsToSession from '@salesforce/apex/ServiceSessionController.addContactsToSession';

export default class AddContactsToServiceSession extends LightningElement {
    @api recordId; // Service Session ID
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

    handleSubmit() {
        const contactIds = this.selectedContacts.map(contact => contact.Id);

        // Call Apex to add selected contacts to the Service Session
        addContactsToSession({ sessionId: this.recordId, contactIds })
            .then(() => {
                // Success message or any further actions
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Contacts added to Service Session.',
                    variant: 'success'
                }));
            })
            .catch(error => {
                console.error('Error adding contacts to session:', error);
            });
    }
}
