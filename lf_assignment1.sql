--Question 1 Find all students enrolled in the Math course.
SELECT s.student_id, s.student_name, s.student_age, s.student_grade_id
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Math';

--Question 2 List all courses taken by students named Bob.
SELECT c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_name = 'Bob';

--Question 3 Find the names of students who are enrolled in more than one course.
SELECT s.student_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_name
HAVING COUNT(e.course_id) > 1;

--Question 4 List all students who are in Grade A (grade_id = 1).
SELECT s.student_name
FROM Students s
WHERE s.student_grade_id = 1;

--Question 5 Find the number of students enrolled in each course.
SELECT c.course_name, COUNT(c.course_name)
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name

--Question 6 Retrieve the course with the highest number of enrollments.
SELECT c.course_name, COUNT(e.enrollment_id)
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY COUNT DESC
LIMIT 1;

--Question 7 List students who are enrolled in all available courses.
SELECT s.student_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(DISTINCT e.course_id) = (SELECT COUNT(*) FROM Courses);

--Question 8
SELECT s.student_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

--Question 9 Retrieve the average age of students enrolled in the Science course.
SELECT AVG(s.student_age)
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE course_name = 'Science'

--Question 10 Find the grade of students enrolled in the History course.
SELECT s.student_name, g.grade_name 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON s.student_grade_id = g.grade_id
WHERE course_name = 'History'