namespace ClipPlatform.Course.Sales;

using Microsoft.Sales.History;

pageextension 50103 "Posted Sales Shpt. Subform" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Course Edition"; Rec."Course Edition")
            {
                ApplicationArea = All;
            }
        }
    }
}