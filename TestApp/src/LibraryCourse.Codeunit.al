codeunit 50153 "CLIP Library - Course"
{
    procedure CreateCourse() Course: Record "CLIP Course"
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

    procedure CreateEdition(CourseNo: Code[20]) CourseEdition: Record "CLIP Course Edition"
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
        CoursesSetup: Record "CLIP Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        CoursesSetup.Get();
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}