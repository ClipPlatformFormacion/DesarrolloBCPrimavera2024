tableextension 50100 "CLIP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CheckSalesForCourseEdition();
            end;
        }
        field(50100; "CLIP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));

            trigger OnValidate()
            begin
                CheckSalesForCourseEdition();
            end;
        }
    }

    local procedure CheckSalesForCourseEdition()
    var
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        CourseEdition: Record "CLIP Course Edition";
        TotalQuantity: Decimal;
    begin
        if Rec.Type <> Rec.Type::"CLIP Course" then
            exit;
        if Rec."CLIP Course Edition" = '' then
            exit;

        CourseLedgerEntry.SetRange("Course No.", Rec."No.");
        CourseLedgerEntry.SetRange("Course Edition", Rec."CLIP Course Edition");
        if CourseLedgerEntry.FindSet() then
            repeat
                TotalQuantity := TotalQuantity + CourseLedgerEntry.Quantity;
            until CourseLedgerEntry.Next() = 0;

        CourseEdition.Get(Rec."No.", Rec."CLIP Course Edition");
        if (TotalQuantity + Rec.Quantity) > CourseEdition."Max. Students" then
            Message('La venta actual para el curso %1 edición %2 superará el número máximo de alumnos %3 (ventas previas: %4)',
                        Rec."No.", Rec."CLIP Course Edition", CourseEdition."Max. Students", TotalQuantity);
    end;
}