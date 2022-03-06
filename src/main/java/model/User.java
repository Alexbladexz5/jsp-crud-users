package model;

public class User {
	protected int id;
	protected String name;
	protected String last_name;
	protected String email;
	protected int age;
	protected String country;
	protected String city;
	
	public User() {
	}
	
	public User(String name, String last_name, String email, int age, String country, String city) {
		super();
		this.name = name;
		this.last_name = last_name;
		this.email = email;
		this.age = age;
		this.country = country;
		this.city = city;
	}

	public User(int id, String name, String last_name, String email, int age, String country, String city) {
		super();
		this.id = id;
		this.name = name;
		this.last_name = last_name;
		this.email = email;
		this.age = age;
		this.country = country;
		this.city = city;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	public String getCountry() {
		return country;
	}
	
	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
}
