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
        CreateSalesHeader(CourseWebSales);
        CreateSalesLines(CourseWebSales);
    end;

    local procedure CreateSalesHeader(var CourseWebSales: Record "Course Web Sales")
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.Validate("No.", CourseWebSales."Web Document No.");
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", CourseWebSales."Web Customer No.");
        SalesHeader.Validate("Document Date", CourseWebSales."Document Date");
        SalesHeader.Validate("Posting Date", CourseWebSales."Document Date");
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLines(var CourseWebSales: Record "Course Web Sales")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesLine."Document Type"::Invoice);
        SalesLine.Validate("Document No.", CourseWebSales."Web Document No.");
        SalesLine.Validate("Line No.", 10000);
        SalesLine.Insert(true);

        SalesLine.Validate("Type", SalesLine.Type::Course);
        SalesLine.Validate("No.", CourseWebSales."Course No.");
        SalesLine.Validate("Course Edition", CourseWebSales."Course Edition");
        SalesLine.Validate("Quantity", CourseWebSales."Quantity");
        SalesLine.Validate("Unit Price", CourseWebSales."Unit Price");
        SalesLine.Modify(true);
    end;

    local procedure PostSalesInvoice(var CourseWebSales: Record "Course Web Sales")
    begin
        Error('Procedure PostSalesInvoice not implemented.');
    end;


}