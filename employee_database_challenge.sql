
--  Deliverable 1.
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees$ as e
INNER JOIN titles$ as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;

-- Use Dictinct 
SELECT DISTINCT (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;

-- Retrieve the number of employees  
SELECT count (dbo.unique_titles.emp_no),
dbo.unique_titles.title
FROM dbo.unique_titles 
INTO retiring_titles
GROUP BY title 
ORDER BY count (title) DESC;

-- Deliverable 2
SELECT DISTINCT  e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM dbo.employees$ as e
Left outer Join dbo.dept_emp$ as de
ON (e.emp_no = de.emp_no)
Left outer Join dbo.titles$ as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;