codeunit 50106 "Process Web Sale"
{
    TableNo = "Course Web Sales";

    trigger OnRun()
    begin
        ProcessWebSale(Rec);
    end;

    [CommitBehavior(CommitBehavior::Error)]
    local procedure ProcessWebSale(var Rec: Record "Course Web Sales")
    var
        SalesHeader: Record "Sales Header";
    begin
        CreateCustomer(Rec);
        SalesHeader := CreateSalesInvoice(Rec);
        PostSalesInvoice(SalesHeader);
    end;

    local procedure CreateCustomer(var CourseWebSales: Record "Course Web Sales")
    var
        Customer: Record Customer;
        CoursesSetup: Record "Courses Setup";
    begin
        if Customer.Get(CourseWebSales."Web Customer No.") then
            exit;

        CourseWebSales.TestField("VAT Registration No.");

        Customer.Init();
        Customer.Validate("No.", CourseWebSales."Web Customer No.");
        Customer.Validate(Name, CourseWebSales."Customer Name");
        Customer.Validate(Address, CourseWebSales."Customer Address");
        Customer.Validate("VAT Registration No.", CourseWebSales."VAT Registration No.");

        CoursesSetup.Get();
        Customer.Validate("Customer Posting Group", CoursesSetup."Customer Posting Group");
        Customer.Validate("Gen. Bus. Posting Group", CoursesSetup."Gen. Bus. Posting Group");
        Customer.Validate("VAT Bus. Posting Group", CoursesSetup."VAT Bus. Posting Group");
        Customer.Validate("Payment Terms Code", CoursesSetup."Payment Terms Code");
        Customer.Validate("Payment Method Code", CoursesSetup."Payment Method Code");

        Customer.Insert(true);
    end;

    local procedure CreateSalesInvoice(var CourseWebSales: Record "Course Web Sales") SalesHeader: Record "Sales Header"
    begin
        SalesHeader := CreateSalesHeader(CourseWebSales);
        CreateSalesLines(CourseWebSales);
    end;

    local procedure CreateSalesHeader(var CourseWebSales: Record "Course Web Sales") SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.Validate("No.", CourseWebSales."Web Document No.");
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", CourseWebSales."Web Customer No.");
        SalesHeader.Validate("Document Date", CourseWebSales."Document Date");

        SalesHeader.Validate("Posting Date", CourseWebSales."Document Date");
        SalesHeader.Validate("Posting No.", SalesHeader."No.");
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

    local procedure PostSalesInvoice(var SalesHeader: Record "Sales Header")
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesPost.SetSuppressCommit(true);
        SalesPost.Run(SalesHeader);
    end;
}