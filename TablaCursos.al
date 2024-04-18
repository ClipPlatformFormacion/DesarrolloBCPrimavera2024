table 50100 Course
{
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Name; Text[100]) { }
        field(3; "Content Description"; Text[2048]) { }
        field(4; "Duration (hours)"; Integer) { }
        field(5; Price; Decimal) { }
        field(6; "Type (Option)"; Option)
        {
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
        }
        field(7; "Type (Enum)"; Enum "Course Type") { }
    }
}