<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="animelist.Animelist" %>
<%@ page import="animelist.AnimelistDAO" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width" initial-scale="1">
		<link rel="stylesheet" href="css/bootstrap.css"> 
		<link rel="stylesheet" href="css/custom.css"> 
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<title>만화속으로 글쓰기</title>
	</head>
	<body>
		<% 
			// 로그인이 된 사람들은 그 로그인 정보를 담을 수 있도록 만들어준다.
			String peopleID = null;
			// 만약 현재 세션이 존재하면 그 아이디 값을 그대로 받아서 관리하도록
			// getAttribute() 는 Servlet간 공유하는 객체 반환 유형이 Object다. 
			// 이전에 다른 jsp또는 Servlet페이지에 설정된 매개 변수를 가져오는데 씀.
			if (session.getAttribute("peopleID") != null) {
				// String 형변환하고, 세션에 있는 값을 가져와서 peopleID 변수에 해당 아이디가 담긴다. 아니면 null값이 담긴다.
				peopleID = (String) session.getAttribute("peopleID");
			}
			int animeID = 0;
			// 만약 매개변수로 넘어온 AnimeID가 존재한다면
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
			// 유효한 글이라서 0이 아니면 구체적인 정보를 담아서 보여준다.
			Animelist animelist = new AnimelistDAO().getAnimelist(animeID);
		%>
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbor-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>	
					<span class="icon-bar"></span>	
					<span class="icon-bar"></span>	
				</button>
				<a class="navbar-brand" href="main.jsp">만화속으로</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="main.jsp">메인</a></li>
					<li><a href="list.jsp">게시판</a></li>			
				</ul>
				<%	// 로그인이 되어 있지 않은경우만 나올 수 있게 
					// 로그인이 되어있지 않은 사람만! 회원가입이나 로그인이 나올 수 있도록 한다.
					if(peopleID == null) {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dorpdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<!-- 드랍다운 안에 내용 -->
						<ul class="dropdown-menu">
							<li class="active"><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
				<%	// 로그인이 되어있는 사람들만 보는것!
					} else{
				%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dorpdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">회원관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="logoutAction.jsp">로그아웃</a></li>
							</ul>
						</li>
					</ul>
				<% 
					}
				%>
			</div>
		</nav>
		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">만화 제목</td>
							<td colspan="2"><%= animelist.getAnimeTitle() %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= animelist.getPeopleID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= animelist.getAnimeDate().substring(0, 11) + animelist.getAnimeDate().substring(11, 13) +"시" + animelist.getAnimeDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>장르</td>
							<td colspan="2"><%= animelist.getAnimeType() %></td>
						</tr>
						<tr>
							<td>추천도</td>
							<td colspan="2">
							<%
							int candy = Integer.parseInt(animelist.getAnimeCandy());
							for(int i=0; i<candy; i++){
							%>
							🍭							
							<%
							}
							%>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<!-- min-height = 크기 -->
							<td colspan="2" style="min-height: 200px; text-align: center;">
							<!-- replaceAll 특수문자 입력될때 공백처리는 &nbsp로 치환 html 용도로 특수문자들도 출력해줄 수 있게 -->
								<%= animelist.getAnimeContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
							</td>
						</tr>
					</tbody>
				</table>
				<a href="list.jsp" class="btn btn-primary">목록</a>
				<%	// 해당 글의 작성자가 본인이라면 수정할 수 있게 밑에 버튼 두개가 뜸.
					if(peopleID != null && peopleID.equals(animelist.getPeopleID())) {
				%> 	
					<!-- 만약 해당 글의 작성자가 본인이라면 업데이트 jsp에 해당 animeID를 가져갈 수 있게 해서 매개변수로서 가져갈 수 있게 한다.-->
					<a href="update.jsp?animeID=<%= animeID %>" class="btn btn-primary">수정</a>
					<!-- 삭제할 수 있게 -->
					<a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?animeID=<%= animeID %>" class="btn btn-primary">삭제</a>
				<%
					}
				%>
			</div>
		</div>
	</body>
</html>