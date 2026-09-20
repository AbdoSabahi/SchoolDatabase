USE SchoolDB;
GO

INSERT INTO Department (DepartmentName) VALUES
('Computer Science'),
('Mathematics'),
('Physics');
GO

INSERT INTO Teacher (FullName, DepartmentId, SupervisorId) VALUES
('Ahmed Hassan', 1, NULL),
('Mona Youssef', 1, 1),
('Karim Adel', 1, 1),
('Laila Fathy', 2, NULL),
('Sameh Nabil', 2, 4),
('Yasmin Kamal', 3, NULL),
('Omar Sherif', 3, 6);
GO

INSERT INTO Student (FullName, DateOfBirth, DepartmentId) VALUES
('Sara Mostafa', '2002-03-15', 1),
('Ali Tarek', '2001-11-20', 1),
('Nour Ibrahim', '2003-01-05', 1),
('Hana Ashraf', '2002-07-30', 2),
('Youssef Adel', '2001-09-12', 2),
('Mariam Sami', '2002-05-25', 3),
('Khaled Ramy', '2003-02-18', 3);
GO

INSERT INTO Course (CourseName, DepartmentId, TeacherId) VALUES
('Database Systems', 1, 2),
('Web Development', 1, 3),
('Operating Systems', 1, 1),
('Calculus I', 2, 4),
('Linear Algebra', 2, 5),
('Classical Mechanics', 3, 6),
('Quantum Physics', 3, 7);
GO

INSERT INTO Enrollment (StudentId, CourseId, EnrollmentDate, Grade) VALUES
(1, 1, '2026-01-10', 85),
(1, 2, '2026-01-10', 70),
(2, 1, '2026-01-11', 45),
(2, 3, '2026-01-11', NULL),
(3, 2, '2026-01-12', 95),
(3, 3, '2026-01-12', 60),
(4, 4, '2026-01-10', 55),
(4, 5, '2026-01-10', NULL),
(5, 4, '2026-01-11', 40),
(6, 6, '2026-01-10', 88),
(6, 7, '2026-01-10', NULL),
(7, 6, '2026-01-11', 30),
(7, 7, '2026-01-11', 75);
GO
