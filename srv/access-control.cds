
using { ResilienceCockpitService } from './service';

annotate ResilienceCockpitService with @requires :
[
    'NX-SC-USER'
];


annotate ResilienceCockpitService.AlternateSuppliers with @restrict :
[
    { grant : 'READ', to:'NX-SC-ANL' },
    { grant : ['READ','WRITE'], to:'NX-SC-MGR' },
    { grant : ['READ','WRITE'], to:'NX-PR-ANL', where : ( createdBy = $user ) },
    { grant : ['READ'], to:'NX-PR-ANL'}
];