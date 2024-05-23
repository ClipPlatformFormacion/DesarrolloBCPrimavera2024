namespace ClipPlatform.Course.Sales;

using Microsoft.Sales.History;
using ClipPlatform.Course.Sales;

pageextension 50102 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Course Edition"; Rec."Course Edition")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}