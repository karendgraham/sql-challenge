-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Tmyb0l
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE "Departments"

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

DROP TABLE "Dept_Emp"
CREATE TABLE "Dept_Emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
    --CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        --"emp_no"
);

DROP TABLE "Dept_Manager"
CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR  NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
    --CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        --"emp_no"
);

DROP TABLE "Employees"
CREATE TABLE "Employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL
    --CONSTRAINT "pk_Employees" PRIMARY KEY (
        --"emp_no"
     --)
);

DROP TABLE "Salaries"
CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
    --CONSTRAINT "pk_Salaries" PRIMARY KEY (
        --"emp_no"
     --)
);

DROP TABLE "Titles"
CREATE TABLE "Titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
    --CONSTRAINT "pk_Titles" PRIMARY KEY (
        --"emp_no"
     --)
);

--Employee list (employee number, last name, first name, gender, salary)
SELECT e.emp_no, last_name, first_name, gender, salary
FROM "Employees" e
JOIN "Salaries" s ON e.emp_no = s.emp_no

--List Employees hired in 1986
SELECT last_name, first_name, hire_date
FROM "Employees"
WHERE hire_date > '1986-01-01' AND hire_date < '1986-12-31'

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
--
SELECT dept.dept_no, dept_name, dm.emp_no, last_name, first_name, from_date, to_date 
FROM "Departments" dept
JOIN "Dept_Manager" dm ON dept.dept_no = dm.dept_no
JOIN "Employees" e ON e.emp_no = dm.emp_no

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, dept_name, de.dept_no
FROM "Employees" e
JOIN "Dept_Emp" de ON e.emp_no = de.emp_no
JOIN "Departments" dept ON dept.dept_no = de.dept_no
--Not sure how to get rid of "dept_no" column

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, de.dept_no, dept_name
FROM "Employees" e
JOIN "Dept_Emp" de ON e.emp_no = de.emp_no
JOIN "Departments" dept ON dept.dept_no = de.dept_no
WHERE dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
SELECT e.emp_no, last_name, first_name, de.dept_no, dept_name
FROM "Employees" e
JOIN "Dept_Emp" de ON e.emp_no = de.emp_no
JOIN "Departments" dept ON dept.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'

-- In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT (last_name) AS Occurences
FROM "Employees"
GROUP BY last_name 
ORDER BY last_name DESC


