xmlport 50102 "Import Web Course Sales"
{
    Caption = 'Import Web Course Sales', comment = 'ESP="Importar ventas de cursos en la web"';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    UseRequestPage = false;
    DefaultFieldsValidation = false;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(CourseWebSales; "Course Web Sales")
            {
                SourceTableView = sorting("Entry No.");

                fieldelement(WebDocumentNo; CourseWebSales."Web Document No.") { }
                fieldelement(DocumentDate; CourseWebSales."Document Date") { }
                fieldelement(WebCustomerNo; CourseWebSales."Web Customer No.") { }
                fieldelement(CustomerName; CourseWebSales."Customer Name") { }
                fieldelement(CustomerAddress; CourseWebSales."Customer Address") { }
                fieldelement(VATRegistrationNo; CourseWebSales."VAT Registration No.") { }
                fieldelement(CourseNo; CourseWebSales."Course No.") { }
                fieldelement(CourseEdition; CourseWebSales."Course Edition") { }
                fieldelement(Quantity; CourseWebSales.Quantity) { }
                fieldelement(UnitPrice; CourseWebSales."Unit Price") { }
            }
        }
    }
}