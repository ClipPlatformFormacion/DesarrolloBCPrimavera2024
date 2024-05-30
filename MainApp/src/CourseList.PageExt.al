pageextension 50107 "Course List" extends "Course List"
{
    layout
    {
        addlast(RepeaterControl)
        {
            field("Un nuevo campo"; Rec."Un nuevo campo") { ApplicationArea = All; }
        }
    }
}