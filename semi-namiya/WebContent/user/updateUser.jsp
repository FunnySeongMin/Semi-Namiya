<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<p style="height: 200px;"></p>
<div class="row updateForm">
	<div class="col-sm-offset-2 col-sm-7 text-center animated fadeInDown">
		<div class="panel panel-primary" id="panels" data-effect="helix">
			<div class="panel-heading">개인정보 수정</div>
			<div class="panel-body">
				<form class="form-horizontal" id ="updateForm" action="${pageContext.request.contextPath }/dispatcher" method="post">
					<div class="form-group">
						<label for="inputEmail" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
						<div class="col-sm-4 input-group">
							<span class="input-group-addon"><i class="fas fa-envelope"></i></span>
							<input type="text" class="form-control" name ="id" value="${userVO.id }"
								placeholder="이메일" readonly>
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label">닉네임</label>
						<div class="col-sm-4 input-group">
							<span class="input-group-addon"><i class="fas fa-user"></i></span>
							<input type="text" class="form-control" id="nick" name="nickName" value="${userVO.nickName }"
								placeholder="닉네임" onkeyup="this.value=this.value.replace(/\s/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
						<div class="col-sm-4 input-group">
							<span class="input-group-addon"><i class="fas fa-key"></i></span>
							<input type="password" class="form-control" id="password1" name ="password" value="${userVO.password }"
								placeholder="비밀번호" onkeyup="this.value=this.value.replace(/\s/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword" class="col-sm-offset-1 col-sm-3 control-label">비밀번호확인</label>
						<div class="col-sm-4 input-group">
							<span class="input-group-addon"><i class="fas fa-key"></i></span>
							<input type="password" class="form-control" id="password2" value="${userVO.password }"
								placeholder="비밀번호확인" onkeyup="this.value=this.value.replace(/\s/g,'')">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-4">
							<input type="hidden" name="command" value="UpdateUser">
							<button type="submit" class="btn btn-primary btn-block">수정</button>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-4">
							<button type="button" id="delBtn" class="btn btn-danger btn-block">회원탈퇴</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		
}); // ready;
</script>