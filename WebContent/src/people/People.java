package people;
// 하나의 데이터를 관리하고 처리하는 jsp에서 사용할 수 있는 자바 빈즈
// 회원 정보들을담을 수 있는 곳. 회원 데이터 베이스를 저장하는 곳!
public class People {
	private String peopleID;
	private String peoplePassword;
	private String peopleName;
	
	public String getPeopleID() {
		return peopleID;
	}
	public void setPeopleID(String peopleID) {
		this.peopleID = peopleID;
	}
	public String getPeoplePassword() {
		return peoplePassword;
	}
	public void setPeoplePassword(String peoplePassword) {
		this.peoplePassword = peoplePassword;
	}
	public String getPeopleName() {
		return peopleName;
	}
	public void setPeopleName(String peopleName) {
		this.peopleName = peopleName;
	}
}
