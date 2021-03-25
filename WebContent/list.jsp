<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
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
		<title>만화속으로 메인페이지</title>
		<style type="text/css">
			a, a:hover {
				color:#000000;
				text-decoration:none;
			}
		
		</style>
	</head>
	<body>
		<% 
			// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
			// 로그인이 된 사람들은 그 로그인 정보를 담을 수 있도록 만들어준다.
			String peopleID = null;
			// 만약 현재 세션이 존재하면 그 아이디 값을 그대로 받아서 관리하도록
			// getAttribute() 는 Servlet간 공유하는 객체 반환 유형이 Object다. 
			// 이전에 다른 jsp또는 Servlet페이지에 설정된 매개 변수를 가져오는데 씀.
			if (session.getAttribute("peopleID") != null) {
				// String 형태로 형변환하고, 세션에 있는 값을 가져와서 peopleID 변수에 해당 아이디가 담긴다. 아니면 null값이 담긴다.
				peopleID = (String) session.getAttribute("peopleID");
			}
			// 1은 기본페이지 의미
			int pageNumber = 1;
			// 만약에 파라미터로 페이지넘버가 넘어오면 페이지 넘버에 해당 파라미터 값을 넣음.
			if (request.getParameter("pageNumber") != null) {
				// 정수로 바꿔주는 paresInt
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
		%>
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>	
					<span class="icon-bar"></span>	
					<span class="icon-bar"></span>	
				</button>
				<a class="navbar-brand" href="main.jsp">만화속으로</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li class="active"><a href="list.jsp">게시판</a></li>			
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
							<li><a href="login.jsp">로그인</a></li>
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
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color:#eeeeee; text-align:center;">번호</th>
							<th style="background-color:#eeeeee; text-align:center;">만화제목</th>
							<th style="background-color:#eeeeee; text-align:center;">작성자</th>
							<th style="background-color:#eeeeee; text-align:center;">작성일</th>
							<th style="background-color:#eeeeee; text-align:center;">만화장르</th>
							<th style="background-color:#eeeeee; text-align:center;">추천도</th>
						</tr>
					</thead>
					<tbody>
						<%
							AnimelistDAO animelistDAO = new AnimelistDAO();
							ArrayList<Animelist> list = animelistDAO.getList(pageNumber) ;
							for(int i =0; i < list.size(); i ++) {
						%>
						<tr>
							<td><%= list.get(i).getAnimeID() %></td>
							<!-- 특수문자 그대로 보이게 하기 -->
							<td>
								<a href="view.jsp?animeID=<%= list.get(i).getAnimeID()%>">
									<%= list.get(i).getAnimeTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
								</a>
							</td>								
							<td><%= list.get(i).getPeopleID() %></td>
							<!-- substring함수 날짜 그대로 가져오기-->
							<td><%= list.get(i).getAnimeDate().substring(0, 11) + list.get(i).getAnimeDate().substring(11, 13) +"시" + list.get(i).getAnimeDate().substring(14, 16) + "분" %></td>
							
							<td><%= list.get(i).getAnimeType() %></td>
							
							<td><%= list.get(i).getAnimeCandy() %></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
					if(pageNumber != 1) {
				%>
					<a href="list.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
				<%
					} if(animelistDAO.nextPage(pageNumber +1)) {
				%>
					<a href="list.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
				<%
					}
				%>
				<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
				</form>
			</div>
		</div>
	</body>
</html>