codeunit 50152 "Course Testing"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record "Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourse: Codeunit "Library - Course";
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
        SalesLine.Validate(Type, "Sales Line Type"::"Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Modify(true);

        // [Then] La línea tiene Descripción, Grupos Contables y Precio
        Assert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        Assert.AreEqual(course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        Assert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo contable no es correcto');
        Assert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo contable no es correcto');
    end;

    [Test]
    procedure CourseSalesPosting_EditionInPostedDocuments()
    var
        Course: Record "Course";
        CourseEdition: Record "Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LibraryCourse: Codeunit "Library - Course";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta para un curso y edición, la edición se traslada correctamente a los documentos registrados

        // [Given] Un curso y una edición
        //          Un documento de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course."No.");

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [When] Registramos la venta
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición está en los documentos registrados
        SalesInvoiceLine.SetRange("Document No.", DocumentNo);
        SalesInvoiceLine.FindFirst();
        Assert.AreEqual(CourseEdition.Edition, SalesInvoiceLine."Course Edition", 'La edición en la línea de factura de venta no es correcto');
    end;

    [Test]
    procedure CourseSalesPosting_CourseLedgerEntry()
    var
        Course: Record "Course";
        CourseEdition: Record "Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "Course Ledger Entry";
        LibraryCourse: Codeunit "Library - Course";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta para un curso y edición, se genera un movimiento de curso

        // [Given] Un curso y una edición
        //          Un documento de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course."No.");

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [When] Registramos la venta
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición está en los documentos registrados
#pragma warning disable AA0210
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
#pragma warning restore
        Assert.AreEqual(1, CourseLedgerEntry.Count(), 'El Nº de movimientos es incorrecto');
        CourseLedgerEntry.FindFirst();

        Assert.AreEqual(SalesHeader."Posting Date", CourseLedgerEntry."Posting Date", 'Dato incorrecto');
        Assert.AreEqual(SalesLine."No.", CourseLedgerEntry."Course No.", 'Dato incorrecto');
        Assert.AreEqual(SalesLine."Course Edition", CourseLedgerEntry."Course Edition", 'Dato incorrecto');
        Assert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'Dato incorrecto');
        Assert.AreEqual(SalesLine.Quantity, CourseLedgerEntry.Quantity, 'Dato incorrecto');
        Assert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'Dato incorrecto');
        Assert.AreEqual(SalesLine.Quantity * SalesLine."Unit Price", CourseLedgerEntry."Total Price", 'Dato incorrecto');
        Assert.AreEqual(SalesHeader."Document Date", CourseLedgerEntry."Document Date", 'Dato incorrecto');
        Assert.AreEqual(SalesHeader."External Document No.", CourseLedgerEntry."External Document No.", 'Dato incorrecto');
    end;

    [Test]
    procedure CourseSalesPostingCreditMemo_CourseLedgerEntry()
    var
        Course: Record "Course";
        CourseEdition: Record "Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "Course Ledger Entry";
        LibraryCourse: Codeunit "Library - Course";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta para un curso y edición, se genera un movimiento de curso

        // [Given] Un curso y una edición
        //          Un documento de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course."No.");

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::"Credit Memo", '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [When] Registramos la venta
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición está en los documentos registrados
#pragma warning disable AA0210
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
#pragma warning restore
        Assert.AreEqual(1, CourseLedgerEntry.Count(), 'El Nº de movimientos es incorrecto');
        CourseLedgerEntry.FindFirst();

        Assert.AreEqual(SalesHeader."Posting Date", CourseLedgerEntry."Posting Date", 'Dato incorrecto');
        Assert.AreEqual(SalesLine."No.", CourseLedgerEntry."Course No.", 'Dato incorrecto');
        Assert.AreEqual(SalesLine."Course Edition", CourseLedgerEntry."Course Edition", 'Dato incorrecto');
        Assert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'Dato incorrecto');
        Assert.AreEqual(-SalesLine.Quantity, CourseLedgerEntry.Quantity, 'Dato incorrecto');
        Assert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'Dato incorrecto');
        Assert.AreEqual(-SalesLine.Quantity * SalesLine."Unit Price", CourseLedgerEntry."Total Price", 'Dato incorrecto');
        Assert.AreEqual(SalesHeader."Document Date", CourseLedgerEntry."Document Date", 'Dato incorrecto');
        Assert.AreEqual(SalesHeader."External Document No.", CourseLedgerEntry."External Document No.", 'Dato incorrecto');
    end;
}