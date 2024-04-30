page 50103 "CLIP Course Editions"
{
    Caption = 'Course Editions', Comment = 'ESP="Ediciones curso"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course Edition";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Course No."; Rec."Course No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Edition; Rec.Edition)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Max. Students"; Rec."Max. Students")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}