permissionset 50100 "CLIP Course"
{
    Assignable = true;
    Permissions =
        table "CLIP Course" = X,
        tabledata "CLIP Course" = RMID,
        table "CLIP Course Edition" = X,
        tabledata "CLIP Course Edition" = RMID,
        table "CLIP Courses Setup" = X,
        tabledata "CLIP Courses Setup" = RMID,
        page "CLIP Course Card" = X,
        page "CLIP Course Editions" = X,
        page "CLIP Course List" = X,
        page "CLIP Courses Setup" = X,
        table "CLIP Course Ledger Entry" = X,
        tabledata "CLIP Course Ledger Entry" = RMID,
        codeunit "CLIP Course - Sales Management" = X,
        table "CLIP Course Journal Line" = X,
        tabledata "CLIP Course Journal Line" = RMID,
        page "CLIP Course Ledger Entries" = X;
}