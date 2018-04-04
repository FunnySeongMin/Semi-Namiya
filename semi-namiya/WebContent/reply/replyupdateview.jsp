<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#cancel").submit(function(){
		location.href="index.jsp";
	});
});
</script>
<form action="${pageContext.request.contextPath}/dispatcher" name="updateForm" method="post">
<input type="hidden" name="command" value="UpdateReply">
<input type="hidden" name="pno" value="${postVO.pNo}">
<table>
	<tr>
		<th>제목</th>
		<th><input type="text" name="aTitle" value="${postVO.answerVO.aTitle}"></th>
	</tr>
	<tr>
		<th>내용</th>
		<th><pre><textarea name="aContent">${postVO.answerVO.aContent}</textarea></pre></th>
	</tr>
</table>
<input type="submit" name="saveReply" id="saveReply" value="저장">
</form>
<br><br>
