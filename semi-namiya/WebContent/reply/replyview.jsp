<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({//저장된 답글 불러오기
            type:"get",
            dataType:"json",
            url:"${pageContext.request.contextPath}/dispatcher",
            data:"command=ReadReply&pno="+${postVO.pNo},
            success:function(data){
              $("#title").html(data.aTitle);
              $("#date").html(data.aDate);
              $("#content").html("<pre>"+data.aContent+"</pre>");
            }//sucess
         });//ajax
		$("#update").click(function(){
			location.href="dispatcher?command=UpdateReplyView&pno=";
		});
		$("#delete").click(function(){
			location.href="dispatcher?command=DeleteReply&pno=";
		});
	});
</script>
<table>
	<tr>
		<th colspan="2"><span id="title"></span> 	<span id="date"></span></th>
		
	</tr>
	<tr>
		<th><span id="content"></span></th>
		<th></th>
	</tr>
</table>
<br><br>
<input type="button" id="update" value="수정">	<input type="button" id="delete" value="삭제">