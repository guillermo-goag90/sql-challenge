-- Create database schema

-- Create departments table
CREATE TABLE departments (
	dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE titles (
	title_id VARCHAR(30) NOT NULL,
	title VARCHAR(30) NOT NULL,
	PRIMARY KEY (title_id)
);


CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR(30),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date DATE,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

ALTER TABLE employees 
ALTER COLUMN birth_date TYPE VARCHAR(30),
ALTER COLUMN hire_date TYPE VARCHAR(30);

CREATE TABLE salaries(
	emp_no INT,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp(
	emp_no INT,
	dept_no VARCHAR(30),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(30),
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

-- Import tables
-- 'departments table' manually imported
COPY titles FROM 'C:\Users\memgo\Desktop\Bootcamp\sql-challenge\data\titles.csv' WITH CSV HEADER;
COPY employees FROM 'C:\Users\memgo\Desktop\Bootcamp\sql-challenge\data\employees.csv' WITH CSV HEADER;
COPY salaries FROM 'C:\Users\memgo\Desktop\Bootcamp\sql-challenge\data\salaries.csv' WITH CSV HEADER;
COPY dept_emp FROM 'C:\Users\memgo\Desktop\Bootcamp\sql-challenge\data\dept_emp.csv' WITH CSV HEADER;
COPY dept_manager FROM 'C:\Users\memgo\Desktop\Bootcamp\sql-challenge\data\dept_manager.csv' WITH CSV HEADER;

-- Check tables imported correctly
SELECT * from employees

-- 1) List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM salaries AS s
INNER JOIN employees as e 
ON e.emp_no = s.emp_no;

-- 2) List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

--3) List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name
SELECT d.dept_no, d.dept_name, d_m.emp_no, e.last_name, e.first_name
FROM departments AS d INNER JOIN dept_manager AS d_m ON d.dept_no = d_m.dept_no
INNER JOIN employees AS e ON d_m.emp_no = e.emp_no;

--4) List the department of each employee with the following information: 
-- employee number, last name, first name, and department name
select d_e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d inner join dept_emp as d_e on d.dept_no = d_e.dept_no
inner join employees as e on d_e.emp_no = e.emp_no;

--5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

--6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
select d_e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d inner join dept_emp as d_e on d.dept_no = d_e.dept_no
inner join employees as e on d_e.emp_no = e.emp_no
where dept_name = 'Sales';

--7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
select d_e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d inner join dept_emp as d_e on d.dept_no = d_e.dept_no
inner join employees as e on d_e.emp_no = e.emp_no
where dept_name = 'Sales' or dept_name = 'Development';

--8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name)
from employees
group by last_name
order by 2 desc;
