namespace ClipPlatform.Course.Sales;

using Microsoft.Sales.Document;

pageextension 50100 "Sales Order Subform" extends "Sales Order Subform"
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