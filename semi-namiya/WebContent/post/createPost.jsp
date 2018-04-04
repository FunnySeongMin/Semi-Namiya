<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 글쓰기폼 -->
<p style="height: 100px;"></p>
<div class="col-sm-offset-2 col-sm-7 animated fadeInDown">
	<form class="form-horizontal" action="${pageContext.request.contextPath}/dispatcher" method="post">
		<div class="panel panel-primary" id="panels" data-effect="helix">
			<div class="panel-heading">
				<span>글쓰기</span>
			</div> <!-- panel-heading -->
			<div class="panel-body">
				
					<input type="hidden" name="command" value="CreatePost">
					<!--   
						hidden :: createPostController에 p_lock 넘기기 위해 hidden 줌 
					  	change 하지 않았을 경우, 디폴트를 "n"으로 설정
					-->
					<input type="hidden" id="p_lock" name="p_lock" value="n">
					<!-- 제목 -->
					<div class="form-group">
						<label for="inputEmail" class="col-sm-3 control-label">제목</label>
						<div class="col-sm-6 input-group"> 
							<input type="text" class="form-control" name="pTitle" placeholder="게시글 제목을 입력하세요" required>
						</div> 
						<br>
						<!-- 글내용 -->
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-8 input-group">
								<textarea class="form-control" rows="10" cols="30" name="pContent" required placeholder="본문내용을 입력해주세요"></textarea>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-8 input-group">
								<input type="checkbox" class="js-switch" /> <strong class="text-primary"> 비공개설정 </strong>
							</div>
						</div>
					</div> <!-- form-group -->
					
					<!-- form-group -->
			
				<!-- form-horizontal -->
			</div>
		</div>
		<div class="panel-footer text-center">
			<button type="submit" class="btn btn-sm btn-primary">등록</button>
			<button type="button" class="btn btn-sm btn-default" onclick="location.href='dispatcher?command=ReadPostList'">취소</button>
		</div>
	</form>
</div>
<script type="text/javascript">
var elem = document .querySelector ( ' .js-switch ');
//switchery 버튼 사이즈 small, 배경색 #008299으로 설정
var switchery = new Switchery(elem, { size: 'small', color: '#008299' });
//버튼 누를 때마다 p_lock 값 바꾸기 위한 function
</script>
