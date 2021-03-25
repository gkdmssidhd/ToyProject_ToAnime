<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- user패키지의 User.DAO클래스를 그대로 가져옴 
실질적으로 사용자가 로그인 시도 하려는걸 처리하는 페이지 -->
<%@ page import="people.PeopleDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<!-- User를 자바빈즈로 사용/ SCOPE 현재 페이지 안에서만 빈즈가 사용될 수 있게 한다. property 값을 저장할 수 있는 거 -->
<jsp:useBean id="people" class="people.People" scope="page" />
<!-- 로그인 페이지 에서 넘겨준 userID와 비번을 그대로 넣어주는 것 -->
<jsp:setProperty name="people" property="peopleID" />
<jsp:setProperty name="people" property="peoplePassword" />
<jsp:setProperty name="people" property="peopleName" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
	<body>
		<%
		// 현재 세션 상태를 체크 
			String peopleID = null;
			if(session.getAttribute("peopleID") != null) {
				peopleID = (String) session.getAttribute("peopleID");
			} 
			// 이미 로그인했으면 회원가입을 할 수 없게 한다. 회원가입 누르면 창띄우고 메인으로
			if (peopleID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 회원가입이 되어있습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			// 입력된것들이 null값이면 채우라고 하는거
			if(people.getPeopleID() == null || people.getPeoplePassword() == null || people.getPeopleName() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력 되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PeopleDAO peopleDao = new PeopleDAO();
				int result = peopleDao.join(people);
				// 동일한 아이디 일때
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				// 그렇지 않은 경우 전부 다 회원가입이 완료
				else {
					// 회원가입이 성공적으로 이루어진 해당 사용자를 세션 부여한 다음 메인페이지로 이동하게
					session.setAttribute("peopleID", people.getPeopleID());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
		%>
	</body>
</html>