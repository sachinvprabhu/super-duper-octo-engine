using ResilienceCockpitService as service from '../../srv/service';
annotate service.AlternateSuppliers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'supplierNumber',
                Value : supplierNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'supplierName',
                Value : supplierName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Label : 'country_code',
                Value : country_code,
            },
            {
                $Type : 'UI.DataField',
                Value : rating,
                Label : 'rating',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Products by Supplier',
            ID : 'ProductsbySupplier',
            Target : 'supplierParts/@UI.LineItem#ProductsbySupplier',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>SupplierNumber}',
            Value : supplierNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'supplierName',
            Value : supplierName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'address',
            Value : address,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#rating',
            Label : 'rating',
        },
        {
            $Type : 'UI.DataField',
            Value : country.name,
            Label : 'Country',
        },
    ],
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : supplierName,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : country.name,
        },
    },
);

annotate service.SupplierParts with @(
    UI.LineItem #ProductsbySupplier : [
        {
            $Type : 'UI.DataField',
            Value : partNumber,
            Label : 'partNumber',
        },
        {
            $Type : 'UI.DataField',
            Value : leadTime,
            Label : 'leadTime',
        },
        {
            $Type : 'UI.DataField',
            Value : specification_voltage,
            Label : 'specification_voltage',
        },
        {
            $Type : 'UI.DataField',
            Value : specification_dimentions_length,
            Label : 'specification_dimentions_length',
        },
        {
            $Type : 'UI.DataField',
            Value : specification_dimentions_height,
            Label : 'specification_dimentions_height',
        },
        {
            $Type : 'UI.DataField',
            Value : specification_dimentions_breadth,
            Label : 'specification_dimentions_breadth',
        },
        {
            $Type : 'UI.DataField',
            Value : cost_currency_code,
            Label : 'cost_currency_code',
        },
        {
            $Type : 'UI.DataField',
            Value : cost_value,
            Label : 'cost_value',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Specifications',
            ID : 'Specifications',
            Target : '@UI.FieldGroup#Specifications',
        },
    ],
    UI.FieldGroup #Specifications : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : specification_voltage,
                Label : 'specification_voltage',
            },
            {
                $Type : 'UI.DataField',
                Value : specification_dimentions_length,
                Label : 'specification_dimentions_length',
            },
            {
                $Type : 'UI.DataField',
                Value : specification_dimentions_height,
                Label : 'specification_dimentions_height',
            },
            {
                $Type : 'UI.DataField',
                Value : specification_dimentions_breadth,
                Label : 'specification_dimentions_breadth',
            },
            {
                $Type : 'UI.DataField',
                Value : specifications,
                Label : 'specifications',
            },
        ],
    },
);

annotate service.SupplierParts with {
    specifications @UI.MultiLineText : true
};

