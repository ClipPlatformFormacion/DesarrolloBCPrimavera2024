page 50107 "Course Web Sales"
{
    Caption = 'Course Web Sales', comment = 'ESP="Ventas de cursos en la web"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Course Web Sales";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Web Document No."; Rec."Web Document No.") { }
                field("Document Date"; Rec."Document Date") { }
                field("Web Customer No."; Rec."Web Customer No.") { }
                field("Customer Name"; Rec."Customer Name") { }
                field("Customer Address"; Rec."Customer Address") { }
                field("VAT Registration No."; Rec."VAT Registration No.") { }
                field("Course No."; Rec."Course No.") { }
                field("Course Edition"; Rec."Course Edition") { }
                field(Quantity; Rec.Quantity) { }
                field("Unit Price"; Rec."Unit Price") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}