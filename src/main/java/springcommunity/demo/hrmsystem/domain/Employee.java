package springcommunity.demo.hrmsystem.domain;

import java.sql.Date;

public interface Employee {
	public int getNumber();

	public void setNumber(int number);

	public String getName();

	public void setName(String name);

	public String getAddress();

	public void setAddress(String address);

	public String getEmail();

	public void setEmail(String email);

	public String getPhone();

	public void setPhone(String phone);

	public String getPosition();

	public void setPosition(String position);

	public Date getBirthday();

	public void setBirthday(Date birthday);
}
