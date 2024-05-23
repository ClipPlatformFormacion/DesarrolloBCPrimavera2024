namespace ClipPlatform.Course.MasterData;

using ClipPlatform.Course.Ledger;

page 50100 "Course List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Course";
    CardPageId = "Course Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Price; Rec.Price) { }
                field("Type (Option)"; Rec."Type (Option)") { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportCourses)
            {
                ApplicationArea = All;
                Caption = 'Import Courses', Comment = 'ESP="Importación de Cursos"';
                Image = Import;
                RunObject = XmlPort "Import Courses";
                ToolTip = 'Import courses from an XML file.';
                Promoted = true;
                PromotedOnly = true;
            }
        }
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