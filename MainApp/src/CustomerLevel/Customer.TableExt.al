tableextension 50106 "CLIP Customer" extends Customer
{
    fields
    {
        field(50100; "CLIP Discount"; Decimal)
        {
            Caption = 'Discount', comment = 'ESP="Descuento"';
            DataClassification = CustomerContent;
        }
        field(50101; "CLIP Level"; Enum "CLIP Customer Level")
        {
            Caption = 'Level', comment = 'ESP="Nivel"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UnknownLevelErr: Label 'Unknown Level %1', Comment = 'ESP="Nivel desconocido %1"';
                Handled: Boolean;
            begin
                case Rec."CLIP Level" of
                    Rec."CLIP Level"::" ":
                        Rec."CLIP Discount" := 0;
                    Rec."CLIP Level"::Bronze:
                        Rec."CLIP Discount" := 5;
                    Rec."CLIP Level"::Silver:
                        Rec."CLIP Discount" := 10;
                    else
                        "CLIP OnValidateCustomerLevelOnBeforeUnknownLevelError"(Rec, Handled);
                        if not Handled then
                            Error(UnknownLevelErr, Rec."CLIP Level");
                end;
            end;
        }
    }

    [IntegrationEvent(false, false)]
    local procedure "CLIP OnValidateCustomerLevelOnBeforeUnknownLevelError"(var Customer: Record Customer; var Handled: Boolean)
    begin

    end;
}