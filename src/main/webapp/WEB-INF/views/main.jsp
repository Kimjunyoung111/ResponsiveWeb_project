<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReponsiveWeb</title>
	
<script src="https://kit.fontawesome.com/4f536d6cf4.js" crossorigin="anonymous"></script>
<script src="resources/js/main.js" defer="defer"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>


<link rel="stylesheet" href="resources/css/main.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">

</head>
<body> 

<nav class="navbar">
	<div class="navbar-logo">
		<i class="fab fa-elementor"></i>
		<a href="main" class="navbar-a">Resposive Board</a>	
	</div>
	
	<ul class="navbar-menu">
		<li><a href="main" class="navbar-btn">메인</a></li>
		<li><a href="content" class="navbar-btn">글</a></li>
		<li><a href="myContent" class="navbar-btn">내글</a></li>
		<li><a href="uploadContent" class="navbar-btn">글쓰기</a></li>
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
	<div class="main-container">
		<div class="main-billboard">
			<div class="board-text">
				<div class="board-title">
					<div>Welcome my web!</div>
				</div>
				<div class="board-content">
					<div>this web is Resposive!!</div>
				</div>
			</div>
		</div>
		
		<div class="content-box">
			<form action="search" class="title-search">
				<div class="main-label">현재 인기 글</div>
				
				<div class="search-box">
					<select name="select">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<div class="text-box">
						<div class="input-box">
							<c:if test="${empty text}">
							<input class="input-box-input" type="text" name="text" placeholder="검색" autocomplete="off" />
							</c:if>
							<c:if test="${not empty text}">
								<input class="input-box-input has-val" type="text" name="text" placeholder="검색" value="${text}" autocomplete="off" />
							</c:if>
							<span class="input-box-focusUp"></span>
						</div>
						<button type="submit">
							<i class="fas fa-search" ></i>
						</button>
					</div>
				</div>
			</form>
			
			<c:set var="contentsList" value="${contentsList.list}"/>
			<c:if test="${list.size() != 0}">
				<c:forEach var="list" items="${contentsList}">
					<div class="content-box-item" onclick="location.href='view?idx=${list.idx}&currentPage=1'">
						<div class="content-box-image">
							<c:if test="${list.image != null || list.image ne null}">
								<img src="${list.image}">
							</c:if>
						</div>
						<div class="content-box-text">
							<div class="content-header">
								<img alt="profile" src="${list.profile}">
								<div class="content-header-user">
									<span>${list.nickname}</span>
									<c:if test="${date.year == list.writedate.year && date.month == list.writedate.month && date.date == list.writedate.date }">
										<fmt:formatDate value="${list.writedate}" pattern="a h:mm"/>
									</c:if>
									<c:if test="${date.year != list.writedate.year || date.month != list.writedate.month ||
										date.date != list.writedate.date }">
										<fmt:formatDate value="${list.writedate}" pattern="yyyy.MM.dd(E)"/>
									</c:if>
								</div>
							</div>
							<div class="content-body">
								<div class="content-title">
									${list.title}
								</div>
							<c:if test="${list.image != null || list.image ne null}">
								<div class="content-content active">
							</c:if>
							<c:if test="${list.image == null || list.image eq null}">
								<div class="content-content">
							</c:if>
									${list.content}
								</div>
							</div>
						</div>
						<div class="content-footer">
							<div class="content-footer-box">
								<div class="content-views">
									조회수 ${list.views}회	
								</div>
								<div class="content-comment">
									댓글 ${list.commentNum}개
								</div>
							</div>
						</div>
					</div>
				</c:forEach>	
			</c:if>
		</div>
		
		<a class="btn-more" href="content">더보기</a>
		
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