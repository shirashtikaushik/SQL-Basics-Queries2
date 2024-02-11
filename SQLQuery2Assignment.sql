CREATE TABLE Employee (
    employee_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    exp INT CHECK (exp >= 2),
    salary DECIMAL(10, 2) CHECK (salary BETWEEN 12000 AND 30000),
    department_name VARCHAR(50) CHECK (department_name IN ('HR', 'Sales', 'Accts', 'IT')),
    manager_name VARCHAR(50)
);


CREATE PROCEDURE InsertEmployee (
    @name VARCHAR(50),
    @exp INT,
    @salary DECIMAL(10, 2),
    @department_name VARCHAR(50),
    @manager_name VARCHAR(50)
)
AS
BEGIN
    IF @exp < 2 OR @salary < 12000 OR @salary > 30000 OR @department_name NOT IN ('HR', 'Sales', 'Accts', 'IT')
    BEGIN
        PRINT 'Invalid values provided. Please check the values for exp, salary, and department name.';
        RETURN;
    END

    INSERT INTO Employee (name, exp, salary, department_name, manager_name)
    VALUES (@name, @exp, @salary, @department_name, @manager_name);

    PRINT 'Record inserted successfully.';
END;

CREATE PROCEDURE UpdateEmployee (
    @employee_id INT,
    @name VARCHAR(50),
    @exp INT,
    @salary DECIMAL(10, 2),
    @department_name VARCHAR(50),
    @manager_name VARCHAR(50)
)
AS
BEGIN
    IF @exp < 2 OR @salary < 12000 OR @salary > 30000 OR @department_name NOT IN ('HR', 'Sales', 'Accts', 'IT')
    BEGIN
        PRINT 'Invalid values provided. Please check the values for exp, salary, and department name.';
        RETURN;
    END

    UPDATE Employee
    SET name = @name,	
        exp = @exp,
        salary = @salary,
        department_name = @department_name,
        manager_name = @manager_name
    WHERE employee_id = @employee_id;

    IF @@ROWCOUNT = 0
        PRINT 'No records updated.';
    ELSE
        PRINT 'Record updated successfully.';
END;

CREATE PROCEDURE DeleteEmployee (
    @employee_id INT
)
AS
BEGIN
    DELETE FROM Employee
    WHERE employee_id = @employee_id;

    IF @@ROWCOUNT = 0
        PRINT 'No records deleted.';
    ELSE
        PRINT 'Record deleted successfully.';
END;

SELECT employee_id, name, salary FROM Employee;


SELECT employee_id AS 'Employee ID', name AS 'Name of Employee', salary AS 'Salary' FROM Employee;

SELECT name, salary, salary + 1000 AS 'Incremented Salary' FROM Employee;

SELECT department_name, SUM(salary) AS 'Total Salary Dispersed' FROM Employee GROUP BY department_name;

SELECT department_name, SUM(salary) AS 'Total Salary', MAX(salary) AS 'Maximum Salary', AVG(salary) AS 'Average Salary' FROM Employee GROUP BY department_name;

SELECT * FROM Employee ORDER BY salary;

SELECT ROW_NUMBER() OVER (ORDER BY employee_id) AS 'Sequence', * FROM Employee;

SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS 'Ranking', * FROM Employee;

SELECT COUNT(DISTINCT department_name) AS 'Number of Departments' FROM Employee;

SELECT UPPER(name) AS 'Upper Case Name' FROM Employee;

SELECT LEFT(name, 4) AS 'First Four Alphabets' FROM Employee;

SELECT name, CHARINDEX('a', name) AS 'Position of "a"' FROM Employee;

SELECT department_name, COUNT(*) AS 'Total Employees' FROM Employee GROUP BY department_name;

SELECT manager_name, COUNT(*) AS 'Total Employees' FROM Employee GROUP BY manager_name;

SELECT * FROM Employee WHERE employee_id IN (1, 2, 3);

SELECT * FROM Employee WHERE employee_id BETWEEN 1 AND 4;

SELECT * FROM Employee WHERE department_name = 'HR';

SELECT * FROM Employee WHERE department_name IN ('HR', 'Accts');

SELECT * FROM Employee WHERE name LIKE 'P%';

SELECT * FROM Employee WHERE name LIKE '%a%';

SELECT department_name FROM Employee GROUP BY department_name HAVING AVG(salary) < 25000;

SELECT * FROM Employee WHERE department_name <> 'Accts' AND salary NOT BETWEEN 15000 AND 25000;