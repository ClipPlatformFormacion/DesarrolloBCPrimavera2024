namespace ClipPlatform.Course.Sales;

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

                ProcessCourseWebSale(CourseWebSales);

                CourseWebSales.Status := CourseWebSales.Status::Processed;
                CourseWebSales.Modify();

                Commit();
            until CourseWebSales.Next() = 0;
    end;

    local procedure ProcessCourseWebSale(CourseWebSales: Record "Course Web Sales")
    begin
        if CourseWebSales."Entry No." = 3 then
            Error('Processing Course Web Sale %1', CourseWebSales."Entry No.");
    end;
}