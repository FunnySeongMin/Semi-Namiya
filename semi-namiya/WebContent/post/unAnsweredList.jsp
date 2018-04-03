<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<table class="table table-hover">
	<thead>
		<tr>
			<th>글번호</th>
			<th>진행상황</th>
			<th>글제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
	</thead>
	<!-- 게시물 리스트 -->
	<tbody>
	<c:forEach var="info" items="${requestScope.listvo.list }">
		<tr>
			<td>${info.pNo}</td>
			<td><span class="label label-danger">진행중</span></td>
			<td><a class="post" href="${pageContext.request.contextPath}/dispatcher?command=ReadPostInfo&pNo=${info.pNo}">
				${info.pTitle }</a></td>
			<c:choose>
				<c:when test="${info.lock=='y' }"><%--비회원의 비공개(y) 링크 보기 --%>
				<td><i class="fas fa-lock"></i>&nbsp;${info.pTitle }</td>
				</c:when>
			</c:choose>
			<td>${info.userVO.nickName }</td>
			<td>${info.pDate}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 글쓰기 view로 넘어가는 버튼 추가 
	  로그인하지 않은 사용자에게는 버튼 제공 X -->
<c:if test="${sessionScope.userVO!=null}">
	<button type="button" value="글쓰기" class="btn btn-primary btn-sm"
		onclick="location.href='${pageContext.request.contextPath}/dispatcher?command=CreatePostView'">글쓰기</button>
</c:if>
<div class="col-sm-10 text-center">
	
	<div class="input-group col-sm-offset-4 col-sm-4">
		
		<!-- 검색메뉴 드랍다운 -->
		<div class="input-group-btn">
			<button id="menuBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				제목 <span class="caret"></span>
			</button>
			<ul id="findMenu" class="dropdown-menu">
				<li><a href="#">제목</a></li>
				<li><a href="#">작성자</a></li>
				<li><a href="#">내용</a></li>
				<!-- <li class="divider"></li>
				<li><a href="#">Separated link</a></li> -->
			</ul>
		</div>
		
<!-- 검색폼 -->
<%-- 		<form name="searchForm" action="${pageContext.request.contextPath}/dispatcher"> 
			폼 설정하면 검색폼 모양 흐트러짐 주의!!!
			
			 --%>
		<input type="text" class="form-control" id="keyword" name="keyword">
		<span class="input-group-btn">
			<button class="btn btn-primary" type="button" id="findBtn">
				<i class="fas fa-search"></i>
			</button>
		</span>
		<input type="hidden" name="command" value="Search">
		<input type="hidden" name="category" value="제목">
	</div>

	<script>
		$(document).ready(function() {
			var category="제목";//검색 카테고리 기본 설정은 "제목"
			$("#findMenu li").click(function() { //검색 카테고리 설정
				 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
				 category = $(this).text(); 
				});
			$("#findBtn").click(function(){ //돋보기 아이콘 눌렀을 때 이동!
				location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
			})
			});
	</script>

	<!-- 페이징버튼 -->
	<ul class="pagination pagination">
		<!-- 페이징빈 코드 줄여서 변수에 담음 : pb -->
		<c:set var="pb" value="${requestScope.listvo.pagingBean}"></c:set>
		<!-- 이전 페이지로 돌아가기 -->
		<c:if test="${pb.previousPageGroup}">		
			<li><a href="dispatcher?command=UnansweredList&pageNo=${pb.startPageOfPageGroup-1 }">«</a></li>
		</c:if>
		<!-- 페이지그룹 시작번호부터 끝번호 및 현재 페이지 -->
		<c:forEach var="page" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
		<c:choose>
			<c:when test="${pb.nowPage!=page }">
				<li><a href="dispatcher?command=UnansweredList&pageNo=${page}">${page}</a></li>
			</c:when>
			<c:otherwise>
				<li class="active"><a href="#">${page}</a></li>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<!-- 다음페이지로 넘어가기 -->
		<c:if test="${pb.nextPageGroup}">		
			<li><a href="dispatcher?command=UnansweredList&pageNo=${pb.endPageOfPageGroup+1 }">»</a></li>
		</c:if>
	</ul>
</div>