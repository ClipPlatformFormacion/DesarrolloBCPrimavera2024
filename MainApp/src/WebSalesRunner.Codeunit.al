namespace ClipPlatform.Course.Sales;
using Microsoft.Sales.Customer;

codeunit 50105 "Web Sales Runner"
{
    trigger OnRun()
    begin
        ProcessCourseWebSales();
    end;

    local procedure ProcessCourseWebSales()
    var
        CourseWebSales: Record "Course Web Sales";
    begin
        CourseWebSales.SetRange(Status, "Processing Status"::" ");
        if CourseWebSales.FindSet() then
            repeat
                CourseWebSales.Status := CourseWebSales.Status::Processing;
                CourseWebSales.Modify();

                if ProcessCourseWebSale(CourseWebSales) then
                    CourseWebSales.Status := CourseWebSales.Status::Processed
                else begin
                    CourseWebSales.Status := CourseWebSales.Status::Error;
                    CourseWebSales."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(CourseWebSales."Error Message"));
                end;
                CourseWebSales.Modify();

                Commit();
            until CourseWebSales.Next() = 0;
    end;

    [TryFunction]
    local procedure ProcessCourseWebSale(CourseWebSales: Record "Course Web Sales")
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := CourseWebSales."Web Customer No.";
        Customer.Insert();

        if CourseWebSales."Entry No." = 3 then
            Error('Processing Course Web Sale %1', CourseWebSales."Entry No.");
    end;
}