<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div id="myCarouselV" class="carousel thumbnail fade">
	<div class="carousel-inner">
		<img src="assets/img/intro.png" align="middle" style="width: 1300px;">
		<div class="lead text-center" style="white-space: pre-wrap;">남이야 잡화점은 한국소프트웨어기술진흥협회 웹프로그래밍 개발자 과정 교육생들이<br>
영화<strong class="text-primary"> 『나미야 잡화점의 기적』</strong>을 보고 아이디어를 얻어 세미프로젝트로 만든 사이트로<br>
영화의 내용처럼 이용자들의 각종 고민을 운영자들이 상담을 해주는 사이트 입니다.<br>
개발자 과정을 걷고있는 교육생들이 만든 사이트이기 때문에 부족한 부분이 많습니다. <br>
다소 부족한 부분이 있더라도 양해를 부탁드립니다.</div>
		</div>
	</div>
<div class="row">
	<!-- Slider -->
	<div class="col-xs-offset-3 col-xs-6">
		<div id="myCarousel" class="carousel slide">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
				<li data-target="#myCarousel" data-slide-to="5"></li>
			</ol>
			<div class="carousel-inner">
				<!-- Slide 1 -->
				<div class="item active">
					<img src="assets/img/강사님.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">서정우 강사님</strong>
						<p style="white-space: pre-wrap;">안녕하세요. 
서정우 강사 입니다.</p>
						<br>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/김유란.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">김유란</strong>
						<p style="white-space: pre-wrap;">안녕하세요. 
PL김유란 입니다.</p>
						<br>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/류완선.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">류완선</strong>
						<p style="white-space: pre-wrap;">안녕하세요. 
SL류완선 입니다.</p>
						<br>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/용다은.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">용다은</strong>
						<p style="white-space: pre-wrap;">안녕하세요. 
DL용다은 입니다.</p>
						<br>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/은성민.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">은성민</strong>
						<p style="white-space: pre-wrap;">안녕하세요. 
PM은성민입니다.</p>
						<br>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/이상욱.jpg" alt="">
					<div class="carousel-caption caption-right">
						<strong class="lead text-warning">이상욱</strong>
						<p style="white-space: pre-wrap;">안녕하세요.
CL이상욱입니다.</p>
						<br>
					</div>
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="fa fa-chevron-left icon-prev"></span>
			</a> 
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="fa fa-chevron-right icon-next"></span>
			</a>
		</div>
		<img src="assets/img/조직도.png" alt="">
	</div>
</div>
