namespace ClipPlatform.Course.Sales;

using ClipPlatform.Course;
using Microsoft.Utilities;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using ClipPlatform.Course.MasterData;
using Microsoft.Finance.GeneralLedger.Journal;
using ClipPlatform.Course.Posting;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 50100 "Course - Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", OnBeforeIncludeOption, '', false, false)]
    local procedure OptionLookupBuffer_OnBeforeIncludeOption(OptionLookupBuffer: Record "Option Lookup Buffer" temporary; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef)
    begin
        if Option <> "Sales Line Type"::"Course".AsInteger() then
            exit;

        Handled := true;
        Result := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, Quantity, false, false)]
    local procedure OnAfterValidate_Quantity_CheckSalesForCourseEdition(var Rec: Record "Sales Line")
    begin
        CheckSalesForCourseEdition(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Course Edition", false, false)]
    local procedure OnAfterValidate_CourseEdition_CheckSalesForCourseEdition(var Rec: Record "Sales Line")
    begin
        CheckSalesForCourseEdition(Rec);
    end;

    local procedure CheckSalesForCourseEdition(var Rec: Record "Sales Line")
    var
        CourseEdition: Record "Course Edition";
        // MaxStudentsExceededMsg: TextConst ENU = 'The current sale for course %1 edition %2 will exceed the maximum students %3 (%4)', ESP = 'La venta actual para el curso %1 edición %2 superará el número máximo de alumnos %3 (ventas previas: %4)';
        MaxStudentsExceededMsg: Label 'The current sale for course %1 edition %2 will exceed the maximum students %3 (%4)', Comment = 'ESP="La venta actual para el curso %1 edición %2 superará el número máximo de alumnos %3 (ventas previas: %4)"';
    begin
        if Rec.Type <> Rec.Type::"Course" then
            exit;
        if Rec."Course Edition" = '' then
            exit;

        CourseEdition.SetLoadFields("Max. Students", "Sales (Qty.)");
        CourseEdition.Get(Rec."No.", Rec."Course Edition");
        CourseEdition.CalcFields("Sales (Qty.)");
        if (CourseEdition."Sales (Qty.)" + Rec.Quantity) > CourseEdition."Max. Students" then
            Message(MaxStudentsExceededMsg,
                        Rec."No.",
                        Rec."Course Edition",
                        CourseEdition."Max. Students",
                        CourseEdition."Sales (Qty.)");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFieldsForNo', '', false, false)]
    local procedure SalesLine_OnAfterAssignFieldsForNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        if SalesLine.Type <> SalesLine.Type::"Course" then
            exit;
        CopyFromCourse(SalesLine, SalesHeader);
    end;

    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "Course";
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
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "Course"; SalesHeader: Record "Sales Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostSalesLineOnBeforePostSalesLine, '', false, false)]
    local procedure "Sales-Post_OnPostSalesLineOnBeforePostSalesLine"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line")
    begin
        if SalesLine.Type <> SalesLine.Type::"Course" then
            exit;
        PostCourseJournalLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo);
    end;

    local procedure PostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35])
    var
        CourseJournalLine: Record "Course Journal Line";
        CourseJournalPostLine: Codeunit "Course Journal-Post Line";
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