namespace ResilienceCockpit;

using from '@sap/cds-common-content';
using { Country, cuid , managed, Currency } from '@sap/cds/common';

entity AlternateSuppliers : cuid, managed
{
    supplierNumber : Integer;
    supplierName : String;
    address : String;
    country : Country;
    rating : Integer;
    supplierParts : Association to many SupplierParts on supplierParts.supplier = $self;
}

entity SupplierParts : cuid
{
    partNumber : Integer;
    leadTime : Integer;
    cost : Price;
    specifications : String;
    supplier : Association to one AlternateSuppliers;
    specification : Specification;
    alternateParts : Association to many AlternateParts on alternateParts.alternatePart = $self;
}

type Specification
{
    voltage : String(100);
    dimentions : Dimentions;
}

type Dimentions
{
    length : Integer;
    breadth : Integer;
    height : Integer;
}

entity AlternateParts : cuid
{
    originalPartNumber : Integer;
    alternatePart : Association to one SupplierParts;
    percentMatch : Integer;
}


type Price : Currency;