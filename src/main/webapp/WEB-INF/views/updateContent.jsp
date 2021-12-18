<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<% pageContext.setAttribute("replaceChar2", "<br>"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReponsiveWeb</title>
	
<script src="https://kit.fontawesome.com/4f536d6cf4.js" crossorigin="anonymous"></script>
<script src="resources/js/contentView.js" defer="defer"></script>

<link rel="stylesheet" href="resources/css/main.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">

</head>
<body> 

<% if(request.getAttribute("msg") != null && request.getAttribute("msg") != ""){ %>
	<script type="text/javascript">
		alert('${msg}');
		<% if(request.getAttribute("msg").equals("글 저장이 완료되었습니다.")) {%>
		if (!confirm("글을 더 수정 하시겠습니까?")) {
            location = "myContent?currentPage="+${currentPage}+";"
        }
		<% }%>
	</script>
<% } %>

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
	<div class="main-container2">
		<div class="contentView-box">
			<form action="updateContentDB" onsubmit="return confirm_check()">
			<c:set var="list" value="${contentsVO}"/>
			<input type="hidden" name="idx" value="${list.idx}">
			<input type="hidden" name="currentPage" value="${currentPage}">
				<div class="contentView-header-box">
					<div class="contentView-back upload-back">
						<a href="myContent?currentPage=${currentPage}" class="contentView-back-btn">
							<i class="fas fa-arrow-left"></i>&nbsp;뒤로
						</a>
						<div class="upload-submit">
							<input type="submit" value="저장" class="upload-submit-btn">
						</div>
					</div>
					<div>
						<div class="upload-header-container">
							<div class="upload-input-header" >
								제목 
							</div>
							<input type="text" class="upload-input-header2" name="title" placeholder="Title" value="${list.title}">
						</div>
						<div class="upload-header-container">
							<div class="upload-input-header" >
								카테고리 
							</div>
							<div class="upload-input-header2">
								<select name="category" class="upload-category-selector">
									<c:if test="${list.category eq 'ALL'}">
										<option value="ALL" selected="selected">ALL</option>
									</c:if>
									<c:if test="${list.category ne 'ALL'}">
										<option value="ALL" >ALL</option>
									</c:if>
									
									<c:if test="${list.category eq 'category1'}">
										<option value="category1" selected="selected">category1</option>
									</c:if>
									<c:if test="${list.category ne 'category1'}">
										<option value="category1">category1</option>
									</c:if>
									
									<c:if test="${list.category eq 'category2'}">
										<option value="category2" selected="selected">category2</option>
									</c:if>
									<c:if test="${list.category ne 'category2'}">
										<option value="category2">category2</option>
									</c:if>
									
									<c:if test="${list.category eq 'category3'}">
										<option value="category3" selected="selected">category3</option>
									</c:if>
									<c:if test="${list.category ne 'category3'}">
										<option value="category3">category3</option>
									</c:if>
									
									<c:if test="${list.category eq 'category4'}">
										<option value="category4" selected="selected">category4</option>
									</c:if>
									<c:if test="${list.category ne 'category4'}">
										<option value="category4">category4</option>
									</c:if>
								</select>
							</div>
						</div>
						<div class="upload-header-container">
							<div class="upload-input-header" >
								이미지 
							</div>
							<input type="text" class="upload-input-header2" name="image" placeholder="Image" value="${list.image}">
						</div>
					</div>
					<div id="uplaod_cnt" class="uplaod_cnt">0 / 4000</div>
				</div>
				<div class="contentView-content-box">
					<textarea id="comment" class="upload-input-textarea" name="content" placeholder="Content" wrap="physical">${list.content}</textarea>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	function confirm_check(){
		if (confirm("저장 하시겠습니까?")) {
            return true;
        } else {
            return false;
        }
	}	
	
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