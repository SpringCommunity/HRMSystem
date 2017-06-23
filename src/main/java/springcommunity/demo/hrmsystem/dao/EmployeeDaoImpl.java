package springcommunity.demo.hrmsystem.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import springcommunity.demo.hrmsystem.domain.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired
	private NamedParameterJdbcTemplate jdbcTemplate;

	@Override
	public int createNewEmployee(Employee e) {
		String sql = "INSERT INTO Employee(Name,Address,Phone,Email,Birthday,Position) VALUES (:name,:address,:phone,:email,:birthday,:position) ";
		MapSqlParameterSource paramMap = new MapSqlParameterSource();
		paramMap.addValue("name", e.getName());
		paramMap.addValue("address", e.getAddress());
		paramMap.addValue("phone", e.getPhone());
		paramMap.addValue("email", e.getEmail());
		paramMap.addValue("birthday", e.getBirthday());
		paramMap.addValue("position", e.getPosition());
		int row;
		try {
			row = jdbcTemplate.update(sql, paramMap);
			return row;
		} catch (DataAccessException error) {
			System.out.println("Cannot insert new employee cause "+ error);
			return 0;
		}
	}

	@Override
	public List<Employee> findAllEmployees() {
		String sql = "SELECT * FROM Employee";
		RowMapper<Employee> rm = new EmployeeRowMapper();
		try {
			List<Employee> employees = jdbcTemplate.query(sql, rm);
			return employees;
		} catch (DataAccessException e) {
			System.out.println("Cannot get list of employee cause " + e);
			return null;
		}
	}

	@Override
	public int updateEmployee(Employee e) {
		String sql = "UPDATE Employee SET Name = :name,Address=:address,Phone=:phone,Email=:email,Birthday=:birthday,Position=:position WHERE Number=:number";
		MapSqlParameterSource paramMap = new MapSqlParameterSource();
		paramMap.addValue("number", e.getNumber());
		paramMap.addValue("name", e.getName());
		paramMap.addValue("address", e.getAddress());
		paramMap.addValue("phone", e.getPhone());
		paramMap.addValue("email", e.getEmail());
		paramMap.addValue("birthday", e.getBirthday());
		paramMap.addValue("position", e.getPosition());
		int row;
		try {
			row = jdbcTemplate.update(sql, paramMap);
			return row;
		} catch (DataAccessException error) {
			System.out.println("Cannot update employee's profile cause "+ error);
			return 0;
		}
	}

	@Override
	public int deleteEmployee(int number) {
		String sql="DELETE FROM Employee WHERE Number=:number";
		MapSqlParameterSource paramMap = new MapSqlParameterSource();
		paramMap.addValue("number",number);
		try {
			int row = jdbcTemplate.update(sql, paramMap);
			return row;
		} catch (DataAccessException e) {
			System.out.println("Cannot delete selected employee cause " + e);
			return 0;
		}
	}

	@Override
	public Employee findAnEmployee(int number) {
		String sql="SELECT * FROM Employee WHERE Number=:number";
		MapSqlParameterSource paramMap = new MapSqlParameterSource();
		paramMap.addValue("number",number);
		RowMapper<Employee> rm = new EmployeeRowMapper();
		try {
			Employee employee = jdbcTemplate.queryForObject(sql, paramMap, rm);
			return employee;
		} catch (DataAccessException e) {
			System.out.println("No employee found with this number cause " + e);
			return null;
		}
	}

	@Override
	public Employee isEmployeeExist(Employee e) {
		String sql= "SELECT * FROM Employee WHERE Phone=:phone OR Email=:email";
		MapSqlParameterSource paramMap = new MapSqlParameterSource();
		paramMap.addValue("phone", e.getPhone());
		paramMap.addValue("email", e.getEmail());
		RowMapper<Employee> rm = new EmployeeRowMapper();
		try {
			return jdbcTemplate.queryForObject(sql, paramMap, rm);
		} catch (DataAccessException e1) {
			System.out.println("This employee is not exist cause"+ e1);
			return null;
		}
		
	}

}
