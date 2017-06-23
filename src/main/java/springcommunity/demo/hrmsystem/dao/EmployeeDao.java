package springcommunity.demo.hrmsystem.dao;

import java.util.List;

import org.springframework.stereotype.Service;

import springcommunity.demo.hrmsystem.domain.Employee;

@Service
public interface EmployeeDao {
   public int createNewEmployee(Employee e);
   public List<Employee> findAllEmployees();
   public Employee findAnEmployee(int number);
   public int updateEmployee(Employee e);
   public int deleteEmployee(int number);
   public Employee isEmployeeExist(Employee e);
}
