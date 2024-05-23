namespace ClipPlatform.Course.Sales;

using Microsoft.Sales.Document;

pageextension 50104 "Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
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