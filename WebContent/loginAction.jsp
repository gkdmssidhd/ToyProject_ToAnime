<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- people패키지의 People.Dao클래스를 그대로 가져옴 
실질적으로 사용자가 로그인 시도 하려는걸 처리하는 페이지 -->
<%@ page import="people.PeopleDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<!-- People를 자바빈즈로 사용/ SCOPE 현재 페이지 안에서만 빈즈가 사용될 수 있게 한다. property 값을 저장할 수 있는 거 -->
<jsp:useBean id="people" class="people.People" scope="page" />
<!-- 로그인 페이지 에서 넘겨준 userID와 비번을 그대로 넣어주는 것 -->
<jsp:setProperty name="people" property="peopleID" />
<jsp:setProperty name="people" property="peoplePassword" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
	<body>
		<%
		// 이미 로그인 되어있는 사람에게는 회원가입과 로그인 화면에 들어갈 수 없게	
			String peopleID = null;
			// 세션을 확인해서 유저아이디라는 이름으로 세션이 존재하면
			if(session.getAttribute("peopleID") != null) {				
			// peopleID에 해당 세션값을 넣어줄 수 있게 함. userID변수가 자기에게 할당된 세션아이디 담게
			// getAttribute => attribute란 servlet간 공유하는 객체
				peopleID = (String)session.getAttribute("peopleID");
			}
			// peopleID가 null값이 아닌 회원이니까 main으로 보낸다
			if (peopleID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			
			PeopleDAO peopleDAO = new PeopleDAO();
			// 가져온 아이디 패스워드가 맞으면
			int result = peopleDAO.login(people.getPeopleID(), people.getPeoplePassword());
			if (result == 1) {
				// 해당 회원 아이디를 세션값에 넣기 로그인한 회원들은 세션으로 관리 구분 한다.
				// 로그인에 성공했을 때 세션을 부여하는 코드
				session.setAttribute("peopleID", people.getPeopleID());
				// 하나의 스크립트 문장 응답으로 내보낼 출력 스트림
				PrintWriter script = response.getWriter();
				// 스크립트 문장을 유동적으로 
				script.println("<script>");
				// 로그인 성공하면 main.jsp로 이동하게
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			else if (result == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				// 이전 페이지로 사용자를 돌려보내는거 다시 비번하라고
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -2) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
	</body>
</html>