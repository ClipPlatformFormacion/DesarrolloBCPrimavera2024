namespace ClipPlatform.Course.Sales;

using Microsoft.Sales.Archive;
using ClipPlatform.Course.MasterData;

tableextension 50105 "Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("Course")) "Course";
        }
        field(50100; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "Course Edition".Edition where("Course No." = field("No."));
        }
    }
}