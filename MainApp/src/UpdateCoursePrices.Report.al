report 50100 "CLIP Update Course Prices"
{
    Caption = 'Update Course Prices', Comment = 'ESP="Actualiza los precios de los cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            // RequestFilterFields = "No.", Price, "Duration (hours)";
            DataItemTableView = sorting("No.");

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
                Message('Iteraciones totales: %1', Counter);
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
    }

    var
        Counter: Integer;
        Percentaje: Decimal;
}