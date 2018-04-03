<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
   $(document).ready(function() {
      $("#loginForm").submit(function() {
         $.ajax({
            type:"post",
            dataType:"json",
            url:"${pageContext.request.contextPath}/dispatcher",
            data:$("#loginForm").serialize(),
            success:function(data){
               if(data.flag=="fail"){//fail일 경우 ajax로 바로 처리. 아이디, 패스워드 입력폼에 셀렉터 id값 추가
                  alert("로그인 실패! 아이디와 패스워드를 확인하세요.");
                  $("#signin-email").val("").focus(); //로그인 실패 알림 후 기존입력값 지우고 email 입력폼에 포커스.
                  $("#signin-password").val("");
               }else{//로그인 성공시에는 세션값에 따라 헤더상태 메뉴가 유지되므로 여기에서 화면을 구성하는 것은 불필요.페이지 재로딩으로 처리
                  location.href="index.jsp";
               }
            }//sucess
         });//ajax
         return false;
      });//LoginForm submit
      
      //쿠키에 저장된 아이디를 가져와 입력폼에 셋팅 
      var userInputId = getCookie("userInputId");
      $("#signin-email").val(userInputId); 
      
      //체크박스 상태 변화에 따라 쿠키에 아이디를 저장 또는 삭제
      $("#remember-me").change(function(){ 
          if($("#remember-me").is(":checked")){                     
              var userInputId = $("#login-email").val();
              setCookie("userInputId", userInputId, 365);//key,value,저장기한
          }else{ 
              deleteCookie("userInputId");
          }
      });//change
        
      //체크된 상태에서 아이디를 입력하면 쿠키에 저장
      $("#signin-email").keyup(function(){ 
          if($("#remember-me").is(":checked")){ 
              var userInputId = $("#signin-email").val();
              setCookie("userInputId", userInputId, 365);
          }
      });//keyup

   });//ready
   
   
      //아이디 저장 위한 쿠키 처리 함수 정의 set/delete/getCookie
      function setCookie(cookieName, value, exdays){
          var exdate = new Date();
          exdate.setDate(exdate.getDate() + exdays);
          var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
          document.cookie = cookieName + "=" + cookieValue;
      }
       
      function deleteCookie(cookieName){
          var expireDate = new Date();
          expireDate.setDate(expireDate.getDate() - 1); //어제날짜를 쿠키 소멸날짜로 설정
          document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
      }
       
      function getCookie(cookieName) {
          cookieName = cookieName + '=';
          var cookieData = document.cookie;
          var start = cookieData.indexOf(cookieName);
          var cookieValue = '';
          if(start != -1){
              start += cookieName.length;
              var end = cookieData.indexOf(';', start);
              if(end == -1)end = cookieData.length;
              cookieValue = cookieData.substring(start, end);
          }
          return unescape(cookieValue);
      }
   
</script>
<div class="cd-signin-modal js-signin-modal"> <!-- this is the entire modal form, including the background -->
		<div class="cd-signin-modal__container"> <!-- this is the container wrapper -->
			<ul class="cd-signin-modal__switcher js-signin-modal-switcher js-signin-modal-trigger">
				<li><a href="#0" data-signin="login" data-type="login">로그인</a></li>
				<li><a href="#0" data-signin="signup" data-type="signup">회원가입</a></li>
			</ul> <!-- cd-signin-modal__switcher js-signin-modal-switcher js-signin-modal-trigger -->

			<div class="cd-signin-modal__block js-signin-modal-block" data-type="login">
				<!-- 로그인폼 -->
				<form class="cd-signin-modal__form" id="loginForm" action="${pageContext.request.contextPath}/dispatcher" method="post">
				<input type="hidden" name="command" value="Login">
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace" for="signin-email">이메일</label>
						<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signin-email" name="id" type="email" placeholder="이메일" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>

					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signin-password">비밀번호</label>
						<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signin-password" name="password" type="password"  placeholder="비밀번호" required="required">
					</p>

					<p class="cd-signin-modal__fieldset">
						<input type="checkbox" id="remember-me" checked class="cd-signin-modal__input ">
						<label for="remember-me">아이디 기억하기</label>
					</p>

					<p class="cd-signin-modal__fieldset">
						<button class="cd-signin-modal__input cd-signin-modal__input--full-width" type="submit">로그인</button>
					</p>
				</form> <!-- cd-signin-modal__form -->
				
				<p class="cd-signin-modal__bottom-message js-signin-modal-trigger"><a href="#0" data-signin="reset">비밀번호를 잊어버리셨나요?</a></p>
			</div> <!-- cd-signin-modal__block js-signin-modal-block -->

			<div class="cd-signin-modal__block js-signin-modal-block" data-type="signup">
				<!-- 회원가입폼 -->
				<form id="register" action="dispatcher" class="cd-signin-modal__form">
				<input type="hidden" name="command" value="CreateUser">
					<!-- 이메일 -->
					<span id="checkId"></span>
					<div>
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace" for="signup-email">이메일</label>
						<input name="userId" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-email" type="email" placeholder="이메일" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
					</div>
					<!-- 비밀번호 -->
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signup-password">비밀번호</label>
						<input name="userPassword" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-password" type="password"  placeholder="비밀번호" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
					
					<!-- 비밀번호 확인 -->
					<span id="checkPass"></span>
					<div>
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--password cd-signin-modal__label--image-replace" for="signup-password">비밀번호확인</label>
						<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-password2" type="password"  placeholder="비밀번호확인" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
					</div>
					
					<!-- 닉네임 -->
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--username cd-signin-modal__label--image-replace" for="signup-username">닉네임</label>
						<input name="userNick" class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="signup-username" type="text" placeholder="닉네임" required="required" onkeyup="this.value=this.value.replace(/\s/g,'')">
					</p>
					
					<!-- 약관 -->
					<p class="cd-signin-modal__fieldset">
						<input type="checkbox" id="accept-terms" class="cd-signin-modal__input ">
						<label for="accept-terms">약관에 동의합니다 <button type="button" class="btn btn-link" id="termBtn"><strong>약관보기</strong></button></label>
						<c:import url="import/term.jsp"/>
					</p>
					
					<!-- 회원가입 폼클릭 버튼 -->
					<p class="cd-signin-modal__fieldset">
						<button class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding" type="submit">회원가입</button>
					</p>
				</form> <!-- cd-signin-modal__form -->
			</div> <!-- cd-signin-modal__block js-signin-modal-block -->
			
			
			<div class="cd-signin-modal__block js-signin-modal-block" data-type="reset">
				<p class="cd-signin-modal__message">비밀번호를 잊어버리셨나요? 이메일주소를 입력해주세요.</p>
				<p class="cd-signin-modal__message">이메일에 임시비밀번호를 발송해드리겠습니다.</p>
				
				<!-- 비밀번호찾기 폼 -->
				<form class="cd-signin-modal__form" id="tempPasswordForm" onsubmit="return false;">
					<p class="cd-signin-modal__fieldset">
						<label class="cd-signin-modal__label cd-signin-modal__label--email cd-signin-modal__label--image-replace" for="reset-email">이메일</label>
						<input class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding cd-signin-modal__input--has-border" id="tempEmail" type="email" placeholder="이메일" required="required">
					</p>

					<p class="cd-signin-modal__fieldset">
						<button class="cd-signin-modal__input cd-signin-modal__input--full-width cd-signin-modal__input--has-padding" type="submit" id="tempPasswordSend">비밀번호발송</button>
					</p>
				</form> <!-- cd-signin-modal__form -->

				<p class="cd-signin-modal__bottom-message js-signin-modal-trigger"><a href="#0" data-signin="login">로그인 화면으로</a></p>
			</div> <!-- cd-signin-modal__block -->
			<a href="#0" class="cd-signin-modal__close js-close">닫기</a>
		</div> <!-- cd-signin-modal__container -->
	</div> <!-- cd-signin-modal -->
<!-- loginModal -->
<script src="assets/js/placeholders.min.js"></script>
<script src="assets/js/main.js"></script>
<!-- /loginModal -->
<script>
	$(document).ready(function(){
		//var idTag = $('#idTool[data-toggle="tooltip"]');
		//id 중복체크
		$("#signup-email").keyup(function(){
			var inputId=$(this).val();
			//console.log(inputId);
			$.ajax({
				type:"post",
				dataType:"json",
				url:"dispatcher",
				data:"command=CheckId&id="+inputId,
				success:function(data){
					if(data.flag=="true"){
						$("#checkId").html("사용가능!").css("color","blue");
					} else {
						$("#checkId").html("사용불가!").css("color","red");
					}
				}
			})//ajax
		});//keyup
		//비밀번호 일치 체크
		$("#signup-password2").keyup(function(){
			var checkPass=$(this).val();
			if($("#signup-password").val()==checkPass){
				$("#checkPass").html("비밀번호 일치!").css("color","blue");
			}else{
				$("#checkPass").html("비밀번호가 일치하지 않습니다!").css("color","red");
			}
		});//keyup
		//submit 제어
		$("#register").submit(function(){
			if($('input:checkbox[id="accept-terms"]').is(":checked")==false){
				failMessage("약관에 동의해 주세요.","#accept-terms");
				//alert("약관에 동의해 주세요.");
				//$("#accept-terms").focus();
				return false;
			}else if($("#checkId").text()!="사용가능!"){
				failMessage("중복된 아이디입니다. 아이디를 확인해 주세요.","#signup-email");
				//alert("중복된 아이디입니다. 아이디를 확인해 주세요.");
				//$("#signup-email").focus();
				return false;
			}else if($("#checkPass").text()!="비밀번호 일치!"){
				failMessage("비밀번호와 비밀번호 확인이 다릅니다. 비밀번호를 확인해 주세요.","#signup-password2");
				//alert("비밀번호와 비밀번호 확인이 다릅니다. 비밀번호를 확인해 주세요.");
				//$("#signup-password2").focus();
				return false;
			}else{
				return true;
			}
			// 빨간색 알러트
			function failMessage(msg,form) {
			     BootstrapDialog.show({
			     	type : "type-danger",
			        title : "<i class='fas fa-exclamation-circle'></i> 알림",
			        message : msg,
			        closable : false,
			        onhidden : function(dialogRef) {
			        	if(form=="#signup-email"){
			        		$(form).val("");
			        		$("#checkId").html("아이디를 작성하세요!").css("color","green");
			        		//form.val("");
			        	}
			        	$(form).focus();
	               		//form.focus();
	               },
	               buttons : [ {
	               label : "확인",
	               hotkey : 13,
	               action : function(cancel) {
	               cancel.close();
	               }
	           		} ]
				});
			}
		})//click
		
		// 임시비밀번호 발송
		$("#tempPasswordSend").click(function() {
			var email = $("#tempEmail").val(); // 발송할 이메일주소 가져오기
			var password = randomPassword(8); // 난수 비밀번호 8자리 생성
			location.href = "${pageContext.request.contextPath}/dispatcher?command=TempPassword&id="+email+"&password="+password;
		});
		// 임시비밀번호 난수 만들기
		function randomPassword(length) {
		    var chars = "abcdefghijklmnopqrstuvwxyz!@#$%^&1234567890";
		    var pass = "";
		    for (var x = 0; x < length; x++) {
		        var i = Math.floor(Math.random() * chars.length);
		        pass += chars.charAt(i);
		    }
		    return pass;
		} // randomPassword
		
		
		// 약관보기
		$("#termBtn").click(function() {
			var term = $("#term").html();
			BootstrapDialog.show({
				size : BootstrapDialog.SIZE_WIDE,
				type : "type-primary",
				title : "<i class='fas fa-info-circle'></i> 약관",
				message : "<p style='font-size: 20px;'>"+term+"</p>",
				closable : false,
				onhidden : function(dialogRef) {
					
				},
				buttons : [ {
					label : "확인",
					action : function(cancel) {
						cancel.close();
					}
				} ]
			});
		}) // 약관보기

		
		
	});//ready
</script>
