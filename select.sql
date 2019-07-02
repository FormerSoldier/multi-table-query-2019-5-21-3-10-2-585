# 1.查询同时存在1课程和2课程的情况
SELECT 
    sc1.studentId
FROM
    student_course sc1
        INNER JOIN
    student_course sc2 ON sc1.studentId = sc2.studentId
        AND sc1.courseId = 1
        AND sc2.courseId = 2;

# 2.查询同时存在1课程和2课程的情况
SELECT 
    studentId
FROM
    student_course
WHERE
    courseId = 1
        AND studentId in (SELECT 
            studentId
        FROM
            student_course
        WHERE
            courseId = 2);

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT 
    student.id, student.name, avg_score
FROM
    student
        INNER JOIN
    (SELECT 
        studentId, Avg(score) avg_score
    FROM
        student_course
    GROUP BY studentId
    HAVING Avg(score) >= 60) new_sc ON student.id = new_sc.studentId;

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
SELECT DISTINCT
    student . *
FROM
    student
        LEFT JOIN
    student_course ON student.id = student_course.studentId
WHERE
    score IS NULL;

# 5.查询所有有成绩的SQL
SELECT DISTINCT
    *
FROM
    student
        RIGHT JOIN
    student_course sc ON student.id = sc.studentId;

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
SELECT 
    *
FROM
    student
        INNER JOIN
    (SELECT 
        studentId
    FROM
        student_course
    WHERE
        courseId = 1
            AND studentId in (SELECT 
                studentId
            FROM
                student_course
            WHERE
                courseId = 2)) new_sc ON student.id = new_sc.studentId;

# 7.检索1课程分数小于60，按分数降序排列的学生信息
SELECT 
    *
FROM
    student
WHERE
    id in (SELECT 
            studentId
        FROM
            student_course sc
        WHERE
            courseId = 1 AND score < 60
        ORDER BY score DESC);

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT 
    courseId, Avg(score) avg_score
FROM
    student_course
GROUP BY courseId
ORDER BY avg_score DESC , courseId ASC;

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT 
    student.name, score
FROM
    student
        INNER JOIN
    (SELECT 
        studentId, score
    FROM
        student_course
    WHERE
        courseId = (SELECT 
                id
            FROM
                course
            WHERE
                name = '数学')
            AND score < 60) new_sc ON student.id = new_sc.studentId;