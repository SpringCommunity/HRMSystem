package springcommunity.demo.hrmsystem.domain;

public class EmployeeImpl implements Employee {
   private int number;
   private String name;
   private String address;
   private String email;
   private String phone;
   private String position;
   private String birthday;
public EmployeeImpl() {
	super();
	// TODO Auto-generated constructor stub
}
public EmployeeImpl(String name, String address, String email, String phone, String position,
		String birthday) {
	super();
	this.name = name;
	this.address = address;
	this.email = email;
	this.phone = phone;
	this.position = position;
	this.birthday = birthday;
}
public int getNumber() {
	return number;
}
public void setNumber(int number) {
	this.number = number;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getPosition() {
	return position;
}
public void setPosition(String position) {
	this.position = position;
}
public String getBirthday() {
	return birthday;
}
public void setBirthday(String birthday) {
	this.birthday = birthday;
}
   
   
}
