pageextension 50103 "CLIP Posted SalesShptSubform" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition")
            {
                ApplicationArea = All;
            }
        }
    }
}