<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 글쓰기폼 -->
<p style="height: 100px;"></p>
<div class="col-xs-offset-2 col-xs-7 animated fadeInDown">
	<form class="form-horizontal" action="${pageContext.request.contextPath}/dispatcher" method="post">
	
		<input type="hidden" name="command" value="UpdatePost"> 
		<input type="hidden" name="uid" value="${sessionScope.userVO.id}">
		<input type="hidden" name="pNo" value="${requestScope.postVO.pNo}">
		<input type="hidden" id="p_lock" name="p_lock" value="${requestScope.postVO.lock }">
		
		<div class="panel panel-primary" id="panels" data-effect="helix">
			<div class="panel-heading">
				<span>글쓰기</span>
			</div> <!-- panel-heading -->
			<div class="panel-body">
			
					<!-- 제목 -->
					<div class="form-group">
						<label for="inputEmail" class="col-xs-3 control-label">제목</label>
						<div class="col-xs-6 input-group"> 
							<input maxlength="35" type="text" class="form-control" name="pTitle" placeholder="게시글 제목을 입력하세요" required value="${requestScope.postVO.pTitle}">
						</div> 
						<br>
						<!-- 글내용 -->
						<div class="form-group">
							<div class="col-xs-offset-2 col-xs-8 input-group">
								<textarea class="form-control" rows="10" cols="30" name="pContent" required placeholder="본문내용을 입력해주세요">${requestScope.postVO.pContent}</textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-offset-2 col-xs-8 input-group">
								<!-- 공개/비공개 설정 수정을 위한 체크박스 -->
								<c:choose>
									<c:when test="${postVO.lock=='y'}">
										<input type="checkbox" class="js-switch" checked /> <strong class="text-primary"> 비공개설정 </strong>
									</c:when>
									<c:otherwise>
										<input type="checkbox" class="js-switch" /> <strong class="text-primary"> 비공개설정 </strong>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div> <!-- form-group -->
					
					<!-- form-group -->
			
				<!-- form-horizontal -->
			</div>
		</div>
		<div class="panel-footer text-center">
			<button type="submit" class="btn btn-xs btn-primary">등록</button>
			<button type="button" class="btn btn-xs btn-default" onclick="location.href='dispatcher?command=ReadPostList'">취소</button>
		</div>
	</form>
</div>
<script type="text/javascript"> 
var elem = document .querySelector ( ' .js-switch ');
var switchery = new Switchery(elem, { size: 'xsall', color: '#008299' });
</script>