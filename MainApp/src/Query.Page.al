page 50105 "CLIP Query"
{
    Caption = 'Query', comment = 'ESP="Query"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Processing)
        {
            action(ExecuteQuery)
            {
                Caption = 'Execute Query', comment = 'ESP="Ejecutar query"';
                ApplicationArea = All;
                RunObject = query "CLIP Item Query";
                Image = ExecuteBatch;
            }

            action(UseQuery)
            {
                Caption = 'Use Query', comment = 'ESP="Usar query"';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemQuery: Query "CLIP Item Query";
                    Counter: Integer;
                    Vendorname: Text[100];
                begin
                    ItemQuery.SetFilter(ItemQuery.Unit_Cost, '>0');
                    ItemQuery.SetRange(ItemQuery.Vendor_Posting_Group, 'NAC');
                    ItemQuery.Open();

                    while ItemQuery.Read() do begin
                        Counter += 1;
                        Vendorname := ItemQuery.Name;
                    end;

                    ItemQuery.Close();
                    Message('Total records: %1', Counter);
                end;
            }
        }
    }
}