namespace ClipPlatform.Course.MasterData;

enum 50100 "Course Type"
{
    Extensible = true;

    value(0; " ") { Caption = ' ', Comment = 'ESP=" "'; }
    value(1; "Instructor-Lead") { Caption = 'Instructor-Lead', Comment = 'ESP="Guiado por profesor"'; }
    value(2; "Video Tutorial") { Caption = 'Video Tutorial', Comment = 'ESP="Vídeo tutorial"'; }
}