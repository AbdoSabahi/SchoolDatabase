CREATE DATABASE SchoolDB;
GO

USE SchoolDB;
GO

CREATE TABLE Department (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Teacher (
    TeacherId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    DepartmentId INT NOT NULL,
    SupervisorId INT NULL,

    CONSTRAINT FK_Teacher_Department FOREIGN KEY (DepartmentId)
        REFERENCES Department(DepartmentId)
        ON DELETE CASCADE,

    CONSTRAINT FK_Teacher_Supervisor FOREIGN KEY (SupervisorId)
        REFERENCES Teacher(TeacherId)
        ON DELETE NO ACTION,

    CONSTRAINT CHK_Teacher_NotOwnSupervisor
        CHECK (SupervisorId <> TeacherId)
);
GO

CREATE TABLE Student (
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    DepartmentId INT NOT NULL,

    CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentId)
        REFERENCES Department(DepartmentId)
        ON DELETE CASCADE
);
GO

CREATE TABLE Course (
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    DepartmentId INT NOT NULL,
    TeacherId INT NOT NULL,

    CONSTRAINT FK_Course_Department FOREIGN KEY (DepartmentId)
        REFERENCES Department(DepartmentId)
        ON DELETE CASCADE,

    CONSTRAINT FK_Course_Teacher FOREIGN KEY (TeacherId)
        REFERENCES Teacher(TeacherId)
        ON DELETE NO ACTION
);
GO

CREATE TABLE Enrollment (
    EnrollmentId INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),
    Grade DECIMAL(5,2) NULL,

    CONSTRAINT FK_Enrollment_Student FOREIGN KEY (StudentId)
        REFERENCES Student(StudentId)
        ON DELETE CASCADE,

    CONSTRAINT FK_Enrollment_Course FOREIGN KEY (CourseId)
        REFERENCES Course(CourseId)
        ON DELETE NO ACTION,

    CONSTRAINT CHK_Enrollment_Grade
        CHECK (Grade IS NULL OR (Grade >= 0 AND Grade <= 100)),

    CONSTRAINT CHK_Enrollment_Date
        CHECK (EnrollmentDate <= CAST(GETDATE() AS DATE)),

    CONSTRAINT UQ_Enrollment_Student_Course
        UNIQUE (StudentId, CourseId)
);
GO
