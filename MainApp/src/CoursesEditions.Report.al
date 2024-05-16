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

                column(Edition; Edition) { IncludeCaption = true; }
                column(EditionMaxStudents; "Max. Students") { IncludeCaption = true; }
                column(EditionStartDate; "Start Date") { IncludeCaption = true; }
                column(EditionSalesQty; "Sales (Qty.)") { IncludeCaption = true; }
            }
            column(PrintDetails; PrintDetails) { }
            column(ReportCaption; ReportCaptionLbl) { }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName()) { }
            column(CourseNo; "No.") { IncludeCaption = true; }
            column(CourseName; "Name") { IncludeCaption = true; }
            column(CourseDurationHours; "Duration (hours)") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PrintDetailsControl; PrintDetails)
                    {
                        Caption = 'PrintDetails', comment = 'ESP="Imprimir detalles"';
                        ApplicationArea = All;
                    }
                }
            }
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
    var
        PrintDetails: boolean;
        ReportCaptionLbl: Label 'Courses & Editions', comment = 'ESP="Cursos y Ediciones"';
}