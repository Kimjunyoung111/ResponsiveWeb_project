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
			<c:set var="list" value="${contentsVO}"/>
			<jsp:useBean id="date" class="java.util.Date"/>
			<div class="contentView-header-box">
				<div class="contentView-back">
					<a href="javascript:history.back();" class="contentView-back-btn">
						<i class="fas fa-arrow-left"></i>&nbsp;뒤로
					</a>
				</div>
				<div class="contentView-category">${list.category}</div>
				<div class="contentView-title">${list.title}</div>
				<div class="contentView-user-box">
					<div class="contentView-user-status">
						<img alt="profile" src="${list.profile}"> 
						<span>${list.nickname}</span>
						<fmt:formatDate value="${list.writedate}" pattern="yyyy-MM-dd  H:mm"/>
					</div>
					<div class="contentView-viewNum">
						조회 ${list.views}회
					</div>
				</div>
			</div>
			<div class="contentView-content-box">
				<div class="contentView-img-container">
				<c:if test="${list.image != null || list.image ne null}">
					<img src="${list.image}">
				</c:if>
				</div>
				${fn:replace(list.content,replaceChar,"<br/>")}
			</div>
			<div class="comment-box">
				<div class="comment-header">
					<div class="comment-view-btn">
						댓글&nbsp;&nbsp;${list.commentNum}개
					</div>
				</div>
				<% if(session.getAttribute("loginStatus").equals("True")){ %>
				<div class="comment-reply">
					<c:if test="${empty search || search ne 'True'}">
						<form action="reply" class="reply-form">
					</c:if>
					<c:if test="${not empty search && search eq 'True'}">
						<form action="reply2" class="reply-form">
					</c:if>
						<input type="hidden" name="nickname" value="<%=session.getAttribute("nickname")%>">
						<input type="hidden" name="idx" value="${list.idx}">
						<input type="hidden" name="currentPage" value="${currentPage}">
						<c:if test="${not empty search && search eq 'True'}">
							<input type="hidden" name="category" value="${category}">
							<input type="hidden" name="text" value="${text}">
							<input type="hidden" name="select" value="${select}">
							<input type="hidden" name="search" value="${search}">
						</c:if>
						<textarea id="comment" name="comment" class="comment-text" 
							placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의해 제재를 받을 수 있습니다. 건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 표시가 제한됩니다." wrap="physical"></textarea>
						<div class="comment-submit-box">
							<div id="comment_cnt" class="comment_cnt">0 / 300</div>
							<input type="submit" value="댓글달기" class="comment-submit-btn">
						</div>
					</form>
				</div>
				<% }else{ %>
				<div class="comment-reply">
					<form action="reply" class="reply-form">
						<textarea id="comment" name="comment" class="comment-text" 
							placeholder="로그인 이후 댓글을 달아주세요." wrap="physical"></textarea>
						<div class="comment-submit-box">
							<div id="comment_cnt" class="comment_cnt">0 / 300</div>
							<input type="submit" value="댓글달기" class="comment-submit-btn" disabled="disabled">
						</div>
					</form>
				</div>
				<% } %>
				<c:set var="commentsList" value="${commentsList.list}"/>
				<c:forEach var="vo" items="${commentsList}">
					<div class="comment-view">
						<div class="reply-lev">
							<c:if test="${vo.comment_lev > 1}">
							<c:forEach var="i" begin="2" end="${vo.comment_lev}" step="1">
								&nbsp;&nbsp;&nbsp;
							</c:forEach>
								└
							</c:if>
						</div>
						<div class="reply-container">
							<div class="comment-view-header">
								<div class="comment-view-nickname">
									${vo.nickname}
								</div>
							</div>
							<div class="comment-view-comment">
								<div class="comment-view-content">
									 ${fn:replace(vo.content,replaceChar,"<br/>")}
								</div>
								<div class="comment-view-writedate">
									<fmt:formatDate value="${vo.writedate}" pattern="yyyy-MM-dd  H:mm"/>
								</div>
							</div>
							<div class="comment-comment-btn">
								답글
							</div>
						</div>
					</div>
					<% if(session.getAttribute("loginStatus").equals("True")){ %>
					<div class="comment-reply2">
						<c:if test="${empty search || search ne 'True'}">
							<form action="comment_reply" class="reply-form">
						</c:if>
						<c:if test="${not empty search && search eq 'True'}">
							<form action="comment_reply2" class="reply-form">
						</c:if>
							<input type="hidden" name="nickname" value="<%=session.getAttribute("nickname")%>">
							<input type="hidden" name="idx" value="${list.idx}">
							<input type="hidden" name="comment_lev" value="${vo.comment_lev}">
							<input type="hidden" name="target_idx" value="${vo.target_idx}">
							<input type="hidden" name="currentPage" value="${currentPage}">
							<c:if test="${not empty search && search eq 'True'}">
								<input type="hidden" name="category" value="${category}">
								<input type="hidden" name="text" value="${text}">
								<input type="hidden" name="select" value="${select}">
								<input type="hidden" name="search" value="${search}">
							</c:if>
							<textarea id="comment" name="comment" class="comment-text2" 
								placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의해 제재를 받을 수 있습니다. 건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 표시가 제한됩니다." wrap="physical"></textarea>
							<div class="comment-submit-box">
								<div id="comment_cnt2" class="comment_cnt2">0 / 300</div>
								<input type="submit" value="답글달기" class="comment-submit-btn">
							</div>
						</form>
					</div>
					<% }else{ %>
					<div class="comment-reply2">
						<form action="comment_reply" class="reply-form">
							<textarea id="comment" name="comment" class="comment-text2" 
								placeholder="로그인 이후 댓글을 달아주세요." wrap="physical"></textarea>
							<div class="comment-submit-box">
								<div id="comment_cnt2" class="comment_cnt2">0 / 300</div>
								<input type="submit" value="답글달기" class="comment-submit-btn" disabled="disabled">
							</div>
						</form>
					</div>
					<% } %>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
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