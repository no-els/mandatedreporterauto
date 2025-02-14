List<Workshop__c> workshops = WorkshopController.searchWorkshops('Alvarado');
System.debug('Workshops found: ' + workshops);