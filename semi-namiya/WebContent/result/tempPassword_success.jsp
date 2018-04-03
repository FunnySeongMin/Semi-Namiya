<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href='https://fonts.googleapis.com/css?family=Lato:400,300,400italic,700,900' rel='stylesheet' type='text/css'>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="Techie Bootstrap 3 skin">
<meta name="keywords" content="bootstrap 3, skin, flat">
<meta name="author" content="bootstraptaste"> 
<!-- Bootstrap css -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> 
<link href="../assets/css/bootstrap.techie.css" rel="stylesheet">
<!-- loginModal -->
<link href='https://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
<link href="../assets/css/reset.css" rel="stylesheet">
<link href="../assets/css/style.css" rel="stylesheet">
<link href="../assets/css/demo.css" rel="stylesheet">
<!-- bootstrap-dialog -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.9/css/bootstrap-dialog.min.css">
<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon-namiya.ico" />
<!-- animate.css -->
<link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

<!-- fontawesom -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- bootstrap-dialog -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.9/js/bootstrap-dialog.min.js"></script>
<!-- Bootstrap 3 has typeahead optionally -->
<script src="../assets/js/typeahead.min.js"></script>
<!-- emailJS -->
<script type="text/javascript" src="https://cdn.emailjs.com/dist/email.min.js"></script>
<title>tempPassword_fail</title>
</head>
<body>
</body>
<script>
$(document).ready(function() {
	var email = "${param.id}";
	var password = "${param.password}";
	alert(email+"\n"+password)	
	BootstrapDialog.show({
			type : "type-info",
			title : "알림",
			message : "이메일로 임시비밀번호를 보내시겠습니까?",
			closable : false,
			onhidden : function(dialogRef) {
				location.href = "${pageContext.request.contextPath}/index.jsp";
			},
			buttons : [ {
				icon : 'glyphicon glyphicon-send',
				label : '발송',
				cssClass : 'btn-info',
				autospin : true,
				action : function(dialogRef) {
					passwordMailSend(email, password); // 해당이메일로 임시비밀번호 발송
					dialogRef.enableButtons(false);
					dialogRef.setClosable(false);
					dialogRef.getModalBody().html("임시비밀번호를 발송중입니다");
					setTimeout(function() {
						dialogRef.close();
					}, 3000);
				} // action
			}, {
				label : '취소',
				action : function(dialogRef) {
					dialogRef.close();
				} // action
			} ]
		// buttons
		}); // bootstrapDialog
		
		// 임시비밀번호 메일로 발송
		function passwordMailSend(email,password) {
			var emailC = {
				"recipient":email, // 받는사람의 이메일주소
				"title":"안녕하세요 남이야잡화점의 기적입니다", // 이메일 제목
				"contents":password // 이메일 내용
			}
			emailjs.init("user_0CjQxIrj0fRbRXubJes54");
			emailjs.send("oper37370_gmail_com", "namiyamail", emailC)
			.then(function(response) { // 이메일 발송 성공시
				console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
			}, function(err) { //이메일 발송 실패시
				console.log("FAILED. error=", err); 
			});
		} // passwordMailSend
		
	}); // ready
</script>
</html>