<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
a.post {
	text-decoration: none;
	color: black;
}
</style>
<table class="table">
	<tr>
		<td colspan="3">제목: ${requestScope.postVO.pTitle}</td>
	</tr>
	<tr>
		<td>글번호 : ${requestScope.postVO.pNo}</td>
		<td>작성자 : ${requestScope.postVO.userVO.nickName}</td>
		<td>작성시간 : ${requestScope.postVO.pDate}</td>
	</tr>
	<tr>
		<td colspan="3"><pre>${requestScope.postVO.pContent}</pre></td>
	</tr>
</table>
<div class="btnArea">
	<c:if test="${requestScope.postVO.userVO.id==sessionScope.userVO.id}">
		<button type="button" class="btn btn-sm btn-default" onclick="deleteConfirm()">삭제</button>
		<button type="button" class="btn btn-sm btn-default" onclick="updateConfirm()">수정</button>
	</c:if>
	<button type="button" class="btn btn-primary btn-sm"
		onclick="location.href='dispatcher?command=ReadPostList'">목록</button>
	</div>	
		
	<br>
	<br>
	<br>
		
		
		
		<!-- 답글 보기, 쓰기, 수정 뷰 -->
		
  <!--  <div class="row"> -->
      <!-- Accordion -->
      <div class="col-sm-6 col-lg-6">
         <div class="accordion" id="accordion2">
         <c:if test="${postVO.reply==1}"><!-- reply값이 1일때만 답글뷰 보여주기 -->
            <div class="accordion-group">
               <div class="accordion-heading">
                  <a class="accordion-toggle"  id="togglebarName" data-toggle="collapse"
                     data-parent="#accordion2" href="#collapseOne"><!-- 토글바(제목 보이는 부분) -->
                     답글 보기
                  </a>
               </div>
               <div id="collapseOne" class="accordion-body collapse" >
                  <div class="accordion-inner"><!-- 내용 보이는 부분 -->
                  <div class="replyView" id="replyView"><!-- 답글보기 -->
                  	<c:import url="/reply/replyview.jsp"/>
                  </div><!-- 답글보기 -->
                  <div class="updateView" id="updateView"><!-- 답글 수정 -->
                  	<c:import url="/reply/replyupdateview.jsp"/>
                  	
                  </div><!-- 답글 수정 -->
                  
                  <span id="update-cancel">수정</span>
                  </div>
               </div>
            </div>
           </c:if><!-- reply값이 1일때만 답글뷰 보여주기 -->
           
           
           <c:if test="${userVO.grade=='a' && postVO.reply==0}"><!-- 관리자일때만 답글쓰기 -->
            <div class="accordion-group">
               <div class="accordion-heading">
                  <a class="accordion-toggle" data-toggle="collapse"
                     data-parent="#accordion2" href="#collapseThree"> <em
                     class="fa fa-plus fa-fw"></em>답글 쓰기
                  </a>
               </div>
               <div id="collapseThree" class="accordion-body collapse">
                  <div class="accordion-inner">
                  <!-- 글 번호 같이 넘겨 줌 -->
                  <c:import url="/reply/createreplyview.jsp">
                  <c:param name="pNo" value="${postVO.pNo}"/>
                  </c:import>
                  </div>
               </div>
            </div>
           </c:if><!-- 관리자일때만 답글쓰기 -->
           
         </div>
      
      </div>
	
<br>
<br>
<br>


<script type="text/javascript">
	var flag='view';
	$(document).ready(function() {
		$("#updateView").hide();
		
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
