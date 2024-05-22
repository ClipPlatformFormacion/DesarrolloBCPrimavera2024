tableextension 50106 "Customer" extends Customer
{
    fields
    {
        field(50100; "Discount"; Decimal)
        {
            Caption = 'Discount', comment = 'ESP="Descuento"';
            DataClassification = CustomerContent;
        }
        field(50101; "Level"; Enum "Customer Level")
        {
            Caption = 'Level', comment = 'ESP="Nivel"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CustomerLevel: Interface "Customer Level";
            begin
                CustomerLevel := Rec."Level";
                Rec."Discount" := CustomerLevel.GetDiscount();
            end;
        }
    }
}