namespace ClipPlatform.Course.Testing;

using ClipPlatform.Course.MasterData;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Setup;
using ClipPlatform.Course.Setup;

codeunit 50153 "Library - Course"
{
    procedure CreateCourse() Course: Record "Course"
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        LibraryERM: Codeunit "Library - ERM";
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibraryRandom.Init();
        CourseNoSeriesSetup();
        LibraryERM.FindGeneralPostingSetupInvtFull(GeneralPostingSetup);
        LibraryERM.FindVATPostingSetupInvt(VATPostingSetup);

        Clear(Course);
        Course.Insert(true);
        Course.Validate(Name, Course."No.");  // Validate Name as No. because value is not important.
        Course.Validate(Price, LibraryRandom.RandInt(100));  // Required field - value is not important.
        Course.Validate("Gen. Prod. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
        Course.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
        Course.Modify(true);
    end;

    procedure CreateEdition(CourseNo: Code[20]) CourseEdition: Record "Course Edition"
    var
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibraryRandom.Init();

        CourseEdition.Init();
        CourseEdition.Validate("Course No.", CourseNo);
        CourseEdition.Validate(Edition, LibraryRandom.RandText(20));
        CourseEdition.Validate("Start Date", LibraryRandom.RandDate(10));
        CourseEdition.Validate("Max. Students", LibraryRandom.RandIntInRange(10, 20));
        CourseEdition.Insert(true);
    end;

    local procedure CourseNoSeriesSetup()
    var
        CoursesSetup: Record "Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        if not CoursesSetup.Get() then begin
            CoursesSetup.Init();
            CoursesSetup.Insert(true);
        end;
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}