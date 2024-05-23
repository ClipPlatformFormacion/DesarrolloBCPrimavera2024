namespace ClipPlatform.Course.MasterData;

report 50100 "Update Course Prices"
{
    Caption = 'Update Course Prices', Comment = 'ESP="Actualiza los precios de los cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Course; "Course")
        {
            // RequestFilterFields = "No.", Price, "Duration (hours)";
#pragma warning disable AL0254
            DataItemTableView = sorting("No.");
#pragma warning restore AL0254

            dataitem(CourseEdition; "Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    Counter += 1;
                end;

                trigger OnPostDataItem()
                begin
                    Message('OnPostDataItem Ediciones: %1', Counter);
                end;
            }

            trigger OnPreDataItem()
            begin
                // Código previo a la ejecución del bucle
            end;

            trigger OnAfterGetRecord()
            begin
                // Código de cada una de las iteraciones
                Counter += 1;

                Course.Validate(Price, Course.Price * (1 + Percentaje / 100));
                Course.Modify();
            end;

            trigger OnPostDataItem()
            begin
                // Código posterior a la ejecución del bucle                
                Message('OnPostDataItem Cursos: %1', Counter);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PercentajeControl; Percentaje)
                    {
                        Caption = 'Percentaje', comment = 'ESP="Porcentaje"';
                        ApplicationArea = All;
                        ToolTip = 'Percentaje by which prices will be incremented', comment = 'ESP="Porcentaje de incremento de los precios"';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            Percentaje := 10;
        end;
    }

    trigger OnPreReport()
    var
        PercentajeCannotBeNegativeErr: Label 'The percentaje cannot be negative', comment = 'ESP="El porcentaje no puede ser negativo"';
    begin
        if Percentaje < 0 then
            Error(PercentajeCannotBeNegativeErr);
    end;

    trigger OnPostReport()
    begin
        Message('OnPostReport %1', Counter);
    end;

    var
        Counter: Integer;
        Percentaje: Decimal;
}