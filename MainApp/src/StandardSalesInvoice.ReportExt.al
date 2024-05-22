reportextension 50100 "Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(CLIP_Course_Edition; "Course Edition") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field("UnTexto"; 'Un texto')
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            modify(DisplayShipmentInformation)
            {
                Visible = false;
            }
        }
    }

    rendering
    {
        layout("SalesInvoiceWithEdition")
        {
            Type = RDLC;
            LayoutFile = 'src/StandardSalesInvoice.rdl';
        }
    }
}