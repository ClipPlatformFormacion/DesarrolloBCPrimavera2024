namespace ClipPlatform.Course.Setup;

using ClipPlatform.Course.MasterData;

page 50102 "Courses Setup"
{
    AccessByPermission = TableData "Course" = R;
    ApplicationArea = All;
    Caption = 'Courses Setup', Comment = 'ESP="Conf. cursos"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Courses Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering', Comment = 'ESP="Numeración"';
                field("Course Nos."; Rec."Course Nos.")
                {
                    ToolTip = 'Specifies the number series code you can use to assign numbers to Courses.';
                }
            }
            group(SalesAutomatization)
            {
                Caption = 'Sales Automation', comment = 'ESP="Automatización ventas"';
                field("Customer Posting Group"; Rec."Customer Posting Group") { }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group") { }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { }
                field("Payment Terms Code"; Rec."Payment Terms Code") { }
                field("Payment Method Code"; Rec."Payment Method Code") { }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

