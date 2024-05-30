namespace ClipPlatform.Course.MasterData;

using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Setup;
using ClipPlatform.Course.Setup;

table 50100 "Course"
{
    Caption = 'Course', comment = 'ESP="Curso"';
    LookupPageId = "Course List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CoursesSetup: Record "Courses Setup";
                NoSeries: Codeunit "No. Series";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    CoursesSetup.Get();
                    NoSeries.TestManual(CoursesSetup."Course Nos.");
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
        field(7; "Type (Enum)"; Enum "Course Type")
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
        Course: Record Course;
        CoursesSetup: Record "Courses Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            CoursesSetup.Get();
            CoursesSetup.TestField("Course Nos.");
            "No. Series" := CoursesSetup."Course Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Course.ReadIsolation(IsolationLevel::ReadUncommitted);
            Course.SetLoadFields("No.");
            while Course.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
        end;
    end;

    procedure AssistEdit(OldRes: Record "Course") Result: Boolean
    var
        Res: Record "Course";
        ResSetup: Record "Courses Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldRes, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Res := Rec;
        ResSetup.Get();
        ResSetup.TestField("Course Nos.");
        if NoSeries.LookupRelatedNoSeries(ResSetup."Course Nos.", OldRes."No. Series", Res."No. Series") then begin
            Res."No." := NoSeries.GetNextNo(Res."No. Series");
            Rec := Res;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Course: Record "Course"; xCourse: Record "Course"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Course: Record "Course"; var IsHandled: Boolean; var xCourse: Record "Course")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Course: Record "Course"; xOldCourse: Record "Course"; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

#if MISIMBOLODEPREPROCESADO
    procedure MyProcedure()
    begin
        MiVariable := 1;
        Message('Hello World %1', MiVariable);
    end;

    var
        MiVariable: Integer;
#endif
}