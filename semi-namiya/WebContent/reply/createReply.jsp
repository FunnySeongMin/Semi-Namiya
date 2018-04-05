<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="panel panel-info" id="replyWriteForm">
	<form class="form-horizontal" action="${pageContext.request.contextPath}/dispatcher" method="post">
		<input type="hidden" name="command" value="CreateReply">
		<input type="hidden" name="pno" value="${requestScope.postVO.pNo}">
		<div class="panel panel-info" id="panels" data-effect="helix">
			<div class="panel-heading">
				<span>답글쓰기</span>
			</div>
			<!-- panel-heading -->
			<div class="panel-body">
				<!-- 제목 -->
				<div class="form-group">
					<label for="inputEmail" class="col-xs-3 control-label">제목</label>
					<div class="col-xs-6 input-group">
						<input type="text" class="form-control" maxlength="35" name="atitle"
							placeholder="답글 제목을 입력하세요" required>
					</div>
					<br>
					<!-- 글내용 -->
					<div class="form-group">
						<div class="col-xs-offset-2 col-xs-8 input-group">
							<textarea class="form-control" rows="10" cols="30" name="acontent" required placeholder="본문내용을 입력해주세요"></textarea>
						</div>
					</div>
				</div>
				<!-- form-group -->

				<!-- form-group -->

				<!-- form-horizontal -->
			</div>
		</div>
		<div class="panel-footer text-center">
			<button type="submit" class="btn btn-xs btn-primary">등록</button>
		</div>
	</form>
</div>