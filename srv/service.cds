using { ResilienceCockpit as my } from '../db/schema.cds';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.bypass
    @odata.draft.enabled
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers;

    @cds.redirection.target
    @odata.draft.enabled
    entity SupplierParts as
        projection on my.SupplierParts;

    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateParts as
        projection on my.AlternateParts;
}

annotate ResilienceCockpitService with @requires :
[
    'authenticated-user'
];
