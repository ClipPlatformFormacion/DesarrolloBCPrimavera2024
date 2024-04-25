page 50100 "CLIP Course List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    CardPageId = "CLIP Course Card";
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
        area(Navigation)
        {
            action(CourseEditions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                RunObject = page "CLIP Course Editions";
                RunPageLink = "Course No." = field("No.");
                Image = ListPage;
            }
        }
    }
}