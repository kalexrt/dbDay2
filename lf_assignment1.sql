--Question 1 Find all students enrolled in the Math course.
SELECT s.student_id, s.student_name, s.student_age
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    WHERE e.course_id = (SELECT c.course_id FROM Courses c WHERE c.course_name = 'Math')
);

--Question 2 List all courses taken by students named Bob.
SELECT c.course_name
FROM Courses c
WHERE c.course_id IN (
    SELECT e.course_id
    FROM Enrollments e
    WHERE e.student_id IN (SELECT s.student_id FROM Students s WHERE s.student_name = 'Bob')
);

--Question 3 Find the names of students who are enrolled in more than one course.
SELECT s.student_name
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    GROUP BY e.student_id
    HAVING COUNT(e.course_id) > 1
);

--Question 4 List all students who are in Grade A (grade_id = 1).
SELECT s.student_name
FROM Students s
WHERE s.student_grade_id = 1;

--Question 5 Find the number of students enrolled in each course.
SELECT c.course_name, (
    SELECT COUNT(e.student_id)
    FROM Enrollments e
    WHERE e.course_id = c.course_id
) AS student_count
FROM Courses c;

--Question 6 Retrieve the course with the highest number of enrollments.
SELECT c.course_name, (
    SELECT COUNT(e.enrollment_id)
    FROM Enrollments e
    WHERE e.course_id = c.course_id
) AS enrollment_count
FROM Courses c
ORDER BY enrollment_count DESC
LIMIT 1;

--Question 7 List students who are enrolled in all available courses.
SELECT s.student_name
FROM Students s
WHERE (
    SELECT COUNT(DISTINCT e.course_id)
    FROM Enrollments e
    WHERE e.student_id = s.student_id
) = (SELECT COUNT(*) FROM Courses);

--Question 8
SELECT s.student_name
FROM Students s
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.student_id = s.student_id
);
--Question 9 Retrieve the average age of students enrolled in the Science course.
SELECT AVG(s.student_age)
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    WHERE e.course_id = (SELECT c.course_id FROM Courses c WHERE c.course_name = 'Science')
);

--Question 10 Find the grade of students enrolled in the History course.
SELECT s.student_name, (
    SELECT g.grade_name
    FROM Grades g
    WHERE g.grade_id = s.student_grade_id
) AS grade_name
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    WHERE e.course_id = (SELECT c.course_id FROM Courses c WHERE c.course_name = 'History')
);