<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="cd-signin-modal js-signin-modal">
	<!-- this is the entire modal form, including the background -->
	<div class="cd-signin-modal__container">
		<!-- this is the container wrapper -->
		<ul
			class="cd-signin-modal__switcher js-signin-modal-switcher js-signin-modal-trigger">
			<li><a href="#0" data-signin="login" data-type="login">로그인</a></li>
			<li><a href="#0" data-signin="signup" data-type="signup">회원가입</a></li>
		</ul>
		<!-- cd-signin-modal__switcher js-signin-modal-switcher js-signin-modal-trigger -->

		<div class="cd-signin-modal__block js-signin-modal-block"
			data-type="login">
			<!-- 로그인폼 -->
			<form class="cd-signin-modal__form" id="loginForm"
				action="${pageContext.request.contextPath}/dispatcher" method="post">
				<input type="hidden" name="command" value="Login">
				<p class="cd-signin-modal__fieldset">
					<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace"	for="signin-email">이메일</label>
					<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signin-email" name="id" type="email" placeholder="이메일" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
				</p>

				<p class="cd-signin-modal__fieldset">
					<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signin-password">비밀번호</label>
					<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signin-password" name="password" type="password" placeholder="비밀번호" required="required">
				</p>

				<p class="cd-signin-modal__fieldset">
					<input type="checkbox" id="remember-me" checked class="cd-signin-modal__input ">
					<label for="remember-me">아이디	기억하기</label>
				</p>

				<p class="cd-signin-modal__fieldset">
					<button 	class="cd-signin-modal__input cd-signin-modal__input--full-width" type="submit">로그인</button>
				</p>
			</form>
			<!-- cd-signin-modal__form -->

			<p class="cd-signin-modal__bottom-message js-signin-modal-trigger">
				<a href="#0" data-signin="reset">비밀번호를 잊어버리셨나요?</a>
			</p>
		</div>
		<!-- cd-signin-modal__block js-signin-modal-block -->

		<div class="cd-signin-modal__block js-signin-modal-block"
			data-type="signup">
			<!-- 회원가입폼 -->
			<form id="register" action="dispatcher" class="cd-signin-modal__form">
				<input type="hidden" name="command" value="CreateUser">
				<!-- 이메일 -->
				<span id="checkId"></span>
				<div>
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace"	for="signup-email">이메일</label>
						<input name="userId" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-email" type="email" placeholder="이메일" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
				</div>
				<!-- 비밀번호 -->
				<p class="cd-signin-modal__fieldset">
					<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signup-password">비밀번호</label>
					<input name="userPassword" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-password" type="password" placeholder="비밀번호"	required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
				</p>

				<!-- 비밀번호 확인 -->
				<span id="checkPass"></span>
				<div>
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signup-password">비밀번호확인</label>
						<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-password2" type="password" placeholder="비밀번호확인" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
				</div>

				<!-- 닉네임 -->
				<p class="cd-signin-modal__fieldset">
					<label class="cd-signin-modal__label cd-signin-modal__label--username cd-signin-modal__label--image-replace" for="signup-username">닉네임</label>
					<input name="userNick" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-username" type="text" placeholder="닉네임" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
				</p>

				<!-- 약관 -->
				<p class="cd-signin-modal__fieldset">
					<input type="checkbox" id="accept-terms" class="cd-signin-modal__input">
					<label for="accept-terms">약관에 동의합니다<button type="button" class="btn btn-link" id="termBtn"><strong>약관보기</strong></button></label>
					<c:import url="import/term.jsp" />
				</p>

				<!-- 회원가입 폼클릭 버튼 -->
				<p class="cd-signin-modal__fieldset">
					<button class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding" type="submit">회원가입</button>
				</p>
			</form>
			<!-- cd-signin-modal__form -->
		</div>
		<!-- cd-signin-modal__block js-signin-modal-block -->


		<div class="cd-signin-modal__block js-signin-modal-block"
			data-type="reset">
			<p class="cd-signin-modal__message">비밀번호를 잊어버리셨나요? 이메일주소를 입력해주세요.</p>
			<p class="cd-signin-modal__message">이메일에 임시비밀번호를 발송해드리겠습니다.</p>

			<!-- 비밀번호찾기 폼 -->
			<form class="cd-signin-modal__form" id="tempPasswordForm"
				onsubmit="return false;">
				<p class="cd-signin-modal__fieldset">
					<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace" for="reset-email">이메일</label>
					<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="tempEmail" type="email" placeholder="이메일" required="required">
				</p>

				<p class="cd-signin-modal__fieldset">
					<button class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding" type="submit" id="tempPasswordSend">비밀번호발송</button>
				</p>
			</form>
			<!-- cd-signin-modal__form -->

			<p class="cd-signin-modal__bottom-message js-signin-modal-trigger">
				<a href="#0" data-signin="login">로그인 화면으로</a>
			</p>
		</div>
		<!-- cd-signin-modal__block -->
		<a href="#0" class="cd-signin-modal__close js-close">닫기</a>
	</div>
	<!-- cd-signin-modal__container -->
</div>
<!-- cd-signin-modal -->

<!-- loginModal -->
<script src="assets/js/placeholders.min.js"></script>
<script src="assets/js/main.js"></script>
