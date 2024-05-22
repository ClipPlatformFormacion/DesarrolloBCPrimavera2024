query 50100 "Item Query"
{
    QueryType = Normal;
    OrderBy = descending(Name);
    TopNumberOfRows = 10;

    // SELECT No, Description, Base_Unit_of_Measure, Unit_Cost,Name, City FROM Item
    // INNER JOIN Vendor ON Vendor.No = Item.Vendor_No

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = "Replenishment System" = const(Purchase);
            column(No; "No.") { }
            column(Description; Description) { }
            column(Base_Unit_of_Measure; "Base Unit of Measure") { }
            column(Unit_Cost; "Unit Cost") { }

            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = Item."Vendor No.";
                SqlJoinType = LeftOuterJoin;
                column(Name; Name) { }
                column(City; City) { }
                filter(Vendor_Posting_Group; "Vendor Posting Group") { }
            }
        }
    }
}