sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("nexus.resilience.cockpit.suppliergeo.controller.HomePage", {
        onInit() {
            const oProvider = this.byId("mapProvider");
			const osm = sap.ui.require.toUrl("nexus/resilience/cockpit/suppliergeo/model/osm.json");
            
			setTimeout(() => {
                oProvider.setStyleUrl(osm);
			});
        }
    });
});