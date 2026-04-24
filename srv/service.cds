using { ResilienceCockpit as my } from '../db/schema.cds';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers;
}

annotate ResilienceCockpitService with @requires :
[
    'authenticated-user'
];
