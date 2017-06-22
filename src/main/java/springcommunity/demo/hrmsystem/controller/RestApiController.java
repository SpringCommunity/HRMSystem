package springcommunity.demo.hrmsystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import springcommunity.demo.hrmsystem.dao.EmployeeDao;
import springcommunity.demo.hrmsystem.domain.Employee;
import springcommunity.demo.hrmsystem.domain.ErrorMessage;

@RestController
@RequestMapping("/restapi")
public class RestApiController {
	@Autowired
	private EmployeeDao employeeDao;
	
	@RequestMapping(value="/employee", method= RequestMethod.GET)
	public ResponseEntity<List<Employee>> listAllEmployees(){
		List<Employee> employees = employeeDao.findAllEmployees();
		return (employees.isEmpty()) ? new ResponseEntity<List<Employee>>(HttpStatus.NO_CONTENT) : new ResponseEntity<List<Employee>>(employees, HttpStatus.OK);
	}
	
	@RequestMapping(value="/employee/{number}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Employee> getEmployee(@PathVariable("number") int number){
		Employee employee = employeeDao.findAnEmployee(number);
		return (employee == null) ? new ResponseEntity<Employee>(HttpStatus.NOT_FOUND) : new ResponseEntity<Employee>(employee, HttpStatus.OK);
	}
	
	@RequestMapping(value="/employee", method = RequestMethod.POST)
	public ResponseEntity<?> createAnEmployee(@RequestBody Employee employee, UriComponentsBuilder uriBuilder){
		ErrorMessage error = new ErrorMessage();
		error.setMessage("The employee with this email "+ employee.getEmail() + " or phonenumber "+ employee.getPhone() +" already exist, check again!");
		if(employeeDao.isEmployeeExist(employee)){
			return new ResponseEntity(error, HttpStatus.CONFLICT);
		}
		    employeeDao.createNewEmployee(employee);
		    HttpHeaders headers = new HttpHeaders();
		    headers.setLocation(uriBuilder.path("/restapi/employee/{number}").buildAndExpand(employee.getNumber()).toUri());
		    return new ResponseEntity<String>(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value="/employee/{number}", method= RequestMethod.DELETE)
	public ResponseEntity<?> deleteAnEmployee(@PathVariable("number") Integer number){
		ErrorMessage error = new ErrorMessage();
		error.setMessage("No employee found with number "+ number);
		Employee employee = employeeDao.findAnEmployee(number);
		if(employee == null){
			return new ResponseEntity(error, HttpStatus.NOT_FOUND);
		}
		employeeDao.deleteEmployee(number);
		return new ResponseEntity<Employee>(HttpStatus.NO_CONTENT);
	}
	
	@RequestMapping(value="/employee/{number}", method= RequestMethod.PUT)
	public ResponseEntity<?> updateAnEmployee(@PathVariable("number") Integer number, @RequestBody Employee employee){
		ErrorMessage error = new ErrorMessage();
		error.setMessage("No employee found with number "+ number);
		Employee currentEmployee = employeeDao.findAnEmployee(number);
		if(currentEmployee == null){
			return new ResponseEntity(error, HttpStatus.NOT_FOUND);
		}
		currentEmployee.setAddress(employee.getAddress());
		currentEmployee.setBirthday(employee.getBirthday());
		currentEmployee.setEmail(employee.getEmail());
		currentEmployee.setName(employee.getName());
		currentEmployee.setPhone(employee.getPhone());
		currentEmployee.setPosition(employee.getPosition());
		   employeeDao.updateEmployee(currentEmployee);
		   return new ResponseEntity<Employee>(currentEmployee, HttpStatus.OK);
		
	}

}
