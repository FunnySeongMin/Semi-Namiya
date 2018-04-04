<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
</script>
<form action="${pageContext.request.contextPath}/dispatcher" name="deleteForm" method="post">
<input type="hidden" name="command" value="DeleteReply">
<input type="hidden" name="pno" value="${postVO.pNo}">
<table>
	<tr>
		<th colspan="2">
		<span id="title">${postVO.answerVO.aTitle}</span> 	
		<span id="date">${postVO.answerVO.aDate}</span></th>
	</tr>
	<tr>
		<th><span id="content">${postVO.answerVO.aContent}</span></th>
	</tr>
</table>
<input type="submit" name="deleteReply" id="deleteReply" value="삭제" onclick="submitReplyForm()">
</form>
<br><br>
