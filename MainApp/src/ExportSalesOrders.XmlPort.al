xmlport 50100 "CLIP Export Sales Orders"
{
    Caption = 'Export Sales Orders', comment = 'ESP="Exportación de Pedidos de Venta"';
    Direction = Export;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesOrder; "Sales Header")
            {
                SourceTableView = where("Document Type" = const("Order"));

                fieldattribute(ExternalDocumentNo; SalesOrder."External Document No.") { }
                fieldelement(No; SalesOrder."No.") { }
                fieldelement(CustomerNo; SalesOrder."Sell-to Customer No.") { }
                fieldelement(OrderDate; SalesOrder."Order Date") { }
                fieldelement(Currency; SalesOrder."Currency Code") { }

                tableelement(SalesOrderLine; "Sales Line")
                {
                    LinkTable = SalesOrder;
                    LinkFields = "Document Type" = field("Document Type"), "Document No." = field("No.");

                    // fieldelement(Type; SalesOrderLine."Type") { }
                    textelement(Type)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            Type := Format(SalesOrderLine."Type");
                        end;
                    }
                    fieldelement(No; SalesOrderLine."No.") { }
                    fieldelement(Description; SalesOrderLine."Description") { }
                    fieldelement(Quantity; SalesOrderLine."Quantity") { }
                    fieldelement(UnitPrice; SalesOrderLine."Unit Price") { }
                }
            }
        }
    }
}