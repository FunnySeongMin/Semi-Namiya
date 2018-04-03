<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<form action="${pageContext.request.contextPath}/dispatcher"
		method="post">
		<input type="hidden" name="command" value="CreatePost">
		
		<!--   hidden :: createPostController에 p_lock 넘기기 위해 hidden 줌 
			   change 하지 않았을 경우, 디폴트를 "n"으로 설정
		-->
		<input type="hidden" id="p_lock" name="p_lock" value="n">
		<table class="table">
			<tr>
				<td>제목&nbsp;&nbsp; <input type="text" name="pTitle"
					placeholder="게시글 제목을 입력해 주세요" required="required">
				</td>
			</tr>
			<tr>
				<td><pre>   
     <textarea cols="90" rows="15" name="pContent" required="required"
							placeholder="본문 내용을 입력해 주세요"></textarea>
     </pre></td>
			</tr>
		</table>

		<!-- 공개 비공개 설정 버튼 :: switchery :: on, null -->
		비공개 설정 <input type="checkbox" class="js-switch" />

<!-- 공개/비공개 글 설정:: 둘 중 하나를 무조건 선택해야 하고 
하나만 선택 가능하게 하기 위해 RADIO BUTTON 이용함! 디폴트는 공개!
    비공개 글 설정 여부
<INPUT type="radio" name="pLock" value="n" checked>공개
<INPUT type="radio" name="pLock" value="y">비공개 -->
		<br>
		<br>
		<div class="btnArea">
			<button type="submit" class="btn btn-sm btn-default">등록</button>
			<button type="button" class="btn btn-sm btn-default" onclick="location.href='dispatcher?command=ReadPostList'">취소</button>
		</div>
	</form>
	<br>
	<br>
	<br>
</body>
<script type="text/javascript">
var elem = document .querySelector ( ' .js-switch ');
//switchery 버튼 사이즈 small, 배경색 #008299으로 설정
var switchery = new Switchery(elem, { size: 'small', color: '#008299' });
//버튼 누를 때마다 p_lock 값 바꾸기 위한 function
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
</script>
</html>
