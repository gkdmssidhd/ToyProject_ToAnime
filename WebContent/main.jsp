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
		<title>만화속으로 메인페이지</title>
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
			<div class="jumbotron">
				<div class="container">
					<h1>만화속으로</h1>
					<p>어릴적 추억의 만화들과 요즘 핫하게 뜨고 있는 만화들의 기록 남겨보기.</p>
					<p><a class="btn btn-primary btn-pull" href="list.jsp" role="button">자세히 알아보기</a></p>
				</div>
			</div>
		</div>
		<div class="container">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<ol	class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					<li data-target="#myCarousel" data-slide-to="3"></li>
				</ol>
				<div class="carousel-inner">
					<div class="item active">
						<img src="image/image1.jpg">
					</div>
					<div class="item">
						<img src="image/image2.jpg">
					</div>
					<div class="item">
						<img src="image/image3.jpg">
					</div>
					<div class="item">
						<img src="image/image4.png">
					</div>
				</div>
				<!-- 사진 왼쪽 오른쪽으로 넘길 수 있게 해주는거  -->
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left"></span>
				</a>				
				<a class="right carousel-control" href="#myCarousel" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right"></span>
				</a>						
			</div>
		</div>
	</body>
</html>