codeunit 50154 "CLIP Customer Level Mgt."
{
    [EventSubscriber(ObjectType::Table, Database::Customer, "CLIP OnValidateCustomerLevelOnBeforeUnknownLevelError", '', false, false)]
    local procedure "Customer_CLIP OnValidateCustomerLevelOnBeforeUnknownLevelError"(var Customer: Record Customer; var Handled: Boolean)
    begin
        if Customer."CLIP Level" <> customer."CLIP Level"::"CLIP Gold" then
            exit;

        Customer."CLIP Discount" := 20;
        Handled := true;
    end;
}