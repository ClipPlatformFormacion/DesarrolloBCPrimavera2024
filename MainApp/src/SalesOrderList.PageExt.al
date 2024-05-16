pageextension 50105 "CLIP Sales Order List" extends "Sales Order List"
{
    actions
    {
        addfirst("O&rder")
        {
            action("CLIP Export Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Export Sales Orders', comment = 'ESP="Exportación de Pedidos de Venta"';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "CLIP Export Sales Orders";
            }
        }
    }
}