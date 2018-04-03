<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
a.post {
	text-decoration: none;
	color: black;
}
</style>
<script type="text/javascript">
	function deleteUser(id){
		var flag=confirm("삭제하시겠습니까?");
		if(flag){
			return location.href="dispatcher?command=removeUser&id="+id;
		}else{
			return false;
		}
	}
</script>
전체 회원수 : ${requestScope.userCount}<br><br>
<table class="table table-hover">
	<thead>
		<tr>
			<th>id</th>
			<th>닉네임</th>
			<th>삭제여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${requestScope.list }" var="ulist">
			<tr>
				<td>${ulist.id }</td>
				<td>${ulist.nickName }</td>
				<td><input type="button" value="삭제" onclick="return deleteUser('${ulist.id}')"></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="col-sm-10 text-center">
<!-- 페이징버튼 -->
	<ul class="pagination pagination">
		<!-- 페이징빈 코드 줄여서 변수에 담음 : pb -->
		<c:set var="pb" value="${requestScope.pb}"></c:set>
		<!-- 이전 페이지로 돌아가기 -->
		<c:if test="${pb.previousPageGroup}">		
			<li><a href="dispatcher?command=AdminPage&pageNo=${pb.startPageOfPageGroup-1}">«</a></li>
		</c:if>
		<!-- 페이지그룹 시작번호부터 끝번호 및 현재 페이지 -->
		<c:forEach var="page" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
		<c:choose>
			<c:when test="${pb.nowPage!=page}">
				<li><a href="dispatcher?command=AdminPage&pageNo=${page}">${page}</a></li>
			</c:when>
			<c:otherwise>
				<li class="active"><a href="#">${page}</a></li>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<!-- 다음페이지로 넘어가기  -->
		<c:if test="${pb.nextPageGroup}">		
			<li><a href="dispatcher?command=AdminPage&pageNo=${pb.endPageOfPageGroup+1}">»</a></li>
		</c:if>
	</ul>
</div>


