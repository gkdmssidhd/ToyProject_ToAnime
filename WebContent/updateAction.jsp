<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- user패키지의 User.DAO클래스를 그대로 가져옴 
실질적으로 사용자가 로그인 시도 하려는걸 처리하는 페이지 -->
<%@ page import="animelist.Animelist" %>
<%@ page import="animelist.AnimelistDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%  request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>만화속으로</title>
</head>
	<body>
		<%
		// 현재 세션 상태를 체크 
			String peopleID = null;
			if(session.getAttribute("peopleID") != null) {
				peopleID = (String) session.getAttribute("peopleID");
			} 
			if (peopleID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			} 
			int animeID = 0;
			// 만약 매개변수로 넘어온 animeID가 존재한다면
			if (request.getParameter("animeID") != null) {
				// animeID에 넣어줌 Integer.parseInt는 null은 절대 받을 수 없다.
				animeID = Integer.parseInt(request.getParameter("animeID"));
			}
			// 번호가 반드시 존재해야 특정글을 볼 수 있다.
			if (animeID == 0 ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
			}
			Animelist anime = new AnimelistDAO().getAnimelist(animeID);
			if (!peopleID.equals(anime.getPeopleID())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
			}
			
			else { // 만약 제목, 내용 입력 안되어있을때
				if(request.getParameter("animeTitle") == null || request.getParameter("animeContent") == null
					|| request.getParameter("animeTitle").equals("") || request.getParameter("animeContent").equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력 되지 않은 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					AnimelistDAO animelistDAO = new AnimelistDAO();
					int result = animelistDAO.update(animeID, request.getParameter("animeTitle"), request.getParameter("animeContent"),
								 request.getParameter("AnimeType"), request.getParameter("AnimeCandy"));
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다..')");
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