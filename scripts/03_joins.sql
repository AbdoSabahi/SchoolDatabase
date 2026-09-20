USE SchoolDB;
GO

SELECT s.FullName AS StudentName, d.DepartmentName
FROM Student s
INNER JOIN Department d ON s.DepartmentId = d.DepartmentId;
GO

SELECT t.FullName AS TeacherName, COUNT(c.CourseId) AS CourseCount
FROM Teacher t
JOIN Course c ON t.TeacherId = c.TeacherId
GROUP BY t.TeacherId, t.FullName
HAVING COUNT(c.CourseId) > 3;
GO

SELECT s.FullName AS StudentName
FROM Student s
WHERE EXISTS (
    SELECT 1
    FROM Enrollment e
    WHERE e.StudentId = s.StudentId
    AND e.Grade IS NULL
);
GO

SELECT d.DepartmentName, lead.FullName AS LeadTeacher, COUNT(t.TeacherId) AS SupervisedCount
FROM Teacher lead
JOIN Department d ON lead.DepartmentId = d.DepartmentId
JOIN Teacher t ON t.SupervisorId = lead.TeacherId
GROUP BY d.DepartmentName, lead.FullName
HAVING COUNT(t.TeacherId) > 5;
GO

SELECT c.CourseName, d.DepartmentName, t.FullName AS TeacherName
FROM Course c
JOIN Department d ON c.DepartmentId = d.DepartmentId
JOIN Teacher t ON c.TeacherId = t.TeacherId;
GO
