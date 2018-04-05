<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <embed src="import/나미야잡화점의기적.mp3" autostart="true" loop="true" width="280" 
		height="45" volume="100"> -->
<audio id="namiyaAudio" loop autoplay="autoplay" hidden="true" preload="none" >
	<!-- <source src="import/나미야 나나나.mp3" type="audio/mpeg"> -->
	<source src="import/나미야잡화점의기적.mp3" type="audio/mpeg">
</audio>
<script>
$(document).ready(function() {
	// 오디오 볼륨
	var vol= document.getElementById("namiyaAudio");
	vol.volume=1.0;
	
	// 애니메이션 추가
	$("#home, #mypage, #loginModal, #joinModal, #logoutModal, #adminModal, #intro").hover(function() {
		$(this).prop("class","animated bounceIn");
	}, function() {
		$(this).prop("class","");
	})
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
   
      // updateUser
      $("#updateForm").submit(function() {
			var flag = false;
			if($("#nick").val().length == 0){ 
				alertModal("닉네임을 입력해주세요.")
			} else if($("#password1").val() != $("#password2").val()){
				alertModal("비밀번호가 일치하지 않습니다.")
			} else if($("#password1").val().length == 0){
				alertModal("비밀번호를 입력해주세요")
			} else {
				flag = true;
			}
			return flag;
		})
		
		$("#delBtn").click(function() {
			/* location.href = "${pageContext.request.contextPath}/dispatcher?command=DeleteUser&id=${userVO.id }"; */
			BootstrapDialog.show({
				type : "type-danger",
				title : "<i class='fas fa-exclamation-circle'></i> 알림",
				message : "정말로 회원탈퇴 하시겠습니까?",
				closable : false,
				onhidden : function(dialogRef) {
					location.href = "${pageContext.request.contextPath}/dispatcher?command=DeleteUser";
				},
				buttons : [ {
					label : "확인",
					cssClass : "btn-danger",
					hotkey : 13,
					action : function(cancel) {
						cancel.close();
					}
				},{
					label : "취소",
					hotkey : 27,
					action : function(cancel) {
						location.href = "${pageContext.request.contextPath}/index.jsp";
						cancel.close();
					}
				} ]
			}); // BootstrapDialog.show
		}); // click;
		
	
	function alertModal(msg) {
		BootstrapDialog .show({
			type : "type-danger",
			title : "<i class='fas fa-exclamation-circle'></i> 알림",
			message : msg,
			closable : false,
			buttons : [ {
				label : "확인",
				hotkey : 13,
				action : function(cancel) {
					cancel.close();
				}
			} ]
		});
	}
      
      
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
			}else if($("#signup-username").val().toUpperCase().startsWith("NM",0)){
				failMessage("닉네임 앞에는 GM을 붙일 수 없습니다!!","#signup-username");
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

		
		
		//게시글목록
		var category="제목";//검색 카테고리 기본 설정은 "제목"
		$("#findMenu li").click(function() { //검색 카테고리 설정
			 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
			 category = $(this).text(); 
			});
		$("#findBtn").click(function(){ //돋보기 아이콘 눌렀을 때 이동!
			location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
		});
		
		//게시글 검색
		var category="제목";//검색 카테고리 기본 설정은 "제목"
		$("#findMenu li").click(function() { //검색 카테고리 설정
			 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
			 category = $(this).text(); 
			});
		$("#findBtn").click(function(){ //돋보기 아이콘 눌렀을 때 이동!
			location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
		});
		
		
		// readPostInfo
		$("#replyViewForm").hide(); // 답글달기뷰 숨기기
		$("#replyWriteForm").hide(); // 답글쓰기뷰 숨기기 
		$("#updateReplyForm").hide() // 답글수정뷰 숨기기
		
		$("#replyViewBtn").click(function() { // 답글보기버튼을 클릭할때
			$("#replyViewBtn").hide(); // 답글보기버튼 숨기기
			$("#replyViewForm").show(); // 답글보기뷰 보여주기
			$("#replyViewForm").addClass("animated pulse"); // 답글달기뷰 보여주면서 애니메이션
		});
		
		$("#replyWriteBtn").click(function() { // 답글쓰기버튼 클릭할 때
			$("#replyWriteBtn").hide(); // 답글쓰기버튼 숨기기
			$("#replyWriteForm").show(); // 답글쓰기뷰 보여주기
			$("#replyWriteForm").addClass("animated fadeInUp"); // 답글쓰기뷰 보여주면서 애니메이션
		});
		
		$("#updateReplyBtn").click(function() { // 답글수정 버튼 클릭할 때 
			$("#replyViewForm").hide(); // 답글보기뷰 숨기기
			$("#updateReplyForm").show(); // 답글수정뷰 보여주기
			$("#updateReplyForm").addClass("animated fadeIn"); // 답글수정뷰 보여주면서 애니메이션
		});
		
		$("#btnReplyCancel").click(function() { // 답글수정취소 버튼 클릭할 때
			$("#replyViewForm").show(); // 답글보기뷰 보여주기
			$("#updateReplyForm").hide(); // 답글수정뷰 숨기기
		});
		
		$("#update-cancel").click(function() {
			if(flag=='view'){//flag가 view일 때 수정/수정취소 버튼을 누르면 수정폼으로 전환
				$("#togglebarName").text("답글 수정");
				$("#update-cancel").text("수정 취소");
				$("#delete-save").val("저장");
				$("#replyView").hide();
				$("#updateView").show();
				flag='update';
			}else{//flag가 update일 때 수정/수정취소 버튼을 누르면 답글뷰(삭제폼)으로 전환
				$("#togglebarName").text("답글 보기");
				$("#update-cancel").text("수정");
				$("#delete-save").val("삭제");
				$("#replyView").show();
				$("#updateView").hide();
				flag='view';
			}
		});
		
		$("#deleteConfirm").click(function() {
			var url = "${pageContext.request.contextPath}/dispatcher?command=DeletePost&pNo=${requestScope.postVO.pNo}";
			confirmModal("게시글을 삭제하시겠습니까?",url,"danger")
		});
		
		$("#updateConfirm").click(function() {
			var url = "${pageContext.request.contextPath}/dispatcher?command=UpdatePostView&pNo=${requestScope.postVO.pNo}";
			confirmModal("게시글을 수정하시겠습니까?",url,"success")
		});
		
		function confirmModal(msg,url,css) {
			BootstrapDialog.confirm({
				title : "<i class='fas fa-check-circle'></i> 알림",
	            message: msg,
	            type : "type-"+css,
	            btnCancelLabel: '취소', 
	            btnOKLabel: '확인', 
	            btnOKClass: 'btn-'+css,
	            callback: function(result) {
	                if(result) {
	                    location.href = url;
	                }else {
	                	
	                }
	            } //callback
	        }); //BootstrapDialog.confirm
		} // confirmModal
		
		
		// readMyPost
		var category="제목";//검색 카테고리 기본 설정은 "제목"
		$("#findMenu li").click(function() { //검색 카테고리 설정
			 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
			 category = $(this).text(); 
			});
		$("#findBtn").click(function(){ //돋보기 아이콘 눌렀을 때 이동!
			location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
		});
		
		
		
		
		
		// 비공개 공개
		$(".js-switch").change(function(){
			//checked 되어 있을 때 p_lock 값을 "y"로
			if($(".js-switch").prop("checked")){
				$("#p_lock").val("y")
			}else{ 
				//checked 안 되어있을 때 p_lock 값을 "n"으로
				$("#p_lock").val("n")
			}
		});
		
	});//ready
</script>