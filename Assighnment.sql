
-- Question 5
select last_name, salary, job_id, country_id
from employees join departments
using(department_id)
join locations
using(location_id)
where salary not in (
select min(salary)
from employees join departments
using(department_id)
join locations
using(location_id)
group by country_id
) and country_id <> 'US';

--Question 6
SELECT  last_name AS "Last Name",
        salary AS "Salary",
        job_id AS "Job"
        FROM employees
        WHERE department_id IN(
        SELECT department_id
        FROM employees
        WHERE (job_id LIKE 'IT%' OR job_id LIKE 'MK%')
        )
        AND salary>(
        SELECT min(salary)
        FROM employees
        WHERE job_id LIKE 'AC%'
        );
        
-- Question 7
        
SELECT  substr(first_name||' ' ||last_name,1,25) AS "Employee",
        job_id AS "Job",
        LPAD(to_char(salary,'$999,999'),15,'=') AS "Salary",
        department_id AS "Department"
        FROM employees
        WHERE (upper(job_id) LIKE 'SA_R%' OR upper(job_id) LIKE 'MK%')
        AND salary< ANY(
        SELECT max(salary)
        FROM employees
        WHERE job_id  NOT LIKE '%MAN' AND job_id NOT LIKE '%VP' AND job_id NOT LIKE '%PRES'
        GROUP BY department_id
        );
        
-- Question 8 
SElect department_name, substr(nvl(city,'Not assighn yet'),0,25),count(job_id)as"job#"
from employees left outer join departments
using(department_id)
full outer join locations
using(location_id)
group by department_name, substr(nvl(city,'Not assighn yet'),0,25) ;
        
--        SELECT * FROM locations;