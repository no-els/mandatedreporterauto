import { LightningElement, track, api } from 'lwc';
import addParticipantToWorkshop from '@salesforce/apex/WorkshopSelectorController.addParticipantToWorkshop';
import removeParticipantFromWorkshop from '@salesforce/apex/WorkshopSelectorController.removeParticipantFromWorkshop';
import getWorkshopParticipants from '@salesforce/apex/WorkshopSelectorController.getWorkshopParticipants';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WorkshopManager extends LightningElement {
    @track selectedSite;
    @track selectedWorkshop;
    @track workshopParticipants = [];

    // Handle Site Selection
    handleSiteChange(event) {
        this.selectedSite = event.detail;
        this.selectedWorkshop = null; // Reset workshop when site changes
        this.workshopParticipants = [];

        console.log(`🔄 Site changed to: ${this.selectedSite}`);
        this.template.querySelector('c-workshop-selector')?.refreshWorkshops();

    }

    // Handle Workshop Selection
    handleWorkshopChange(event) {
        this.selectedWorkshop = event.detail;
        this.refreshParticipants();
    }

    handleAddParticipant(event) {
        const participantId = event.detail;
        console.log(`Adding participant: ${participantId}`);

        if (this.selectedWorkshop) {
            addParticipantToWorkshop({ workshopId: this.selectedWorkshop, participantId })
                .then(() => {
                    console.log('✅ Participant added successfully');
                    this.showToast('Success', 'Participant added successfully!', 'success');
                    this.refreshParticipants();
                })
                .catch(error => {
                    console.error('❌ Error adding participant:', error);
                    this.showToast('Error', 'Failed to add participant', 'error');
                });
        }
    }

     // ✅ Handle Removing Participant
     handleRemoveParticipant(event) {
        const participantId = event.detail;
        console.log(`Removing participant: ${participantId}`);

        if (this.selectedWorkshop) {
            removeParticipantFromWorkshop({ workshopId: this.selectedWorkshop, participantId })
                .then(() => {
                    console.log('✅ Participant removed successfully');
                    this.showToast('Success', 'Participant removed successfully!', 'success');
                    this.refreshParticipants();
                })
                .catch(error => {
                    console.error('❌ Error removing participant:', error);
                    this.showToast('Error', 'Failed to remove participant', 'error');
                });
        }
    }

    // Refresh Workshop Participants
    refreshParticipants() {
        if (this.selectedWorkshop) {
            getWorkshopParticipants({ workshopId: this.selectedWorkshop })
                .then(data => {
                    this.workshopParticipants = data;
                })
                .catch(error => {
                    console.error('❌ Error fetching participants:', error);
                });
        }
    }
    // Helper function to show a Toast message
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
