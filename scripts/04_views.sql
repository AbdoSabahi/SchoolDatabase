USE SchoolDB;
GO

CREATE VIEW vw_DepartmentSummary AS
SELECT 
    d.DepartmentId,
    d.DepartmentName,
    COUNT(DISTINCT s.StudentId) AS StudentCount,
    COUNT(DISTINCT t.TeacherId) AS TeacherCount
FROM Department d
LEFT JOIN Student s ON s.DepartmentId = d.DepartmentId
LEFT JOIN Teacher t ON t.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentId, d.DepartmentName;
GO

CREATE VIEW vw_TeacherCourseLoad AS
SELECT 
    t.TeacherId,
    t.FullName AS TeacherName,
    COUNT(c.CourseId) AS CourseCount
FROM Teacher t
LEFT JOIN Course c ON c.TeacherId = t.TeacherId
GROUP BY t.TeacherId, t.FullName;
GO

CREATE VIEW vw_StudentFullReport AS
SELECT 
    s.StudentId,
    s.FullName AS StudentName,
    c.CourseName,
    e.Grade,
    CASE 
        WHEN e.Grade IS NULL THEN 'Pending'
        WHEN e.Grade >= 50 THEN 'Passed'
        ELSE 'Failed'
    END AS Status
FROM Student s
JOIN Enrollment e ON e.StudentId = s.StudentId
JOIN Course c ON c.CourseId = e.CourseId;
GO

CREATE VIEW vw_DepartmentTopStudent AS
WITH StudentAvg AS (
    SELECT 
        s.StudentId,
        s.FullName AS StudentName,
        s.DepartmentId,
        AVG(e.Grade) AS AvgGrade,
        RANK() OVER (PARTITION BY s.DepartmentId ORDER BY AVG(e.Grade) DESC) AS RankInDept
    FROM Student s
    JOIN Enrollment e ON e.StudentId = s.StudentId
    WHERE e.Grade IS NOT NULL
    GROUP BY s.StudentId, s.FullName, s.DepartmentId
)
SELECT 
    d.DepartmentName,
    sa.StudentName,
    sa.AvgGrade
FROM StudentAvg sa
JOIN Department d ON d.DepartmentId = sa.DepartmentId
WHERE sa.RankInDept = 1;
GO
