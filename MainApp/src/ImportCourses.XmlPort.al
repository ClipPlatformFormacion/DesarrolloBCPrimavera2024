xmlport 50101 "CLIP Import Courses"
{
    Caption = 'Import Courses', comment = 'ESP="Importación de Cursos"';
    Direction = Import;

    schema
    {
        textelement(Root)
        {
            tableelement(Course; "CLIP Course")
            {
                // AutoUpdate = true;
                // AutoReplace = true;
                UseTemporary = true;
                fieldelement(No; Course."No.") { }
                fieldelement(Name; Course."Name") { }
                fieldelement(Duration; Course."Duration (hours)") { }
                fieldelement(GenProdPostingGroup; Course."Gen. Prod. Posting Group") { }
                fieldelement(VATProdPostingGroup; Course."VAT Prod. Posting Group") { }
                textelement(ContentDescription) { }

                trigger OnBeforeInsertRecord()
                var
                    RealCourse: Record "CLIP Course";
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