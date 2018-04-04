<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<p style="height: 100px;"></p>

<!-- 게시글 -->
<div class="col-sm-offset-2 col-sm-7 animated fadeInDown">
	<form class="form-horizontal" action="${pageContext.request.contextPath}/dispatcher" method="post">
		<div class="panel panel-primary" id="panels" data-effect="helix">
			<div class="panel-heading">
				<span> 제목 : ${requestScope.postVO.pTitle} </span>
			</div> <!-- panel-heading -->
			
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<td>작성자 : ${requestScope.postVO.userVO.nickName} </td>
							<td>작성시간 : ${requestScope.postVO.pDate}</td>
						</tr>
					</thead>
				</table>
				 <div class="alert alert-success" style="white-space: pre-wrap;">${requestScope.postVO.pContent}</div>
			</div>
			<div class="panel-footer text-center">
				<c:if test="${requestScope.postVO.userVO.id==sessionScope.userVO.id}">
					<button type="button" class="btn btn-sm btn-danger" onclick="deleteConfirm()">삭제</button>
					<button type="button" class="btn btn-sm btn-primary" onclick="updateConfirm()">수정</button>
					<button type="button" class="btn btn-sm btn-default" onclick="location.href='dispatcher?command=ReadPostList'">목록</button>
				</c:if>
			</div>
		</div>
	</form>
</div>
<br>
<br>


<!-- 답글보기 -->
<div class="row">
<div class="col-sm-offset-2 col-sm-7">
		<div class="text-center">
			<c:if test="${postVO.reply==1}"> <!-- 답글이있을때만 보여주기 -->
				<button type="button" id="replyViewBtn" class="btn btn-sm btn-primary animated fadeInDown">답글</button>
			</c:if>
			<c:if test="${userVO.grade=='a' && postVO.reply==0}"> <!-- 관리자일때만 답글쓰기 -->
				<!-- <button type="button" id="replyWriteBtn" class="btn btn-sm btn-primary" onclick="location.href='dispatcher?command=CreateReplyView'">답글쓰기</button> -->
				<button type="button" id="replyWriteBtn" class="btn btn-sm btn-primary animated fadeInDown">답글쓰기</button>
			</c:if>
		</div>
<form class="form-horizontal" action="${pageContext.request.contextPath}/dispatcher" method="post">
	<div class="panel panel-info" id="replyViewForm" data-effect="helix">
		<div class="panel-heading">
			답글
		</div> <!-- panel-heading -->
		<div class="panel-body">
			<table class="table table-striped">
					<thead>
						<tr>
							<td>제목 : ${postVO.answerVO.aTitle}</td>
							<td>작성시간 : ${postVO.answerVO.aDate}</td>
						</tr>
					</thead>
				</table>
			<div class="alert alert-info" style="white-space: pre-wrap;">${postVO.answerVO.aContent}</div>
		</div>
		<div class="panel-footer">
			<div class="text-center">
				<c:if test="${userVO.grade == 'a' }">
					<button type="button" id="updateReplyBtn" class="btn btn-sm btn-primary">수정</button>
						<input type="hidden" name="command" value="DeleteReply">
						<input type="hidden" name="pno" value="${postVO.pNo}">		
						<button type="submit" class="btn btn-sm btn-danger">삭제</button>
				</c:if>
			</div> <!-- text-center -->
		</div> <!-- panel-footer -->
	</div> <!-- panel panel-info (replyViewForm) -->
</form>
</div>
</div>
<br>

<!-- 답글쓰기 -->
<div class="row">
	<div class="col-sm-offset-2 col-sm-7">
		<c:if test="${userVO.grade=='a' && postVO.reply==0}"><!-- 관리자일때만 답글쓰기 -->
			<c:import url="/reply/createReply.jsp"/>
		</c:if>
		
		<c:import url="/reply/updateReply.jsp"/>
	</div>
</div>
<script type="text/javascript">
	var flag='view';
	$("#updateView").hide();
	$(document).ready(function() {
		$("#replyViewForm").hide(); // 답글달기뷰 숨기기
		$("#replyWriteForm").hide(); // 답글쓰기뷰 숨기기 
		$("#updateReplyForm").hide() // 답글수정뷰 숨기기
		
		$("#replyViewBtn").click(function() { // 답글보기버튼을 클릭할때
			$("#replyViewBtn").hide(); // 답글보기버튼 숨기기
			$("#replyViewForm").show(); // 답글보기뷰 보여주기
			$("#replyViewForm").addClass("animated pulse"); // 답글달기뷰 보여주면서 애니메이션
		});
		
	/* 	$("#cancelReplyBtn").click(function() {
			$("#replyViewForm").hide();
			$("#replyViewBtn").show();
		}); */
		
		$("#replyWriteBtn").click(function() { // 답글쓰기버튼 클릭할 때
			$("#replyWriteBtn").hide(); // 답글쓰기버튼 숨기기
			$("#replyWriteForm").show(); // 답글쓰기뷰 보여주기
			$("#replyWriteForm").addClass("animated fadeInUp"); // 답글쓰기뷰 보여주면서 애니메이션
		});
		
		$("#updateReplyBtn").click(function() { // 답글수정 버튼 클릭할 때 
			$("#replyViewForm").hide(); // 답글보기뷰 숨기기
			$("#updateReplyForm").show(); // 답글수정뷰 보여주기
			$("#updateReplyForm").addClass("animated fadeIn"); // 답글수정뷰 보여주면서 애니메이션
		});
		
		$("#btnReplyCancel").click(function() { // 답글수정취소 버튼 클릭할 때
			$("#replyViewForm").show(); // 답글보기뷰 보여주기
			$("#updateReplyForm").hide(); // 답글수정뷰 숨기기
		});
		
		$("#update-cancel").click(function() {
			if(flag=='view'){//flag가 view일 때 수정/수정취소 버튼을 누르면 수정폼으로 전환
				$("#togglebarName").text("답글 수정");
				$("#update-cancel").text("수정 취소");
				$("#delete-save").val("저장");
				$("#replyView").hide();
				$("#updateView").show();
				flag='update';
			}else{//flag가 update일 때 수정/수정취소 버튼을 누르면 답글뷰(삭제폼)으로 전환
				$("#togglebarName").text("답글 보기");
				$("#update-cancel").text("수정");
				$("#delete-save").val("삭제");
				$("#replyView").show();
				$("#updateView").hide();
				flag='view';
			}
			
			
		})
	})//ready
	

	function deleteConfirm() {
		var url = "${pageContext.request.contextPath}/dispatcher?command=DeletePost&pNo=${requestScope.postVO.pNo}";
		confirmModal("게시글을 삭제하시겠습니까?",url,"danger")
	}
	function updateConfirm() {
		var url = "${pageContext.request.contextPath}/dispatcher?command=UpdatePostView&pNo=${requestScope.postVO.pNo}";
		confirmModal("게시글을 수정하시겠습니까?",url,"success")
	}
	
	function confirmModal(msg,url,css) {
		BootstrapDialog.confirm({
			title : "<i class='fas fa-check-circle'></i> 알림",
            message: msg,
            type : "type-"+css,
            btnCancelLabel: '취소', 
            btnOKLabel: '확인', 
            btnOKClass: 'btn-'+css,
            callback: function(result) {
                if(result) {
                    location.href = url;
                }else {
                	
                }
            }
        });
	}
</script>
