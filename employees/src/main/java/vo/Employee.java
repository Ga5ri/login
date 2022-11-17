package vo;

// 캡슐화 : 내가 가지고있는 데이터중 하나를 숨기는 것 -> 즉 데이터를 은닉시키고 호출
// 캡슐화 단계 : public(100%오픈) > protected(같은 패키지와 상속관계 오픈) > default(같은 패키지 오픈) > private(this 오픈)
// protected, default 단계의 캡슐화는 입문자는 사용하지 않는다.
// @Data <-- 외부 API 가져오면 알아서 get,set 만들어주는 코드 아직 사용 X
public class Employee {
	private int empNo;
	//protected String birthDate; (아무것도 안적는 default)String birthDate; private String birthDate;
	private String birthDate; // private 사용하여 정보은닉
	private	String firstName;
	private String lastName;
	private String gender;
	private String hireDate;
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	
	
	/*
	// 캡슐화(읽기)
	public String getBirthDate() {
		return this.birthDate;
	}
	// 캡슐화(쓰기)
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	*/
}
