<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- user패키지의 User.DAO클래스를 그대로 가져옴 
실질적으로 사용자가 로그인 시도 하려는걸 처리하는 페이지 -->
<%@ page import="animelist.AnimelistDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%  request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<!-- User를 자바빈즈로 사용/ SCOPE 현재 페이지 안에서만 빈즈가 사용될 수 있게 한다. property 값을 저장할 수 있는 거 -->
<jsp:useBean id="animelist" class="animelist.Animelist" scope="page" />
<jsp:setProperty name="animelist" property="animeTitle" />
<jsp:setProperty name="animelist" property="animeContent" />
<jsp:setProperty name="animelist" property="animeType" />
<jsp:setProperty name="animelist" property="animeCandy" />

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
		// 피플 아이디 이름으로 세션이 존재하는 회원들은
			if(session.getAttribute("peopleID") != null) {
		// 유저 아이디에 해당 세션값을 넣어준다.
				peopleID = (String) session.getAttribute("peopleID");
			} 
			if (peopleID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			} else {
				if(animelist.getAnimeTitle() == null || animelist.getAnimeContent() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력 되지 않은 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					System.out.println(">>> " + animelist.toString());
					AnimelistDAO animelistDAO = new AnimelistDAO();
					int result = animelistDAO.write(animelist.getAnimeTitle(), peopleID, animelist.getAnimeContent(),
								 animelist.getAnimeType(), animelist.getAnimeCandy());
					// -1은 디비 오류
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					// 나머지는 다 성공적으로 글이 작성되면 게시판화면으로 이동하게 한다.
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'list.jsp'");
						script.println("</script>");
					}
				}
			}
		%>
	</body>
</html>