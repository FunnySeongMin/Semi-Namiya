<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	
	
	$("#cancel").submit(function(){
		location.href="index.jsp";
	});
});
</script>
<form action="dispatcher">
<input type="hidden" name="command" value="UpdateReply">
<input type="hidden" name="pno" value="${requestScope.avo.pNo }">
<table>
	<tr>
		<th id="title">제목</th>
		<th><input type="text" name="atitle" value=""></th>
	</tr>
	<tr>
		<th id="content">내용</th>
		<th><pre><textarea rows="50" cols="50" name="acontent"></textarea></pre></th>
	</tr>
</table>
<br><br>
<input type="submit" value="저장">	<input type="button" id="cancel" value="취소">
</form>
    