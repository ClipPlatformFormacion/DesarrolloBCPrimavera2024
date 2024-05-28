codeunit 50106 "Process Web Sale"
{
    var
        GlobalCourseWebSales: Record "Course Web Sales";

    trigger OnRun()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer."No." := GlobalCourseWebSales."Web Customer No.";
        if Customer.Insert() then;

        if GlobalCourseWebSales."Entry No." = 3 then
            Error('Processing Course Web Sale %1', GlobalCourseWebSales."Entry No.");
    end;

    procedure SetParameters(CourseWebSales: Record "Course Web Sales")
    begin
        GlobalCourseWebSales := CourseWebSales;
    end;
}