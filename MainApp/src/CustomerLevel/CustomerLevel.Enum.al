namespace ClipPlatform.CustomerLevel;

enum 50101 "Customer Level" implements "Customer Level"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', comment = 'ESP=" "';
        Implementation = "Customer Level" = "Blank Customer Level";
    }
    value(1; "Bronze")
    {
        Caption = 'Bronze', comment = 'ESP="Bronce"';
        Implementation = "Customer Level" = "Bronze Customer Level";
    }
    value(2; "Silver")
    {
        Caption = 'Silver', comment = 'ESP="Plata"';
        Implementation = "Customer Level" = "Silver Customer Level";
    }
}