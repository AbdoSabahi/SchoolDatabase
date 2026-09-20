USE SchoolDB;
GO

CREATE PROCEDURE sp_GetStudentsByDepartment
    @DepartmentId INT
AS
BEGIN
    SELECT 
        s.StudentId,
        s.FullName,
        s.DateOfBirth,
        d.DepartmentName
    FROM Student s
    JOIN Department d ON d.DepartmentId = s.DepartmentId
    WHERE s.DepartmentId = @DepartmentId;
END
GO

CREATE PROCEDURE sp_EnrollStudent
    @StudentId INT,
    @CourseId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Enrollment
        WHERE StudentId = @StudentId AND CourseId = @CourseId
    )
    BEGIN
        RAISERROR('Student is already enrolled in this course.', 16, 1);
        RETURN;
    END

    DECLARE @StudentDept INT, @CourseDept INT;

    SELECT @StudentDept = DepartmentId FROM Student WHERE StudentId = @StudentId;
    SELECT @CourseDept = DepartmentId FROM Course WHERE CourseId = @CourseId;

    IF @StudentDept IS NULL OR @CourseDept IS NULL
    BEGIN
        RAISERROR('Invalid Student or Course Id.', 16, 1);
        RETURN;
    END

    IF @StudentDept <> @CourseDept
    BEGIN
        RAISERROR('Student and Course must belong to the same Department.', 16, 1);
        RETURN;
    END

    INSERT INTO Enrollment (StudentId, CourseId, EnrollmentDate)
    VALUES (@StudentId, @CourseId, CAST(GETDATE() AS DATE));
END
GO

CREATE PROCEDURE sp_TransferStudent
    @StudentId INT,
    @NewDepartmentId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        IF EXISTS (
            SELECT 1
            FROM Enrollment e
            JOIN Course c ON c.CourseId = e.CourseId
            WHERE e.StudentId = @StudentId
            AND c.DepartmentId <> @NewDepartmentId
        )
        BEGIN
            RAISERROR('Cannot transfer: student has enrollments conflicting with the new department.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE Student
        SET DepartmentId = @NewDepartmentId
        WHERE StudentId = @StudentId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
