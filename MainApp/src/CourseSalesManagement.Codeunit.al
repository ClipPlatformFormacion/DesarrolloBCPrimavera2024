codeunit 50100 "CLIP Course - Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", OnBeforeIncludeOption, '', false, false)]
    local procedure OptionLookupBuffer_OnBeforeIncludeOption(OptionLookupBuffer: Record "Option Lookup Buffer" temporary; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef)
    begin
        if Option <> "Sales Line Type"::"CLIP Course".AsInteger() then
            exit;

        Handled := true;
        Result := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFieldsForNo', '', false, false)]
    local procedure SalesLine_OnAfterAssignFieldsForNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;
        CopyFromCourse(SalesLine, SalesHeader);
    end;

    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "CLIP Course";
    begin
        Course.Get(SalesLine."No.");

        Course.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Course.Name;
        SalesLine."Unit Price" := Course.Price;
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        SalesLine."Allow Item Charge Assignment" := false;

        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "CLIP Course"; SalesHeader: Record "Sales Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostSalesLineOnBeforePostSalesLine, '', false, false)]
    local procedure "Sales-Post_OnPostSalesLineOnBeforePostSalesLine"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line")
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;
        PostCourseJournalLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo);
    end;

    local procedure PostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35])
    var
        CourseJournalLine: Record "CLIP Course Journal Line";
        CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line";
        ShouldExit: Boolean;
    begin
        ShouldExit := SalesLine."Qty. to Invoice" = 0;
        if ShouldExit then
            exit;

        CourseJournalLine.Init();
        CourseJournalLine.CopyFromSalesHeader(SalesHeader);
        CourseJournalLine.CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SalesHeader."Posting No. Series");
        CourseJournalLine.CopyFromSalesLine(SalesLine);

        CourseJournalPostLine.RunWithCheck(CourseJournalLine);
    end;
}