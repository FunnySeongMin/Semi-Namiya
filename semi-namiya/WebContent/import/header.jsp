<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<nav class="navbar navbar-inverse" role="navigation">
	<div class="container-fluid">
		<!-- 헤더 메인메뉴 설정 -->
		<div class="navbar-header animated rotateIn">
			<a href="#"><img src="assets/img/logo.png"></a>
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex2-collapse"></button>
			<a class="navbar-brand" href="#"></a>
		</div> <!-- navbar-header -->
		
		<!-- 헤더 메뉴설정 -->
		<ul class="nav navbar-nav">
			<li><a id="home" href="index.jsp"><i class="fas fa-home"></i> Home</a></li> 
			<!-- <li class="active"><a href="#">Link</a></li> -->
		</ul> <!-- nav navbar-nav -->
		
		
		
		<!-- 헤더 오른쪽메뉴 설정 -->
		<!-- 회원/관리자/비회원 상태에 따라 헤더 메뉴 전환 -->
		<c:choose>
		<c:when test="${!empty userVO && userVO.grade=='m'}"><!-- 회원일 경우 -->
			<ul class="nav navbar-nav navbar-right">
			<li id="headerName" class="navbar-brand">${userVO.nickName}님</li>
			<!-- 드랍다운메뉴 설정 -->
			<li class="dropdown">
			<a href="#"  id="mypage" class="dropdown-toggle" data-toggle="dropdown"><i class="fas fa-user"></i>마이페이지 <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.request.contextPath}/dispatcher?command=UpdateUserView">개인정보 수정</a></li>
						<li><a href="${pageContext.request.contextPath}/dispatcher?command=ReadMyPostList">내상담목록</a></li>
						<!-- <li class="divider"></li>
						<li class="dropdown-header">Dropdown header</li> -->
						<!-- <li><a href="#">Separated link</a></li>
						<li><a href="#">One more separated link</a></li> -->
					</ul> <!-- dropdown-menu -->
			</li> <!-- dropdown -->
			<li><a id= "logoutModal" href="${pageContext.request.contextPath}/dispatcher?command=Logout"><span class="fas fa-sign-out-alt fa-lg"></span>로그아웃</a></li>
			</ul> <!-- nav navbar-nav navbar-right -->
		</c:when>
		<c:when test="${!empty userVO && userVO.grade=='a'}"><!-- 관리자일 경우 -->
			<ul class="nav navbar-nav navbar-right">
			<li class="navbar-brand">${userVO.nickName}님</li>
			<!-- 드랍다운메뉴 설정 -->
			<li class="dropdown">
			<a id="adminModal" href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fas fa-user"></i>관리자 페이지 <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="${pageContext.request.contextPath}/dispatcher?command=UnansweredList">답변없는 게시글 목록</a></li>
						<li><a href="#">회원 관리</a></li>
						<!-- <li class="divider"></li>
						<li class="dropdown-header">Dropdown header</li> -->
						<!-- <li><a href="#">Separated link</a></li>
						<li><a href="#">One more separated link</a></li> -->
					</ul> <!-- dropdown-menu -->
			</li> <!-- dropdown -->
			<li><a id="logoutModal" href="${pageContext.request.contextPath}/dispatcher?command=Logout"><span class="fas fa-sign-out-alt fa-lg"></span>로그아웃</a></li>
			</ul> <!-- nav navbar-nav navbar-right -->
		</c:when>
		<c:otherwise><!-- 비회원일 경우(비로그인 상태) -->
		<!-- 로그인모달 -->
		<ul class="cd-main-nav__list js-signin-modal-trigger nav navbar-nav navbar-right">
			<li><a id="loginModal" href="#0" data-signin="login"><span class="fas fa-sign-in-alt fa-lg" data-signin="login"></span>로그인</a></li>
			<li><a id="joinModal" href="#0" data-signin="signup"><span class="fas fa-user-plus fa-lg" data-signin="signup"></span> 회원가입</a></li>
		</ul> <!-- cd-main-nav__list js-signin-modal-trigger nav navbar-nav navbar-right -->
		</c:otherwise>
		</c:choose>
	</div> <!-- container-fluid -->
</nav> <!-- navbar navbar-inverse -->
<script>
$(document).ready(function() {
	
	// 애니메이션 추가
	$("#home, #mypage, #loginModal, #joinModal, #logoutModal, #adminModal").hover(function() {
		$(this).prop("class","animated bounceIn");
	}, function() {
		$(this).prop("class","");
	})
})
</script>

<!-- LoginModal -->
<c:import url="/import/loginModal.jsp"/>
