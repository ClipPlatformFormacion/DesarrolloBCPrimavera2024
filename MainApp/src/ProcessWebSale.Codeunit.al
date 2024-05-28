codeunit 50106 "Process Web Sale"
{
    TableNo = "Course Web Sales";

    trigger OnRun()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := Rec."Web Customer No.";
        if Customer.Insert() then;

        if Rec."Entry No." = 3 then
            Error('Processing Course Web Sale %1', Rec."Entry No.");
    end;
}