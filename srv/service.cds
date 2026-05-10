using { ResilienceCockpit as my } from '../db/schema.cds';

using { API_INFORECORD_PROCESS_SRV as external } from './external/API_INFORECORD_PROCESS_SRV';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.bypass
    @odata.draft.enabled
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers
        actions
        {
            action upRate
            (
            ) returns AlternateSuppliers;

            action downRate
            (
            ) returns AlternateSuppliers;
        };

    @cds.redirection.target
    entity SupplierParts as
        projection on my.SupplierParts{
            *,
            0 as shippingCost: Integer
        };

    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateParts as
        projection on my.AlternateParts;

    @cds.redirection.target
    entity A_PurchasingInfoRecord as
        projection on external.A_PurchasingInfoRecord{
            *,
            0 as Lat : Decimal(10,7),
            0 as Lng : Decimal(10,7)
        };
}

annotate ResilienceCockpitService with @requires :
[
    'authenticated-user'
];
