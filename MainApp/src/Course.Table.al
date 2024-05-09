table 50100 "CLIP Course"
{
    LookupPageId = "CLIP Course List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ResSetup: Record "CLIP Courses Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    ResSetup.Get();
                    NoSeriesMgt.TestManual(ResSetup."Course Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = CustomerContent;
        }
        field(3; "Content Description"; Text[2048])
        {
            Caption = 'Content Description', Comment = 'ESP="Temario"';
            DataClassification = CustomerContent;
        }
        field(4; "Duration (hours)"; Integer)
        {
            Caption = 'Duration (hours)', Comment = 'ESP="Duración (horas)"';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(5; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(6; "Type (Option)"; Option)
        {
            Caption = 'Type (Option)', Comment = 'ESP="Tipo (Option)"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaption = ' ,Instructor-Lead,Video Tutorial', Comment = 'ESP=" ,Guiado por profesor,Vídeo tutorial"';
            DataClassification = CustomerContent;
        }
        field(7; "Type (Enum)"; Enum "CLIP Course Type")
        {
            Caption = 'Type (Enum)', Comment = 'ESP="Tipo (Enum)"';
            DataClassification = CustomerContent;
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'ESP="Nº serie"';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(51; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ESP="Grupo contable prod. gen."';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(58; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ESP="Grupo contable IVA prod."';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Type (Enum)", "Duration (hours)") { }
        fieldgroup(Brick; "No.", Name, "Type (Enum)", Price) { }
    }

    trigger OnInsert()
    var
        ResSetup: Record "CLIP Courses Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            ResSetup.Get();
            ResSetup.TestField("Course Nos.");
            NoSeriesMgt.InitSeries(ResSetup."Course Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure AssistEdit(OldRes: Record "CLIP Course") Result: Boolean
    var
        Res: Record "CLIP Course";
        ResSetup: Record "CLIP Courses Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldRes, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Res := Rec;
        ResSetup.Get();
        ResSetup.TestField("Course Nos.");
        if NoSeriesMgt.SelectSeries(ResSetup."Course Nos.", OldRes."No. Series", Res."No. Series") then begin
            ResSetup.Get();
            ResSetup.TestField("Course Nos.");
            NoSeriesMgt.SetSeries(Res."No.");
            Rec := Res;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Course: Record "CLIP Course"; xCourse: Record "CLIP Course"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Course: Record "CLIP Course"; var IsHandled: Boolean; var xCourse: Record "CLIP Course")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Course: Record "CLIP Course"; xOldCourse: Record "CLIP Course"; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;
}