permissionset 50100 "Course"
{
    Assignable = true;
    Permissions =
        table Course = X,
        tabledata Course = RMID,
        table "Course Edition" = X,
        tabledata "Course Edition" = RMID,
        table "Courses Setup" = X,
        tabledata "Courses Setup" = RMID,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course List" = X,
        page "Courses Setup" = X;
}