namespace ClipPlatform.Tables;

table 50105 "Resources Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; MyField; Integer)
        {

        }
    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}