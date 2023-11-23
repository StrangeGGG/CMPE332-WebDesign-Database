-- Q1
select FName, LName, SSN
from Employee
where Salary = (select min(Salary) from Employee);

-- Q2
select e.FName, e.LName
from Employee e
join Dependent s on e.SSN = s.ESSN and s.Sex = 'F'
join Dependent d on e.SSN = d.ESSN and d.Sex = 'F' and d.Relationship = 'Daughter';

-- Q3
select Employee.FName, Employee.LName, Project.PName
from Employee
join Works_On on Employee.SSN = Works_On.ESSN
join Project on Project.PNumber = Works_On.PNo
where Employee.LName in ('Wong', 'Borg', 'English');

-- Q4
select Employee.FName, Employee.LName, Employee.SSN, Employee.Salary
from Employee join Department
on Employee.SSN = Department.MGRSSN
where Employee.Sex = 'M' and Employee.Salary > 30000;

-- Q5
select Project.PName, Project.PNumber
from Project
join Works_On on Project.PNumber = Works_On.PNo
join Employee on Works_On.ESSN = Employee.SSN
where Employee.LName = 'Narayan' and Employee.LName = 'Jabbar';

-- Q6
select Employee.FName, Employee.LName, (2023-YEAR(Dependent.Bdate))
from Employee
join Dependent on Employee.SSN = Dependent.ESSN
where YEAR(Dependent.Bdate) > 1970;

-- Q7
select Employee.FName, Employee.LName, Project.PName, sum(Hours) AS TotalHours
FROM Employee
JOIN Works_On ON Employee.SSN = Works_On.ESSN
JOIN Project ON Works_On.PNo = Project.PNumber AND Project.PLocation = 'Houston'
GROUP BY Employee.SSN, Project.PNumber;

-- Q8
select e.FName, e.LName, s.FName as sprFirstName, s.LName as sprLastName
from Employee e
left join Employee s on e.SSN = s.SuperSSN;

-- Q9
select Project.PName, Employee.FName as ManageFName, Employee.LName as ManageLName, Project.PLocation
from Project
join Department on Project.DNum = Department.DNumber
join Employee on Department.MGRSSN = Employee.SSN;

-- Q10
select Employee.FName, Employee.LName
from Employee
join Department on Employee.SSN = Department.MGRSSN
where Department.MgrStartDate <= NOW()
order by Employee.Salary desc
limit 1;


