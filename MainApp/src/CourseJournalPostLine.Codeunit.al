codeunit 50101 "CLIP Course Journal-Post Line"
{
    Permissions = TableData "CLIP Course Ledger Entry" = rimd;
    TableNo = "CLIP Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ResJournalLineGlobal: Record "CLIP Course Journal Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        Course: Record "Course";
        // ResJnlCheckLine: Codeunit "Res. Jnl.-Check Line";
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var ResJournalLine: Record "CLIP Course Journal Line")
    begin
        ResJournalLineGlobal.Copy(ResJournalLine);
        Code();
        ResJournalLine := ResJournalLineGlobal;
    end;

    local procedure "Code"()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(ResJournalLineGlobal, IsHandled);
        if not IsHandled then begin
            if ResJournalLineGlobal.EmptyLine() then
                exit;

            // ResJnlCheckLine.RunCheck(ResJournalLineGlobal);

            if NextEntryNo = 0 then begin
                CourseLedgerEntry.LockTable();
                NextEntryNo := CourseLedgerEntry.GetLastEntryNo() + 1;
            end;

            if ResJournalLineGlobal."Document Date" = 0D then
                ResJournalLineGlobal."Document Date" := ResJournalLineGlobal."Posting Date";

            Course.Get(ResJournalLineGlobal."Course No.");

            CourseLedgerEntry.Init();
            CourseLedgerEntry.CopyFromResJnlLine(ResJournalLineGlobal);

            GetGLSetup();
            CourseLedgerEntry."Total Price" := Round(CourseLedgerEntry."Total Price");
            CourseLedgerEntry."Entry No." := NextEntryNo;

            OnBeforeCourseLedgerEntryInsert(CourseLedgerEntry, ResJournalLineGlobal);

            CourseLedgerEntry.Insert(true);

            NextEntryNo := NextEntryNo + 1;
        end;

        OnAfterPostCourseJournalLine(ResJournalLineGlobal, CourseLedgerEntry);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var CourseLedgerEntry: Record "CLIP Course Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCourseLedgerEntryInsert(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;
}

