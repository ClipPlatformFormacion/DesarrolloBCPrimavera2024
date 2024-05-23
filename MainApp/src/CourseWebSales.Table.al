table 50106 "Course Web Sales"
{
    Caption = 'Course Web Sales', comment = 'ESP="Ventas de cursos en la web"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', comment = 'ESP="Nº movimiento"';
            AutoIncrement = true;
        }
        field(2; "Web Document No."; Code[20])
        {
            Caption = 'Web Document No.', comment = 'ESP="Nº documento web"';
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Document Date', comment = 'ESP="Fecha documento"';
        }
        field(4; "Web Customer No."; Code[20])
        {
            Caption = 'Web Customer No.', comment = 'ESP="Nº cliente web"';
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name', comment = 'ESP="Nombre cliente"';
        }
        field(6; "Customer Address"; Text[100])
        {
            Caption = 'Customer Address', comment = 'ESP="Dirección cliente"';
        }
        field(7; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.', comment = 'ESP="CIF/NIF"';
        }
        field(8; "Course No."; Code[20])
        {
            Caption = 'Course No.', comment = 'ESP="Nº curso"';
            TableRelation = Course;
        }
        field(9; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            TableRelation = "Course Edition";
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'ESP="Cantidad"';
        }
        field(11; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price', comment = 'ESP="Precio unitario"';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}