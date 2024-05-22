namespace ClipPlatform.CustomerLevel;

using Microsoft.Sales.Customer;

pageextension 50106 "Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Level"; Rec."Level")
            {
                ApplicationArea = All;
            }
            field("Discount"; Rec."Discount")
            {
                ApplicationArea = All;
            }
        }
    }
}