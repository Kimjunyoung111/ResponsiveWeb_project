<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReponsiveWeb</title>
	
<script src="https://kit.fontawesome.com/4f536d6cf4.js" crossorigin="anonymous"></script>
<script src="resources/js/main.js" defer="defer"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>

<link rel="stylesheet" href="resources/css/login.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap" rel="stylesheet">
</head>
<body> 

<% if(request.getAttribute("pass") != null && request.getAttribute("pass") != ""){ %>
	<script type="text/javascript">
		alert('${pass}');
	</script>
<% } %>

<nav class="navbar">
	<div class="navbar-logo">
		<i class="fab fa-elementor"></i>
		<a href="main" class="navbar-a">Resposive Board</a>	
	</div>
	
	<ul class="navbar-menu">
		<li><a href="main" class="navbar-a">메인</a></li>
		<li><a href="content" class="navbar-a">글</a></li>
		<li><a href="myContent" class="navbar-a">내글</a></li>
		<li><a href="uploadContent" class="navbar-a">글쓰기</a></li>
	</ul>
	
	<div class="navbar-login">
		<% if(session.getAttribute("loginStatus").equals("True")){ %>
			<a onclick="userStatus()" class="login-status navbar-a">
				<i class="fas fa-user-check"></i><%=session.getAttribute("nickname")%>님
			</a>
			<a onclick="confirm_logout()" class="logout navbar-a">
				<i class="fas fa-sign-in-alt"></i>로그아웃
			</a>
		<% }else{ %>
		<a href="login" class="login navbar-a">
			<i class="fas fa-sign-in-alt"></i>로그인
		</a>
		<a href="signUp" class="login navbar-a">
			<i class="fas fa-file-signature"></i>회원가입
		</a>
		<% } %>
	</div>
	
	<a href="#" class="navbar-toggleBtn">
		<i class="fas fa-bars"></i>
	</a>
</nav>
<div class="main-box">
	<form class="login-form" action="loginOK" method="post">
		<div class="login-box">
			<div class="header-box">
				<a href="#">Welcome</a>
			</div>
			<div class="header-box2">
				<i class="fas fa-clipboard-check"></i>
			</div>
			<div class="input-box ">
				<input class="input-box-input" type="text" name="id" autocomplete="off" />
				<span class="input-box-focusUp" data-placeholder="Id"></span>
			</div>
			<div class="input-box sign-input">
				<span class="btn-show">
					<i class="far fa-eye"></i>
				</span>
				<input class="input-box-input " type="password" name="password" />
				<span class="input-box-focusUp" data-placeholder="Password"></span>
			</div>
			<div class="alert-msg">
				<span>
					${msg} 
				</span>
			</div>
			<div class="loginCheck-Box">
				<div class="loginCheck-Box2">
					<div class="loginCheck-Box-bg"></div>
					<button type="submit" value="login">Login</button>
				</div>
			</div>
			<div class="login-signUp">
				<span class="sign-txt1">계정이 없으신가요?</span>
				<a class="toggleBtn2" href="#">Sign Up</a>
			</div>
		</div>	
	</form>
	
	<form class="SignUp-form" action="joinOK" method="post">
		<div class="login-box">
			<div class="header-box">
				<a href="#">join-us</a>
			</div>
			<div class="header-box2">
				<i class="fas fa-user-plus"></i>
			</div>
			<div class="input-box sign-input">
				<input class="input-box-input" type="text" name="id" autocomplete="off" onblur="add_has()"/>
				<span class="input-box-focusUp" data-placeholder="Id"></span>
			</div>
			<div class="input-box sign-input">
				<input class="input-box-input " type="text" name="password" onblur="add_has()"/>
				<span class="input-box-focusUp" data-placeholder="Password"></span>
			</div>
			<div class="input-box sign-input">
				<input class="input-box-input " type="text" name="passwordCheck" onblur="add_has()"/>
				<span class="input-box-focusUp" data-placeholder="PasswordCheck"></span>
			</div>
			<div class="alert">
				<span class="alert-msg">
					${msg} 
				</span>
				<span class="alert-pass">
					${pass} 
				</span>
			</div>
			<div class="loginCheck-Box">
				<div class="loginCheck-Box2">
					<div class="loginCheck-Box-bg"></div>
					<button type="submit" value="join">Sign-up</button>
				</div>
			</div>
			<div class="login-signUp">
				<span class="sign-txt1">계정이 있습니다.</span>
				<a class="toggleBtn3" href="#">Login</a>
			</div>
		</div>	
	</form>
	
	<div class="login-copylight">
		<p class="copylight">
		 	copylight 2021.11 ResponsiveWeb_1 loginPage
		</p>
	</div>
</div>

<script type="text/javascript">
	function userStatus(){
        location = "userStatus";
	}	
	
	function confirm_logout(){
		if (confirm("로그아웃 하시겠습까?")) {
            location = "logout";
        }
	}
</script>

</body>
</html>