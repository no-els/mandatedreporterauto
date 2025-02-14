import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import SERVICE_SESSION_FIELD from '@salesforce/schema/Contact.pmdm__ServiceSession__c';

export default class AddContactToServiceSession extends LightningElement {
    @api recordId; // Service Session Id

    handleSave() {
        const firstName = this.template.querySelector('[data-id="firstName"]').value;
        const lastName = this.template.querySelector('[data-id="lastName"]').value;
        const email = this.template.querySelector('[data-id="email"]').value;

        if (!firstName || !lastName) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'First Name and Last Name are required',
                    variant: 'error',
                })
            );
            return;
        }

        const fields = {
            FirstName: firstName,
            LastName: lastName,
            Email: email,
            [SERVICE_SESSION_FIELD.fieldApiName]: this.recordId,
        };

        createRecord({ apiName: CONTACT_OBJECT.objectApiName, fields })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact added successfully!',
                        variant: 'success',
                    })
                );
                this.template.querySelector('[data-id="firstName"]').value = '';
                this.template.querySelector('[data-id="lastName"]').value = '';
                this.template.querySelector('[data-id="email"]').value = '';
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error adding contact',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }
}
