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
<link href="assets/css/bootstrap.techie.css" rel="stylesheet">
<!-- loginModal -->
<link href='https://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
<link href="assets/css/reset.css" rel="stylesheet">
<link href="assets/css/style.css" rel="stylesheet">
<link href="assets/css/demo.css" rel="stylesheet">
<!-- bootstrap-dialog -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.9/css/bootstrap-dialog.min.css">
<!-- favicon -->
<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon-namiya.ico" />
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
<script src="assets/js/typeahead.min.js"></script>
<!-- emailJS -->
<script type="text/javascript" src="https://cdn.emailjs.com/dist/email.min.js"></script>
<title>Namiya</title>
</head>
<body>
	<!-- 헤더 -->
	<c:import url="import/header.jsp"/>
	
	<div class="container-fluid">
		<!-- 메인 이미지 -->
		<div class="row img">
			<div class="col-sm-offset-1 col-sm-9 text-center text-center animated flipInX">
				<img src="assets/img/board.jpg">
			</div> <!-- col-sm-offset-1 col-sm-9 text-center -->
		</div> <!-- row img -->
		
		<!-- 메인 게시판 -->
		<div class="row main">
			<div class="col-sm-offset-2 col-sm-8">
				<c:import url="${url}"/>
			</div> <!-- col-sm-offset-2 col-sm-8 -->
		</div> <!-- row main -->
		
	</div> <!-- contaniner-fluid -->
	
	<!-- 푸터 -->
	<footer class="container-fluid">
		<c:import url="import/footer.jsp"/>
	</footer>
</body>
<script>
	
</script>
</html>