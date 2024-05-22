tableextension 50102 "Sales Shipment Line" extends "Sales Shipment Line"
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