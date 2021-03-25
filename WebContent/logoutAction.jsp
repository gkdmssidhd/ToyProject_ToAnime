<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="people.PeopleDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
	<body>
		<%	// 현재 이페이지에 접속한 회원이 세션을 빼앗기도록 만들어서 로그아웃 시켜줌
			// invalidate함수 - 세션을 없애고 세션에 속해있는 값들을 모두 없앤다.
			session.invalidate();
		%>
		<script>
			location.href = 'main.jsp';
		</script>
	</body>
</html>