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