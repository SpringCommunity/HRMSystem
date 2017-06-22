package springcommunity.demo.hrmsystem.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import springcommunity.demo.hrmsystem.domain.Employee;
import springcommunity.demo.hrmsystem.domain.EmployeeImpl;

public class EmployeeRowMapper implements RowMapper<Employee> {

	@Override
	public Employee mapRow(ResultSet rs, int row) throws SQLException {
		Employee employee = new EmployeeImpl();
		employee.setNumber(rs.getInt("Number"));
		employee.setAddress(rs.getString("Address"));
		employee.setBirthday(rs.getString("Birthday"));
		employee.setEmail(rs.getString("Email"));
		employee.setName(rs.getString("Name"));
		employee.setPhone(rs.getString("Phone"));
		employee.setPosition(rs.getString("Position"));
		return employee;
	}

}
