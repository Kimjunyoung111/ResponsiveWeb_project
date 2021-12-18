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
<script src="resources/js/content.js" defer="defer"></script>
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
		<div class="content-box2">
		
			<form action="search" class="title-search">
				<div class="category-select">
					<c:if test="${empty search || search ne 'True'}">
						<c:if test="${category eq 'ALL'}">
							<a href="#" id="ALL" class="category categoryCur">모두</a>
						</c:if>
						<c:if test="${category ne 'ALL'}">
							<a href="?category=ALL" id="ALL" class="category">모두</a>
						</c:if>
						<c:if test="${category eq 'category1'}">
							<a href="#" id="category1" class="category categoryCur">category1</a>
						</c:if>
						<c:if test="${category ne 'category1'}">
							<a href="?category=category1" id="category1" class="category">category1</a>
						</c:if>
						<c:if test="${category eq 'category2'}">
							<a href="#" id="category2" class="category categoryCur">category2</a>
						</c:if>
						<c:if test="${category ne 'category2'}">
							<a href="?category=category2" id="category2" class="category">category2</a>
						</c:if>
						<c:if test="${category eq 'category3'}">
							<a href="#" id="category3" class="category categoryCur">category3</a>
						</c:if>
						<c:if test="${category ne 'category3'}">
							<a href="?category=category3" id="category3" class="category">category3</a>
						</c:if>
						<c:if test="${category eq 'category4'}">
							<a href="#" id="category4" class="category categoryCur">category4</a>
						</c:if>
						<c:if test="${category ne 'category4'}">
							<a href="?category=category4" id="category4" class="category">category4</a>
						</c:if>
					</c:if>
					<c:if test="${not empty search && search eq 'True'}">
						<c:if test="${category eq 'ALL'}">
							<a href="#" id="ALL" class="category categoryCur">모두</a>
						</c:if>
						<c:if test="${category ne 'ALL'}">
							<a href="?category=ALL&text=${text}&select=${select}&search=${search}" id="ALL" class="category">모두</a>
						</c:if>
						<c:if test="${category eq 'category1'}">
							<a href="#" id="category1" class="category categoryCur">category1</a>
						</c:if>
						<c:if test="${category ne 'category1'}">
							<a href="?category=category1&text=${text}&select=${select}&search=${search}" id="category1" class="category">category1</a>
						</c:if>
						<c:if test="${category eq 'category2'}">
							<a href="#" id="category2" class="category categoryCur">category2</a>
						</c:if>
						<c:if test="${category ne 'category2'}">
							<a href="?category=category2&text=${text}&select=${select}&search=${search}" id="category2" class="category">category2</a>
						</c:if>
						<c:if test="${category eq 'category3'}">
							<a href="#" id="category3" class="category categoryCur">category3</a>
						</c:if>
						<c:if test="${category ne 'category3'}">
							<a href="?category=category3&text=${text}&select=${select}&search=${search}" id="category3" class="category">category3</a>
						</c:if>
						<c:if test="${category eq 'category4'}">
							<a href="#" id="category4" class="category categoryCur">category4</a>
						</c:if>
						<c:if test="${category ne 'category4'}">
							<a href="?category=category4&text=${text}&select=${select}&search=${search}" id="category4" class="category">category4</a>
						</c:if>
					</c:if>
				</div>
				<input type="hidden" name="category" value="${category}">
					
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
			<c:set var="list" value="${contentsList.list}"/>
			<c:if test="${list.size() == 0}">
				<div class="content-box-item2 search-no">
					<div class="content-box-search ">
						<marquee>
							<i class="fas fa-asterisk"></i>&nbsp;&nbsp;검색 결과가 없습니다.&nbsp;&nbsp;<i class="fas fa-asterisk"></i>
						</marquee>
					</div>
				</div>
			</c:if>
			
			<jsp:useBean id="date" class="java.util.Date"/>
			<c:if test="${list.size() != 0}">
				<c:forEach var="list" items="${list}">
					<div class="content-box-item2">
					
						<div class="content-box-image2">
							<c:if test="${not empty list.image || list.image ne null}">
								<img src="${list.image}">
							</c:if>
						</div>
						
						<div class="content-box-container">
							<div class="content-box-text2">
								<div class="content-header2">
									<div class="content-container2">
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
									<div class="content-setting">
										<a class="content-update" onclick="confirm_update(${list.idx},${contentsList.currentPage})">
											<i class="fas fa-pen"></i> 수정
										</a>
										<a class="content-delete" onclick="confirm_delete(${list.idx},${contentsList.currentPage})">
											<i class="fas fa-minus"></i> 삭제
										</a>
									</div>
								</div>
								<div class="content-body " onclick="location.href='contentView?idx=${list.idx}&currentPage=${contentsList.currentPage}'">
									<div class="content-title">
										${list.title}
									</div>
								<c:if test="${not empty list.image || list.image ne null}">
									<div class="content-content2 active">
								</c:if>
								<c:if test="${empty list.image || list.image eq null}">
									<div class="content-content2">
								</c:if>
										${fn:replace(list.content,replaceChar,"<br/>")}
									</div>
								</div>
							</div>
							<div class="content-footer">
								<div class="content-footer-box">
									<div class="content-views">
										조회 ${list.views}회	
									</div>
									<div class="content-comment">
										댓글 ${list.commentNum}개
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>	
			</c:if>
		</div>
		
		<c:if test="${empty search || search ne 'True'}">
			<div class="btn-Box">
				<c:if test="${contentsList.currentPage > 1}">
					<button class="content-btn button1" type="button" title="첫 페이지로" onclick="location.href='?currentPage=1&category=${category}'">처음</button>
				</c:if>
				<c:if test="${contentsList.currentPage <= 1}">
					<button class="content-btn button2" type="button" title="이미 첫 페이지입니다." disabled="disabled">처음</button>
				</c:if>
				<c:if test="${contentsList.startPage > 1}">
					<button class="content-btn button1" type="button" title="이전 10페이지로" 
						onclick="location.href='?currentPage=${contentsList.startPage - 1}&category=${category}'">이전</button>
				</c:if>
				<c:if test="${contentsList.startPage <= 1}">
					<button class="content-btn button2" type="button" title="이미 첫 10 페이지입니다." disabled="disabled">이전</button>
				</c:if>
				<c:forEach var="i" begin="${contentsList.startPage}" end="${contentsList.endPage}" step="1">
					<c:if test="${contentsList.currentPage == i}">
						<button class="content-btn button2 currentPage-btn2" type="button" disabled="disabled">${i}</button>
					</c:if>
					<c:if test="${contentsList.currentPage != i && (contentsList.currentPage == i+1 || contentsList.currentPage == i-1 ||
							contentsList.currentPage == i+2 || contentsList.currentPage == i-2) }">
						<button class="content-btn button1 currentPage-btn2" type="button" onclick="location.href='?currentPage=${i}&category=${category}'">${i}</button>
					</c:if>
					<c:if test="${contentsList.currentPage != i && contentsList.currentPage != i+1 && contentsList.currentPage != i-1 &&
							contentsList.currentPage != i+2 && contentsList.currentPage != i-2}">
						<button class="content-btn button1 currentPage-btn1" type="button" onclick="location.href='?currentPage=${i}&category=${category}'">${i}</button>
					</c:if>
				</c:forEach>
				<c:if test="${contentsList.endPage < contentsList.totalPage}">
					<button class="content-btn button1" type="button" title="다음 10페이지로" 
						onclick="location.href='?currentPage=${contentsList.endPage + 1}&category=${category}'">다음</button>
				</c:if>
				<c:if test="${contentsList.endPage >= contentsList.totalPage}">
					<button class="content-btn button2" type="button" title="이미 마지막 10 페이지입니다." disabled="disabled">다음</button>
				</c:if>
				<c:if test="${contentsList.currentPage < contentsList.totalPage}">
					<button class="content-btn button1" type="button" title="마지막 페이지로" 
						onclick="location.href='?currentPage=${contentsList.totalPage}&category=${category}'">맨뒤</button>
				</c:if>
				<c:if test="${contentsList.currentPage >= contentsList.totalPage}">
					<button class="content-btn button2" type="button" title="이미 마지막 페이지입니다." disabled="disabled">맨뒤</button>
				</c:if>		
			</div> 
		</c:if>
		<c:if test="${not empty search && search eq 'True'}">
			<div class="btn-Box">
				<c:if test="${contentsList.currentPage > 1}">
					<button class="content-btn button1" type="button" title="첫 페이지로" 
						onclick="location.href='?currentPage=1&category=${category}&text=${text}&select=${select}&search=${search}'">처음</button>
				</c:if>
				<c:if test="${contentsList.currentPage <= 1}">
					<button class="content-btn button2" type="button" title="이미 첫 페이지입니다." disabled="disabled">처음</button>
				</c:if>
				<c:if test="${contentsList.startPage > 1}">
					<button class="content-btn button1" type="button" title="이전 10페이지로" 
						onclick="location.href='?currentPage=${contentsList.startPage - 1}&category=${category}&text=${text}&select=${select}&search=${search}'">이전</button>
				</c:if>
				<c:if test="${contentsList.startPage <= 1}">
					<button class="content-btn button2" type="button" title="이미 첫 10 페이지입니다." disabled="disabled">이전</button>
				</c:if>
				<c:forEach var="i" begin="${contentsList.startPage}" end="${contentsList.endPage}" step="1">
					<c:if test="${contentsList.currentPage == i}">
						<button class="content-btn button2 currentPage-btn2" type="button" disabled="disabled">${i}</button>
					</c:if>
					<c:if test="${contentsList.currentPage != i && (contentsList.currentPage == i+1 || contentsList.currentPage == i-1 ||
							contentsList.currentPage == i+2 || contentsList.currentPage == i-2) }">
						<button class="content-btn button1 currentPage-btn2" type="button" 
							onclick="location.href='?currentPage=${i}&category=${category}&text=${text}&select=${select}&search=${search}'">${i}</button>
					</c:if>
					<c:if test="${contentsList.currentPage != i && contentsList.currentPage != i+1 && contentsList.currentPage != i-1 &&
							contentsList.currentPage != i+2 && contentsList.currentPage != i-2}">
						<button class="content-btn button1 currentPage-btn1" type="button" 
							onclick="location.href='?currentPage=${i}&category=${category}&text=${text}&select=${select}&search=${search}'">${i}</button>
					</c:if>
				</c:forEach>
				<c:if test="${contentsList.endPage < contentsList.totalPage}">
					<button class="content-btn button1" type="button" title="다음 10페이지로" 
						onclick="location.href='?currentPage=${contentsList.endPage + 1}&category=${category}&text=${text}&select=${select}&search=${search}'">다음</button>
				</c:if>
				<c:if test="${contentsList.endPage >= contentsList.totalPage}">
					<button class="content-btn button2" type="button" title="이미 마지막 10 페이지입니다." disabled="disabled">다음</button>
				</c:if>
				<c:if test="${contentsList.currentPage < contentsList.totalPage}">
					<button class="content-btn button1" type="button" title="마지막 페이지로" 
						onclick="location.href='?currentPage=${contentsList.totalPage}&category=${category}&text=${text}&select=${select}&search=${search}'">맨뒤</button>
				</c:if>
				<c:if test="${contentsList.currentPage >= contentsList.totalPage}">
					<button class="content-btn button2" type="button" title="이미 마지막 페이지입니다." disabled="disabled">맨뒤</button>
				</c:if>		
			</div> 
		</c:if>
	</div>
</div>

<script type="text/javascript">
	function confirm_update(idx,currentPage){
		if (confirm("글을 수정 하시겠습니까?")) {
            location = "updateContent?idx="+idx+"&currentPage="+currentPage;
        }
	}	
	
	function confirm_delete(idx,currentPage){
		if (confirm("글을 삭제 하시겠습니까?")) {
            location = "delete?idx="+idx+"&currentPage="+currentPage;
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