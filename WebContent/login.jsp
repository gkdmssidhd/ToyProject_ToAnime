<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width", initial-scale="1">
		<link rel="stylesheet" href="css/bootstrap.css">
		<!-- 애니메이션 담당할 자바스크립트 제리 워리 특정홈피에서 가져오기 -->
		<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
		<!-- 부트스트립에서 기본적으로 제공해주는 js파일도 참조하겠다. -->
		<script src="js/bootstrap.js"></script>
		<title>로그인</title>
	</head>
<body>
	<!-- 내비게이션은 하나의 웹사이트에 전반적인 구성 헤더는 홈페이지의 로고를 담는 영역 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
			</button>
			<!-- brand는 로고 같은거 -->
			<a class="navbar-brand" href="main.jsp">만화속으로</a>
		</div>
		<!-- 아이디는 위에 데이터타겟이랑 똑같게 해줘야 함. -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- ul -> 하나의 리스트 -->
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="list.jsp">게시판</a></li>			
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="3" class="dorpdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;">
					<form method="post" action="loginAction.jsp">
						<h3 style="text-align: center;">로그인</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="peopleID" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="peoplePassword" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="로그인">
					</form>
				</div>
			</div>
		<div class="col-lg-4"></div>
	</div>
</body>
</html>