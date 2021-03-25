<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <!-- 스크립트 문장을 쓸 수 있도록 라이브러리 불러오기-->
<%@ page import="java.io.PrintWriter" %>
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
			// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
			// 로그인이 된 사람들은 그 로그인 정보를 담을 수 있도록 만들어준다. 
			// 로그인 한 사람이라면 peopleID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
			String peopleID = null;
			// 만약 현재 세션이 존재하면 그 아이디 값을 그대로 받아서 관리하도록
			// getAttribute() 는 Servlet간 공유하는 객체 반환 유형이 Object다. 
			// 이전에 다른 jsp또는 Servlet페이지에 설정된 매개 변수를 가져오는데 씀.
			if (session.getAttribute("peopleID") != null) {
				// String 형태로 형변환하고, 세션에 있는 값을 가져와서 userID 변수에 해당 아이디가 담긴다. 아니면 null값이 담긴다.
				peopleID = (String) session.getAttribute("peopleID");
			}
		
		%>
		<nav class="navbar navbar-default">
			<div class="navbor-header">
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
				<ul class="nav navbar-nav navbor-right">
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
					<ul class="nav navbar-nav navbor-right">
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
								<th colspan="2" style="background-color:#eeeeee; text-align:center;">글쓰기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="text" class="form-control" placeholder="만화 제목" name="animeTitle" maxlength="50">
								</td>
							</tr>
							<tr>
								<td class="form-contorl">장르<br>
									<input type="radio" class="form-contorl" name="animeType" value="판타지"> 판타지
									<input type="radio" class="form-contorl" name="animeType" value="로맨스"> 로맨스
									<input type="radio" class="form-contorl" name="animeType" value="공포"> 공포
									<input type="radio" class="form-contorl" name="animeType" value="시대극"> 시대극
									<input type="radio" class="form-contorl" name="animeType" value="SF"> SF(공상과학)
									<input type="radio" class="form-contorl" name="animeType" value="액션"> 액션
									<input type="radio" class="form-contorl" name="animeType" value="코미디"> 코미디
									<input type="radio" class="form-contorl" name="animeType" value="미스터리"> 미스터리
									<input type="radio" class="form-contorl" name="animeType" value="스포츠"> 스포츠
								</td>
							</tr>
							<tr>
								<td class="form-contorl">추천도🍭<br>								
									<input type="radio" class="form-contorl" name="animeCandy" value="1"> <label for="1">1점</label>
									<input type="radio" class="form-contorl" name="animeCandy" value="2"> <label for="2">2점</label>
									<input type="radio" class="form-contorl" name="animeCandy" value="3"> <label for="3">3점</label>
									<input type="radio" class="form-contorl" name="animeCandy" value="4"> <label for="4">4점</label>
									<input type="radio" class="form-contorl" name="animeCandy" value="5"> <label for="5">5점</label>
								</td>
							</tr>
							<tr>
								<td>
									<textarea class="form-control" placeholder="만화 내용" name="animeContent" maxlength="2048" style="height: 350px;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="submit" onclick="return confirm('등록하시겠습니까?')" class="btn btn-primary pull-right" value="글쓰기">
				</form>
			</div>
		</div>
	</body>
</html>