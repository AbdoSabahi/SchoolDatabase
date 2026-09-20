USE SchoolDB;
GO

CREATE FUNCTION fn_CalculateAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE()) -
        CASE 
            WHEN (MONTH(@DateOfBirth) > MONTH(GETDATE())) 
                OR (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND DAY(@DateOfBirth) > DAY(GETDATE()))
            THEN 1 ELSE 0
        END;
END
GO

CREATE FUNCTION fn_GetCoursesByStudent (@StudentId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.CourseId,
        c.CourseName,
        e.Grade
    FROM Enrollment e
    JOIN Course c ON c.CourseId = e.CourseId
    WHERE e.StudentId = @StudentId
);
GO

CREATE FUNCTION fn_GetTopStudentsByCourse (@CourseId INT, @TopN INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@TopN)
        s.StudentId,
        s.FullName,
        e.Grade,
        RANK() OVER (ORDER BY e.Grade DESC) AS RankInCourse
    FROM Enrollment e
    JOIN Student s ON s.StudentId = e.StudentId
    WHERE e.CourseId = @CourseId
    AND e.Grade IS NOT NULL
);
GO

CREATE FUNCTION fn_IsPassed (@Grade DECIMAL(5,2))
RETURNS NVARCHAR(10)
AS
BEGIN
    RETURN CASE
        WHEN @Grade IS NULL THEN 'Pending'
        WHEN @Grade >= 50 THEN 'Passed'
        ELSE 'Failed'
    END;
END
GO
