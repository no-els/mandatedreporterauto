import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AutoDeselectUI extends LightningElement {
    handleAutoDeselect() {
        // Find all instances of the c-attendance-row component
        const attendanceRows = Array.from(document.querySelectorAll('c-attendance-row'));

        let buttonsClicked = 0;

        // Iterate over each c-attendance-row and attempt to find the button
        attendanceRows.forEach(row => {
            // Check if shadowRoot is available (indicating the component has a Shadow DOM)
            if (row.shadowRoot) {
                // Look for the button inside the shadow DOM
                const button = row.shadowRoot.querySelector('button[title="Don\'t create an attendance service delivery for this person"]');
                if (button) {
                    button.click(); // Click the button to deselect
                    buttonsClicked++;
                }
            }
        });

        // Show a toast message based on the outcome
        this.dispatchEvent(
            new ShowToastEvent({
                title: buttonsClicked > 0 ? 'Deselect Complete' : 'Deselect Failed',
                message: buttonsClicked > 0 ? `${buttonsClicked} attendees have been deselected successfully.` : 'No deselect buttons found.',
                variant: buttonsClicked > 0 ? 'success' : 'error'
            })
        );
    }
}
