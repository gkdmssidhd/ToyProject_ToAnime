package animelist;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AnimelistDAO {
	private Connection conn;
	// 어떠한 정보를 담을 수 있는 객체
	private ResultSet rs;
	
	public AnimelistDAO() {
		// 생성자 실제로 mysql에 접속 할 수 있게 해주는 부분	
		try { 
			// 로컬호스트(내 컴퓨터의 주소)에 접속할 수 있게/Anime디비에 접속해라
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
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			// 현재 연결되어있는 객체를 이용해서 SQL 문장을 실행 준비단계로 만들어준다.
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 실제로 실행했을때 나오는 결과 가져오기
			rs = pstmt.executeQuery();
			// 결과가 있는 경우에는 리턴해서 현재 그 날짜를 그대로 반환
			if (rs.next()) {
			return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 디비 오류
	}
	
	// 글 숫자+1씩 되게
	public int getNext() {
		// 게시글 번호는 1번부터 늘어나는데 제일 마지막에 쓰인 글을 가져와서 그 글 번호 +1 을 위해 
		// animeID 가져오기 
		String SQL = "SELECT animeID FROM animelist ORDER BY animeID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) +1;
			}
			return 1; // 첫번째 게시물인경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 디비 오류
	}
	// 하나의 게시글물을 실제로 디비에 넣는 write 메소드
	public int write(String animeTitle, String peopleID, String animeContent, String animeType, String animeCandy) {
		String SQL = "INSERT INTO animelist VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			// 하나씩 값을 넣어 줄 수 있게 한다.
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 다음번에 쓰여야될 게시글 번호 
			pstmt.setInt(1, getNext());
			pstmt.setString(2, animeTitle);
			pstmt.setString(3, peopleID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, animeContent);
			pstmt.setString(6, animeType);
			pstmt.setString(7, animeCandy);
			// 제일 마지막은 Available 글 쓰는 상황에서는 삭제가 안된거니까 1
			pstmt.setInt(8, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비 오류	
	}
	
	public ArrayList<Animelist> getList(int pageNumber) {
		// 모든 게시글을 조회. 현재 유효번호가 존재하고 새롭게 작성될 게시글번호보다 작은 모든
		// 게시글 번호를 내림차순 정렬로 최대 10개까지만 조회한다.
		// 삭제되지 않은 Available이 1인애들만 가져와서 order by(내림차순) 위에서 10개까지만 가져오게
		String SQL = "SELECT * FROM animelist WHERE animeID < ? AND animeAvailable = 1 ORDER BY animeID DESC LIMIT 10";
		ArrayList<Animelist> list = new ArrayList<Animelist>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
				while (rs.next()) {
					Animelist animelist = new Animelist();
					animelist.setAnimeID(rs.getInt(1));
					animelist.setAnimeTitle(rs.getString(2));
					animelist.setPeopleID(rs.getString(3));
					animelist.setAnimeDate(rs.getString(4));
					animelist.setAnimeContent(rs.getString(5));
					animelist.setAnimeType(rs.getString(6));
					animelist.setAnimeCandy(rs.getString(7));
					animelist.setAnimeAvailable(rs.getInt(8));
					list.add(animelist);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return list; //디비 오류	
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM animelist WHERE animeID < ? AND animeAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return false; //디비 오류	
	}
	
	public Animelist getAnimelist(int animeID) {
		String SQL = "SELECT * FROM animelist WHERE animeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, animeID);
			rs = pstmt.executeQuery();
				if (rs.next()) {
					Animelist animelist = new Animelist();
					animelist.setAnimeID(rs.getInt(1));
					animelist.setAnimeTitle(rs.getString(2));
					animelist.setPeopleID(rs.getString(3));
					animelist.setAnimeDate(rs.getString(4));
					animelist.setAnimeContent(rs.getString(5));
					animelist.setAnimeType(rs.getString(6));
					animelist.setAnimeCandy(rs.getString(7));
					animelist.setAnimeAvailable(rs.getInt(8));
					return animelist;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return null; //디비 오류	
	}
	// 수정하는 함수
	public int update(int animeID, String animeTitle, String animeContent, String animeType, String animeCandy) {
		String SQL = "UPDATE animelist SET animeTitle = ?, animeContent = ?, animeType = ?, animeCandy = ? WHERE animeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, animeTitle);
			pstmt.setString(2, animeContent);
			pstmt.setString(3, animeType);
			pstmt.setString(4, animeCandy);
			pstmt.setInt(5, animeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //디비 오류	
	}
	// 어떠한 글인지 알 수 있게 animeID 넣어주기
		public int delete(int animeID) {
			// Available을 0으로 바꾸면 삭제 되다.
			String SQL = "UPDATE animelist SET animeAvailable = 0 WHERE animeID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, animeID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //디비 오류
		}
}

