# School Database Management System

SQL Server database project for a school system: Departments, Teachers, Students, Courses, and Enrollments.

## Structure
SchoolDatabase/
├── erd/erd.png
├── scripts/
│   ├── 01_schema.sql
│   ├── 02_seed.sql
│   ├── 03_joins.sql
│   ├── 04_views.sql
│   ├── 05_procedures.sql
│   └── 06_functions.sql
└── README.md

## Key Rules
- Teacher SupervisorId is nullable (no self-supervision allowed)
- Grade: 0-100, nullable until graded
- Enrollment: unique (StudentId, CourseId), no future EnrollmentDate
- Status (Passed/Failed/Pending) is calculated, not stored

## How to Run
Execute scripts in order: 01_schema → 02_seed → 03_joins → 04_views → 05_procedures → 06_functions
