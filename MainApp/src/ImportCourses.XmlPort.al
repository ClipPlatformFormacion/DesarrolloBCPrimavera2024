xmlport 50101 "CLIP Import Courses"
{
    Caption = 'Import Courses', comment = 'ESP="Importación de Cursos"';
    Direction = Export;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement(Course; "Course")
            {
                // AutoUpdate = true;
                // AutoReplace = true;
                // UseTemporary = true;
                fieldelement(No; Course."No.") { Width = 20; }
                fieldelement(Name; Course."Name") { Width = 50; }
                fieldelement(Duration; Course."Duration (hours)") { Width = 10; }
                fieldelement(GenProdPostingGroup; Course."Gen. Prod. Posting Group") { Width = 20; }
                fieldelement(VATProdPostingGroup; Course."VAT Prod. Posting Group") { Width = 20; }
                textelement(ContentDescription) { Width = 250; }

                trigger OnBeforeInsertRecord()
                var
                    RealCourse: Record "Course";
                begin
                    Course.Price := Course."Duration (hours)" * 100;
                    Course."Content Description" := 'TEMARIO DEL XMLPORT: ' + ContentDescription;

                    if Course.Price > 1000 then begin
                        RealCourse := Course;
                        RealCourse.Insert(true);
                    end;
                end;

                trigger OnBeforeModifyRecord()
                begin
                    Course.Price := Course."Duration (hours)" * 100;
                    Course."Content Description" := 'TEMARIO DEL XMLPORT: ' + ContentDescription;
                end;
            }
        }
    }
}