codeunit 50150 "CLIP Framework Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    begin

    end;

    [Test]
    procedure Test002()
    begin
        Error('Un error del test');
    end;

    [Test]
    procedure GetMin_T001()
    var
        GetMin: Codeunit "CLIP GetMin";
        ValorA: Integer;
        ValorB: Integer;
        Resultado: Integer;
    begin
        // [Scenario] La función GetMin devuelve el menor de 2 números

        // [Given] ValorA = 1
        //         ValorB = 2
        ValorA := 1;
        ValorB := 2;

        // [When] Se ejecuta la función GetMin
        Resultado := GetMin.GetMin(ValorA, ValorB);

        // [Then] El resultado tiene que ser ValorA
        if Resultado <> ValorA then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure GetMin_T002()
    var
        GetMin: Codeunit "CLIP GetMin";
        ValorA: Integer;
        ValorB: Integer;
        Resultado: Integer;
    begin
        // [Scenario] La función GetMin devuelve el menor de 2 números

        // [Given] ValorA = 2
        //         ValorB = 1
        ValorA := 2;
        ValorB := 1;

        // [When] Se ejecuta la función GetMin
        Resultado := GetMin.GetMin(ValorA, ValorB);

        // [Then] El resultado tiene que ser ValorB
        if Resultado <> ValorB then
            Error('El resultado no es correcto');
    end;
}