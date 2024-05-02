codeunit 50151 "CLIP GetMin"
{
    procedure GetMin(p1: Integer; p2: Integer): Integer
    begin
        if p1 < p2 then
            exit(p1);
        exit(p2);
    end;
}