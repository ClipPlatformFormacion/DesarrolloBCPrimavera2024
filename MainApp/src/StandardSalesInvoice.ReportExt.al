reportextension 50100 "CLIP Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(CLIP_Course_Edition; "CLIP Course Edition") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field("CLIP UnTexto"; 'Un texto')
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
        layout("CLIP SalesInvoiceWithEdition")
        {
            Type = RDLC;
            LayoutFile = 'src/StandardSalesInvoice.rdl';
        }
    }
}