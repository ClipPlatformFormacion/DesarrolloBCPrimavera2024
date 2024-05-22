namespace ClipPlatform.Course.MasterData;

using ClipPlatform.Course.Ledger;

page 50101 "Course Card"
{
    Caption = 'Course Card', Comment = 'ESP="Ficha curso"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Course";

    layout
    {
        area(Content)
        {
            group(Course)
            {
                Caption = 'Course', Comment = 'ESP="Curso"';
                field("No."; Rec."No.")
                {
                    ToolTip = 'A tooltip', Comment = 'ESP="Una ayuda"';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name) { }
            }
            group(TrainingDetails)
            {
                Caption = 'Training Details', Comment = 'ESP="Detalles formativos"';
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';
                field(Price; Rec.Price) { }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group") { }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(CourseEditions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                RunObject = page "Course Editions";
                RunPageLink = "Course No." = field("No.");
                Image = ListPage;
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = ResourceLedger;
                RunObject = Page "Course Ledger Entries";
                RunPageLink = "Course No." = field("No.");
                RunPageView = sorting("Course No.")
                                  order(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
        }
    }
}