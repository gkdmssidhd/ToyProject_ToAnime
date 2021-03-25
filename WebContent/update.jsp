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
		<title>글수정하기</title>
		
	</head>
	<body>
		<% // 로그인이 된 사람들은 그 로그인 정보를 담을 수 있도록	
			String peopleID = null;
			// 현재 세션이 존재하면 그 아이디 값을 그대로 받아서 관리하도록
			if (session.getAttribute("peopleID") != null) {
				// 세션에 있는 값을 가져와서 userID 변수에 해당 아이디가 담긴다. 아니면 null값이 담긴다.
				peopleID = (String) session.getAttribute("peopleID");
			}
			// 만약 peopleID null 이면 로그인하라고 되돌려 보냄
			if (peopleID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
			int animeID = 0;
			if(request.getParameter("animeID") != null) {
				animeID = Integer.parseInt(request.getParameter("animeID"));
			} 
			if (animeID == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
			}
			// 현재 작성한 글이 본인인지 확인하는거 
			Animelist animelist = new AnimelistDAO().getAnimelist(animeID);
			// 세션의 값과 이글의 작성한사람의 값을 비교하는 것 
			if (!peopleID.equals(animelist.getPeopleID())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
			}
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
					<li><a href="main.jsp">메인</a></li>
					<li class="active"><a href="list.jsp">게시판</a></li>			
				</ul>
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
			</div>
		</nav>
		<div class="container">
			<div class="row">
			<!-- 실제로 글작성한게 writeAction으로 보내지게 animeID도 같이 보내기 -->
				<form method="post" action="updateAction.jsp?animeID=<%= animeID %>">
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<!-- colspan 2개의 열을 잡아먹는다. -->
								<th colspan="2" style="background-color: #eeeeee; text-align: center;"><h4>만화 글 수정 양식</h4></th>	
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>만화제목
									<input type="text" class="form-contorl" placeholder="애니 제목" name="animeTitle" maxlength="50" value="<%= animelist.getAnimeTitle() %>"><br>
								</td>
							</tr>
							<tr>
								<td colspan="2">애니장르<br> 
									<% if ("판타지".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="판타지" checked> <label for="판타지">판타지</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="판타지"> <label for="판타지">판타지</label>
									<% } %>
									<% if ("로맨스".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="로맨스" checked> <label for="로맨스">로맨스</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="로맨스"> <label for="로맨스">로맨스</label>
									<% } %>
									<% if ("공포".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="공포" checked> <label for="공포">공포</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="공포"> <label for="공포">공포</label>
									<% } %>
									<% if ("시대극".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="시대극" checked> <label for="시대극">시대극</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="시대극"> <label for="시대극">시대극</label>
									<% } %>
									<% if ("SF".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="SF" checked> <label for="SF">SF</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="SF"> <label for="SF">SF</label>
									<% } %>
									<% if ("액션".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="액션" checked> <label for="액션">액션</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="액션"> <label for="액션">액션</label>
									<% } %>
									<% if ("코미디".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="코미디" checked> <label for="코미디">코미디</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="코미디"> <label for="코미디">코미디</label>
									<% } %>
									<% if ("미스터리".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value="미스터리" checked> <label for="미스터리">미스터리</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="미스터리"> <label for="미스터리">미스터리</label>
									<% } %>
									<% if ("스포츠".equals(animelist.getAnimeType())) { %>
										<input type="radio" name="AnimeType" value=스포츠 checked> <label for="스포츠">스포츠</label>
									<% } else { %>
										<input type="radio" name="AnimeType" value="스포츠"> <label for="스포츠">스포츠</label>
									<% } %>
								</td>
							</tr>
							<tr>
								<td colspan="2">만화 추천도
									<% if ("1".equals(animelist.getAnimeCandy())) { %>
										<input type="radio" name="AnimeCandy" value="1" checked> <label for="1">1점</label>
									<% } else { %>
										<input type="radio" name="AnimeCandy" value="1"> <label for="1">1점</label>
									<% } %>
									<% if ("2".equals(animelist.getAnimeCandy())) { %>
										<input type="radio" name="AnimeCandy" value="2" checked> <label for="2">2점</label>
									<% } else { %>
										<input type="radio" name="AnimeCandy" value="2"> <label for="2">2점</label>
									<% } %>
									<% if ("3".equals(animelist.getAnimeCandy())) { %>
										<input type="radio" name="AnimeCandy" value="3" checked> <label for="3">3점</label>
									<% } else { %>
										<input type="radio" name="AnimeCandy" value="3"> <label for="3">3점</label>
									<% } %>
									<% if ("4".equals(animelist.getAnimeCandy())) { %>
										<input type="radio" name="AnimeCandy" value="4" checked> <label for="4">4점</label>
									<% } else { %>
										<input type="radio" name="AnimeCandy" value="4"> <label for="4">4점</label>
									<% } %>
									<% if ("5".equals(animelist.getAnimeCandy())) { %>
										<input type="radio" name="AnimeCandy" value="5" checked> <label for="5">5점</label>
									<% } else { %>
										<input type="radio" name="AnimeCandy" value="5"> <label for="5">5점</label>
									<% } %>
								</td>
							</tr>
							<tr>
								<td>만화내용
									<textarea class="form-control" placeholder="만화 내용" name="animeContent" maxlength="2048" style="height: 350px;">
										<%= animelist.getAnimeContent() %>
									</textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글수정">
				</form>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
	</body>
</html>