namespace ClipPlatform;

using ClipPlatform.Tables;
using ClipPlatform.CustomerLevel;
using ClipPlatform.Pages;
using ClipPlatform.Course;
permissionset 50100 "CLIP Course"
{
    Assignable = true;
    Permissions =
        table Course = X,
        tabledata "Course" = RMID,
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
        page "CLIP Course Ledger Entries" = X,
        table "Resources Setup" = X,
        tabledata "Resources Setup" = RMID,
        codeunit "Blank Customer Level" = X,
        codeunit "CLIP Bronze Customer Level" = X,
        codeunit "CLIP Course Journal-Post Line" = X,
        codeunit "CLIP Silver Customer Level" = X,
        page "CLIP Query" = X,
        page "Resources Setup" = X,
        query "CLIP Item Query" = X,
        report "CLIP Courses & Editions" = X,
        report "CLIP Update Course Prices" = X,
        xmlport "CLIP Export Sales Orders" = X,
        xmlport "CLIP Import Courses" = X,
        table "Course Web Sales" = X,
        tabledata "Course Web Sales" = RMID,
        page "Course Web Sales" = X;
}