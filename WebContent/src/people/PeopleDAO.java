package people;
//디비에 접근 할 수 있게 실질적으로 데이터베이스에 정보를 넣고 불러오는 곳
// 회원 데이터 베이스에 회원정보를 불러오거나 입력하고자 할때 사용
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//디비 접근하게하는 객체
public class PeopleDAO {
	private Connection conn;
	// 파라미터가 있는 쿼리문 insert, update, delete 담당
	private PreparedStatement pstmt;
	// 어떠한 정보를 담을 수 있는 객체
	private ResultSet rs;
	
	// 생성자 실제로 mysql에 접속 할 수 있게 해주는 부분	
	public PeopleDAO() {
		try { 
			// 로컬호스트(내 컴퓨터의 주소)에 접속할 수 있게/ToAnime디비에 접속해라
			String dbURL = "jdbc:mysql://localhost:3308/Anime";
			String dbID = "haeun";
			String dbPassword = "4197";
			// mysql 드라이버 찾기 mysql 접속할 수 있는 매개체의 역할인 라이브러리
			Class.forName("com.mysql.jdbc.Driver");
			// 디비url에 디비아이디로 디비 패스워드를 이용해서 접속되면 conn에 접속된 정보가 담겨짐
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 실제로 로그인 기능 구현
		public int login(String peopleID, String peoplePassword) {
			/** String SQL => 실제로 db에 입력할 명령어를 sql문 처럼 만듬 
				prepareStatement = SQL 해킹 방어용
			 	toanime 테이블에서 해당 사용자의 비번가져오기
			 	?를 미리 해놨다가 나중에 준비된 ?에 해당하는 USERID를 넣어줌 디비에는 이게 보여서 데이터 넘겨줄 수 있음
			 	실제 DB에는 접속자 ID를 받아서 접속할 수 있게 함. **/
			String SQL = "SELECT peoplePassword FROM ANIME WHERE peopleID = ?";
			try {	
				// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
				pstmt = conn.prepareStatement(SQL);
				// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
				// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호 무엇인지 디비에서 가져오도록 함.
				pstmt.setString(1, peopleID);
				// 결과를 담을 수 있는 객체에 실행한 결과를 담는다.
				// executeQuery -> 실제 디비 다녀오는구문 
				// 수행 결과로 ResultSet 객체의 값을 반환함.
				rs = pstmt.executeQuery();
				// next=>결과가 존재한다면 {}안에꺼가 실행됌.
				if(rs.next()) {
					// 아이디가 있으면 가져와서 비번이랑 동일하다면 1을 반환 해서 로그인 성공			
					if(rs.getString(1).equals(peoplePassword)) 
						return 1; //로그인 성공
					else
						return 0; //비밀번호 불일치
				} 
				return -1; // 아이디가 없음
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -2; // 데이터베이스 오류를 의미
		}
		
		public int join(People people) {
			// people 테이블에 데이터를 입력하는 쿼리문
			String SQL = "INSERT INTO ANIME VALUES(?, ?, ?)";
			try { // 아이디, 비번, 네임 담을것 3개
				// sql 쿼리문을 대기시킨다.
				pstmt = conn.prepareStatement(SQL);
				// 1번째 물음표에 실제 사용자가 입력한 PeopleID를 셋팅
				pstmt.setString(1, people.getPeopleID());
				pstmt.setString(2, people.getPeoplePassword());
				pstmt.setString(3, people.getPeopleName());
				// executeUpdate = 수행결과로 int 타입의 값을 반환
				// 실제 디비에서 'insert'를 정상적으로 입력하면 'Query 1 OK'라고 뜨는데 그 숫자를 받아온다.
				// 정상적으로 데이터가 입력되었다면 반드시 1이상의 숫자가 리턴될 것이다.
				return pstmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			// insert문장을 실행한 경우는 반드시 0이상의 숫자가 반환되기에 -1이 아닌경우는 성공적으로 회원가입이 된 것.
			return -1; // 데이터베이스 오류
		}
}