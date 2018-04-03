<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href='https://fonts.googleapis.com/css?family=Lato:400,300,400italic,700,900'
	rel='stylesheet' type='text/css'>

<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="Techie Bootstrap 3 skin">
<meta name="keywords" content="bootstrap 3, skin, flat">
<meta name="author" content="bootstraptaste">
<!-- Bootstrap css -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/css/bootstrap.techie.css" rel="stylesheet">
<!-- loginModal -->
<link href='https://fonts.googleapis.com/css?family=PT+Sans:400,700'
	rel='stylesheet' type='text/css'>
<link href="assets/css/reset.css" rel="stylesheet">
<link href="assets/css/style.css" rel="stylesheet">
<link href="assets/css/demo.css" rel="stylesheet">
<!-- bootstrap-dialog -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.9/css/bootstrap-dialog.min.css">
<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon"
	href="assets/img/favicon-namiya.ico" />
<!-- animate.css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<!-- switchery -->
<link rel="stylesheet" href="assets/css/switchery.css" />

<!-- fontawesom -->
<script defer
	src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- bootstrap-dialog -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.9/js/bootstrap-dialog.min.js"></script>
<!-- Bootstrap 3 has typeahead optionally -->
<script src="assets/js/typeahead.min.js"></script>
<!-- switchery -->
<script src="assets/js/switchery.js"></script>
<title>Insert title here</title>
</head>

<body>
	<form action="${pageContext.request.contextPath}/dispatcher" method="post">
		<input type="hidden" name="command" value="UpdatePost"> 
		<input type="hidden" name="pNo" value="${requestScope.postVO.pNo}">
		<input type="hidden" id="p_lock" name="p_lock" value="${requestScope.postVO.lock }">
		<table class="table">
			<tr>
				<td>제목&nbsp;&nbsp; <input type="text" name="pTitle"
					value="${requestScope.postVO.pTitle}" required="required">
				</td>
			</tr>
			<tr>
				<td><pre>   
     <textarea cols="90" rows="15" name="pContent" required="required">${requestScope.postVO.pContent}</textarea>
     </pre></td>
			</tr>
		</table>

		<!-- 공개/비공개 설정 수정을 위한 체크박스 -->
		<c:choose>
		<c:when test="${postVO.lock=='y'}">
		비공개 설정 <input type="checkbox" class="js-switch" checked/>
		</c:when>
		<c:otherwise>
		비공개 설정 <input type="checkbox" class="js-switch"/>
		</c:otherwise>
		</c:choose>

		<%-- 공개/비공개 글 설정:: 둘 중 하나를 무조건 선택해야 하고 
하나만 선택 가능하게 하기 위해 RADIO BUTTON 이용함! 디폴트는 공개
    비공개 글 설정 여부
<c:choose>
<c:when test="${requestScope.postVO.lock='n'}">
<INPUT type="radio" name="pLock" value="n" checked>공개
<INPUT type="radio" name="pLock" value="y">비공개
</c:when>
<c:otherwise>
<INPUT type="radio" name="pLock" value="n" >공개
<INPUT type="radio" name="pLock" value="y" checked>비공개
</c:otherwise>
</c:choose> --%>
		<br> <br>

		<!-- 등록 취소 버튼 -->
		<div class="btnArea">
			<button type="submit" class="btn btn-sm btn-default">등록</button>
			<button type="button" class="btn btn-sm btn-default"
				onclick="location.href='dispatcher?command=ReadPostList'">취소</button>
		</div>
	</form>
</body>

<!-- 글 수정 시 공개글/비공개글 설정 유지를 위한 javascript 
	  postVO의 lock값을 받아와서 y로 설정된 경우 true
	  n으로 설정된 경우 false를 주어 유지시킨다-->
<script type="text/javascript"> 
$(document).ready(function(){
	$(".js-switch").change(function(){
		//checked 되어 있을 때 p_lock 값을 "y"로
		if($(".js-switch").prop("checked")){
			$("#p_lock").val("y")
		}else{ 
			//checked 안 되어있을 때 p_lock 값을 "n"으로
			$("#p_lock").val("n")
		}
	});
});
var elem = document .querySelector ( ' .js-switch ');
var switchery = new Switchery(elem, { size: 'small', color: '#008299' });
</script>

<br>
<br>
<br>
</html>
