report 50101 "CLIP Courses & Editions"
{
    Caption = 'Courses & Editions', comment = 'ESP="Cursos y Ediciones"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutRDLC;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            dataitem(CourseEdition; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");
            }
            column(No; "No.") { IncludeCaption = true; }
            column(Name; "Name") { IncludeCaption = true; }
            column(DurationHours; "Duration (hours)") { IncludeCaption = true; }
        }
    }

    rendering
    {
        layout(LayoutRDLC)
        {
            Type = RDLC;
            LayoutFile = 'src/CoursesEdition.rdl';
        }
    }
}