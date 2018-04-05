<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
a.post {
	text-decoration: none;
	color: black;
}</style>

<div class="row img">
	<div class="col-xs-offset-1 col-xs-9 text-center text-center animated flipInX">
		<img src="assets/img/board.jpg">
	</div> <!-- col-xs-offset-1 col-xs-9 text-center -->
</div> <!-- row img -->
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
			<c:choose><%-- 답변여부 --%>  
				<c:when test="${info.reply==0 }">				
					<td><span class="label label-danger">진행중</span></td>
				</c:when>
				<c:otherwise>
					<td><span class="label label-success">답변완료</span></td>
				</c:otherwise>
			</c:choose><%-- // 답변여부 --%>					
			<c:choose><%--회원 비회원 구분 --%>
				<c:when test="${sessionScope.userVO!=null}"><%-- 회원 --%>								
					<c:choose>	<%-- 공개 비공개 구분 --%>		
					<c:when test="${info.lock=='y' }"><%--비공개(y) 글보기 --%>					
						<c:choose><%--비공개글 권한 --%>
							<c:when test="${sessionScope.userVO.id == info.userVO.id || sessionScope.userVO.grade == 'a'}"><%--관리자이거나 작성자 본인일때 비공개 볼수 있다  --%>							
								<td><a class="post" href="${pageContext.request.contextPath}/dispatcher?command=ReadPostInfo&pNo=${info.pNo}">
								<i class="fas fa-lock"></i>&nbsp;${info.pTitle }</a></td>
							</c:when><%--// 관리자이거나 본인일때 비공개 글 볼수있다--%>							
							<c:otherwise>
								<td><i class="fas fa-lock"></i>&nbsp;${info.pTitle }</td>
							</c:otherwise>						
						</c:choose><%--// 비공개글 권한 --%>
					</c:when><%--// 비공개(y) 글보기 --%>					
					<c:otherwise><%--공개글 보기 --%>
						<td><a class="post" href="${pageContext.request.contextPath}/dispatcher?command=ReadPostInfo&pNo=${info.pNo}">
								${info.pTitle }</a></td>
					</c:otherwise><%-- // 공개글 보기--%>
					</c:choose><%-- // 공개 비공개 구분 --%>
				</c:when><%-- // 회원--%>				
				<c:otherwise><%--비회원 --%>
				<c:choose>
				<c:when test="${info.lock=='y' }"><%--비회원의 비공개(y) 링크 보기 --%>
				<td><i class="fas fa-lock"></i>&nbsp;${info.pTitle }</td>
				</c:when>
				<c:otherwise>
				<td>${info.pTitle }</td>
				</c:otherwise>
				</c:choose>
				</c:otherwise><%-- // 비회원 --%>
			</c:choose><%-- // 회원 비회원 구분 --%>						
			<td>${info.userVO.nickName }</td>
			<td>${info.pDate}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<div class="col-xs-10 text-center">
	<!-- 페이징버튼 -->
	<ul class="pagination pagination">
		<%-- 페이징빈 코드 줄여서 변수에 담음 : pb--%>
		<c:set var="pb" value="${requestScope.listvo.pagingBean}"></c:set>
		<%--이전 페이지로 돌아가기 --%>
		<c:if test="${pb.previousPageGroup}">		
			<li><a href="dispatcher?command=UnansweredList&pageNo=${pb.startPageOfPageGroup-1}">«</a></li>
		</c:if>
		<%--페이지그룹 시작번호부터 끝번호 및 현재 페이지 --%>
		<c:forEach var="page" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
		<c:choose>
			<c:when test="${pb.nowPage!=page}">
				<li><a href="dispatcher?command=UnansweredList&pageNo=${page}">${page}</a></li>
			</c:when>
			<c:otherwise>
				<li class="active"><a href="#">${page}</a></li>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<%-- 다음페이지로 넘어가기  --%>
		<c:if test="${pb.nextPageGroup}">		
			<li><a href="dispatcher?command=UnansweredList&pageNo=${pb.endPageOfPageGroup+1}">»</a></li>
		</c:if>
	</ul>
</div>