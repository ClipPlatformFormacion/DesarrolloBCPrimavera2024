namespace ClipPlatform.CustomerLevel;

codeunit 50104 "Silver Customer Level" implements "Customer Level"
{
    procedure GetDiscount(): Decimal
    begin
        exit(10);
    end;
}