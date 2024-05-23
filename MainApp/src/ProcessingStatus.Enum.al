namespace ClipPlatform.Course.Sales;

enum 50102 "Processing Status"
{
    Extensible = true;

    value(0; " ") { Caption = ' ', comment = 'ESP=" "'; }
    value(1; "Processed") { Caption = 'Processed', comment = 'ESP="Procesado"'; }
    value(2; "Error") { Caption = 'Error', comment = 'ESP="Error"'; }
}