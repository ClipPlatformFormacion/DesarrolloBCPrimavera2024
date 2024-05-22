namespace ClipPlatform.Testing;

codeunit 50151 "GetMin"
{
    procedure GetMin(p1: Integer; p2: Integer): Integer
    begin
        if p2 < p1 then
            exit(p2);
        exit(p1);
    end;
}