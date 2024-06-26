namespace ClipPlatform.Course.Permissions;

using ClipPlatform.Course.Setup;
using ClipPlatform.Course.MasterData;
using ClipPlatform.Course.Sales;
using ClipPlatform.Course.Posting;
using ClipPlatform.Course.Ledger;
using ClipPlatform.Course.Reporting;
using ClipPlatform.Sales;
using ClipPlatform.Item;
using ClipPlatform.CustomerLevel;
permissionset 50100 "Course"
{
    Assignable = true;
    Permissions =
        table Course = X,
        tabledata "Course" = RMID,
        table "Course Edition" = X,
        tabledata "Course Edition" = RMID,
        table "Courses Setup" = X,
        tabledata "Courses Setup" = RMID,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course List" = X,
        page "Courses Setup" = X,
        table "Course Ledger Entry" = X,
        tabledata "Course Ledger Entry" = RMID,
        codeunit "Course - Sales Management" = X,
        table "Course Journal Line" = X,
        tabledata "Course Journal Line" = RMID,
        page "Course Ledger Entries" = X,
        table "Resources Setup" = X,
        tabledata "Resources Setup" = RMID,
        codeunit "Blank Customer Level" = X,
        codeunit "Bronze Customer Level" = X,
        codeunit "Course Journal-Post Line" = X,
        codeunit "Silver Customer Level" = X,
        page "Query" = X,
        page "Resources Setup" = X,
        query "Item Query" = X,
        report "Courses & Editions" = X,
        report "Update Course Prices" = X,
        xmlport "Export Sales Orders" = X,
        xmlport "Import Courses" = X,
        table "Course Web Sales" = X,
        tabledata "Course Web Sales" = RMID,
        page "Course Web Sales" = X;
}