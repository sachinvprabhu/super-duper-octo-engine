namespace ResilienceCockpit;

entity AlternateSuppliers
{
    key ID : UUID;
    supplierNumber : Integer;
    supplierName : String;
    address : String;
    country : String(100);
    rating : Integer;
}
