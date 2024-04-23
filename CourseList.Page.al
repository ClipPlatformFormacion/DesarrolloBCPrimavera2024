page 50100 "Course List"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
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
}