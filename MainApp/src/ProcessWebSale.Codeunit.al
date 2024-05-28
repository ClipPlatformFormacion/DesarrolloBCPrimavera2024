codeunit 50106 "Process Web Sale"
{
    TableNo = "Course Web Sales";

    trigger OnRun()
    begin
        CreateCustomer(Rec);
        CreateSalesInvoice(Rec);
        PostSalesInvoice(Rec);
    end;

    local procedure CreateCustomer(var CourseWebSales: Record "Course Web Sales")
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CourseWebSales."Web Customer No.") then
            exit;

        Customer.Init();
        Customer.Validate("No.", CourseWebSales."Web Customer No.");
        Customer.Validate(Name, CourseWebSales."Customer Name");
        Customer.Validate(Address, CourseWebSales."Customer Address");
        Customer.Validate("VAT Registration No.", CourseWebSales."VAT Registration No.");
        Customer.Insert(true);
    end;

    local procedure CreateSalesInvoice(var CourseWebSales: Record "Course Web Sales")
    begin
        Error('Procedure CreateSalesInvoice not implemented.');
    end;

    local procedure PostSalesInvoice(var CourseWebSales: Record "Course Web Sales")
    begin
        Error('Procedure PostSalesInvoice not implemented.');
    end;
}