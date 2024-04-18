page 50101 "Course Card"
{
    CaptionML = ENU = 'Course Card', ESP = 'Ficha curso';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Course;

    layout
    {
        area(Content)
        {
            group(Course)
            {
                CaptionML = ENU = 'Course', ESP = 'Curso';
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
            }
            group(TrainingDetails)
            {
                CaptionML = ENU = 'Training Details', ESP = 'Detalles formativos';
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field(Price; Rec.Price) { }
            }
        }
    }
}