sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"nexus/resilience/cockpit/managesuppliers/test/integration/pages/AlternateSuppliersList",
	"nexus/resilience/cockpit/managesuppliers/test/integration/pages/AlternateSuppliersObjectPage",
	"nexus/resilience/cockpit/managesuppliers/test/integration/pages/SupplierPartsObjectPage"
], function (JourneyRunner, AlternateSuppliersList, AlternateSuppliersObjectPage, SupplierPartsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('nexus/resilience/cockpit/managesuppliers') + '/test/flp.html#app-preview',
        pages: {
			onTheAlternateSuppliersList: AlternateSuppliersList,
			onTheAlternateSuppliersObjectPage: AlternateSuppliersObjectPage,
			onTheSupplierPartsObjectPage: SupplierPartsObjectPage
        },
        async: true
    });

    return runner;
});

