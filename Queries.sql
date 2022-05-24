SELECT first_name, last_name
FROM employees$
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees$
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees$
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees$
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees$
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees$
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
Select departments$.dept_name,
	dept_manager$.emp_no,
	dept_manager$.from_date,
	dept_manager$.to_date
FROM departments$
INNER JOIN dept_manager$
ON departments$.dept_no = dept_manager$.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp$.to_date
FROM retirement_info
LEFT JOIN dept_emp$
ON retirement_info.emp_no = dept_emp$.emp_no;

Select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
dept_emp$.to_date
INTO current_emp
From retirement_info
LEFT JOIN dept_emp$
on retirement_info.emp_no = dept_emp$.emp_no
WHERE dept_emp$.to_date = ('9999-01-01');

--employee count by department number
SELECT COUNT (ce.emp_no), de.dept_no
from current_emp as ce
left join dept_emp$ as de
on ce.emp_no = de.emp_no
group by de.dept_no
ORDER BY de.dept_no;

SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
from employees$ as e
inner join salaries$ as s
on (e.emp_no = s.emp_no)
INNER JOIN dept_emp$ as de
on (e.emp_no = de.emp_no)
Where (e.birth_date between '1952-01-01' AND '1955-12-31')
and (e.hire_date between '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

--List of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
--INTO manager_info
from dept_manager$ as dm
	inner join departments$ as d
		on (dm.dept_no = d.dept_no)
	inner join current_emp as ce
		on (dm.emp_no = ce.emp_no); 

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp$ AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments$ AS d
ON (de.dept_no = d.dept_no);
