codeunit 50152 "CLIP Course Testing"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourse: Codeunit "CLIP Library - Course";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
    begin
        // [Scenario] Al seleccionar un curso en una línea de venta, el sistema trae a la venta la información del curso

        // [Given] Un curso correctamente configurado
        //         Un documento de venta
        Course := LibraryCourse.CreateCourse();

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Seleccionar el curso en una línea de venta del documento
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Modify(true);

        // [Then] La línea tiene Descripción, Grupos Contables y Precio
        Assert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        Assert.AreEqual(course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        Assert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo contable no es correcto');
        Assert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo contable no es correcto');
    end;
}