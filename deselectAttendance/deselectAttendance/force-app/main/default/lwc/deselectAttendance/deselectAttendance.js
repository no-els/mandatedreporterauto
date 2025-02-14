import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateAttendeeStatus from '@salesforce/apex/ServiceSessionUtilityController.updateAttendeeStatus';

export default class AutoDeselectAttendees extends LightningElement {
    @api recordId; // Service Session record ID

    handleAutoDeselect() {
        updateAttendeeStatus({ serviceSessionId: this.recordId, status: 'Not Present' })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'All attendees deselected successfully',
                        variant: 'success',
                    })
                );
                eval("$A.get('e.force:refreshView').fire();"); // This will refresh the page
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deselecting attendees',
                        message: error.body ? error.body.message : error.message,
                        variant: 'error',
                    })
                );
            });
    }
}
