<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <embed src="import/나미야잡화점의기적.mp3" autostart="true" loop="true" width="280" 
		height="45" volume="100"> -->
<audio id="namiyaAudio" loop autoplay="autoplay" hidden="true" preload="none" >
	<source src="import/나미야 나나나.mp3" type="audio/mpeg">
	<!-- <source src="import/나미야잡화점의기적.mp3" type="audio/mpeg"> -->
</audio>
<script>
$(document).ready(function() {
	// 오디오 페이지 전환시 연결 시켜주는 부분--------------------------------------------------------
	function setCookie(c_name,value,exdays)
	{
	    var exdate=new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
	    document.cookie=c_name + "=" + c_value;
	}

	function getCookie(c_name)
	{
	    var i,x,y,ARRcookies=document.cookie.split(";");
	    for (i=0;i<ARRcookies.length;i++)
	    {
	      x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
	      y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
	      x=x.replace(/^\s+|\s+$/g,"");
	      if (x==c_name)
	        {
	        return unescape(y);
	        }
	      }
	}

	var song = document.getElementsByTagName('audio')[0];
	var played = false;
	var tillPlayed = getCookie('timePlayed');
	function update()
	{
	    if(!played){
	        if(tillPlayed){
	        song.currentTime = tillPlayed;
	        song.play();
	        played = true;
	        }
	        else {
	                song.play();
	                played = true;
	        }
	    }

	    else {
	    setCookie('timePlayed', song.currentTime);
	    }
	}
	setInterval(update,1000);
	// 오디오 페이지 전환시 연결 시켜주는 부분--------------------------------------------------------
	
	
	
	// 오디오 볼륨----------------------------------------------------------------------------------
	var vol= document.getElementById("namiyaAudio");
	vol.volume=1.0;
	// 오디오 볼륨----------------------------------------------------------------------------------
	
	
	
	// 광고 ------------------------------------------------------------------------------------------------------------------------------------------------------------
	var num = randomNum(6);
	$("#adv img").prop("src","adv/"+num+".jpg");
	// 광고이미지 선택시 url이동
	switch (num) {
	case 1: // 선생님
		$("#adv").prop("href","http://edu.kosta.or.kr/index")
		break;
	case 2: // 김유란
		$("#adv").prop("href","http://192.168.0.184:8888/BBacksToga")
		break;
	case 3: // 류완선
		$("#adv").prop("href","http://192.168.0.178:8888/KCver01")
		break;
	case 4: // 용다은
		$("#adv").prop("href","http://192.168.0.114:8888/albatross")
		break;
	case 5: // 은성민
		$("#adv").prop("href","http://192.168.0.135:8888/Hue")
		break;
	case 6: // 이상욱
		break;
	}
	$("#adv").click(function() {
		if(num == 6) {
			urlModal()
		}
	})
	
	function urlModal() {
		BootstrapDialog.show({
			type : "type-primary",
			title : "알림",
		    message: '<p class="lead text-center">안녕?</p> \n <input type="text" class="form-control">',
		    onhide: function(dialogRef){
		        var zzz = dialogRef.getModalBody().find('input').val();
		        if($.trim(zzz.toLowerCase()) !== '1조최고') {
		        	BootstrapDialog.show({
		    			type : "type-danger",
		    			title : "<i class='fas fa-exclamation-circle'></i> 알림",
		    			message : "1조최고 라고 입력해주세요^^",
		    			closable : false,
		    			buttons : [ {
		    				label : "확인",
		    				hotkey : 13,
		    				action : function(cancel) {
		    					cancel.close();
		    				}
		    			} ]
		    		});
		            return false;
		        } else {
		        	location.href = "http://192.168.0.121:8888/semi-namiya";
		        }
		    },
		    buttons: [{
		        label: '확인',
		        hotkey : 13,
		        action: function(dialogRef) {
		            dialogRef.close();
		        }
		    }]
		});
	}
	
	// 난수만들기
	function randomNum(num) {
		var randomNum = Math.ceil(Math.random() * num);
		return randomNum;
	}
	// 광고 끝 ------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	// 스크롤 ------------------------------------------------------------------------------------------------------------------------------------------------------------
	var floatPosition = parseInt($("#scrolladv").css('top'));
	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
 		var newPosition = scrollTop;
		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */
		$("#scrolladv").stop().animate({
			"top" : newPosition
		}, 500);
	}).scroll();
	// 스크롤 끝--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// 메인 애니메이션 --------------------------------------------------------------------------------------------------------------------
	// 애니메이션 추가
	$("#home, #mypage, #loginModal, #joinModal, #logoutModal, #adminModal, #intro").hover(function() {
		$(this).prop("class","animated bounceIn");
	}, function() {
		$(this).prop("class","");
	});
	// 메인 애니메이션------------------------------------------------------------------------------------------------------------------------
	
	
	// 아이디기억하기 쿠키 --------------------------------------------------------------------------------------------------------------
	$("#loginForm").submit(function() {
		$.ajax({
			type:"post",
			dataType:"json",
			url:"${pageContext.request.contextPath}/dispatcher",
			data:$("#loginForm").serialize(),
			success:function(data){
				if(data.flag=="fail"){//fail일 경우 ajax로 바로 처리. 아이디, 패스워드 입력폼에 셀렉터 id값 추가
					BootstrapDialog .show({
						type : "type-danger",
						title : "<i class='fas fa-exclamation-circle'></i> 알림",
						message : "로그인 실패! 아이디와 패스워드를 확인하세요.",
						closable : false,
						onhidden: function(dialogRef){
							$("#signin-email").focus();
							$("#signin-password").val("");
			            },
						buttons : [ {
							label : "확인",
							hotkey : 13,
							action : function(cancel) {
								cancel.close();
							}
						} ]
					});
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
	// 아이디기억하기 쿠키 끝 --------------------------------------------------------------------------------------------------------------
		
		
	// 개인정보수정 ---------------------------------------------------------------------------------------------------
	   $("#updateForm").submit(function() {
	      var userNick="${sessionScope.userVO.nickName}";
	      var flag = false;
	      if($("#nick").val().length == 0){ 
	         alertModal("닉네임을 입력해주세요.")
	      } else if($("#password1").val() != $("#password2").val()){
	         alertModal("비밀번호가 일치하지 않습니다.")
	      } else if($("#password1").val().length == 0){
	         alertModal("비밀번호를 입력해주세요")
	      } else if($("#nick").val().toUpperCase().startsWith("NM",0)){
	         alertModal("닉네임에는 NM이 들어갈 수 없습니다.")
	      }else if(userNick!=$("#nick").val()){
	         if( !checkNick($("#nick").val()) ){
	            alertModal("닉네임이 중복됩니다.")
	         }
	      }else {
	         flag = true;
	      }
	      return flag;
	   });
	   
	   function checkNick(nickName){
	         $.ajax({
	            type:"post",
	            dataType:"json",
	            url:"dispatcher",
	            data:"command=CheckNickname&nickname="+nickName,
	            success:function(data){
	               if(data.nick=="true"){
	                  //$("#checkId").html("사용가능!").css("color","blue");
	                  return true;
	               } else {
	                  //$("#checkId").html("사용불가!").css("color","red");
	                  return false;
	               }
	            }
	         })//ajax
	   }
		
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
	// 개인정보수정 관련끝 --------------------------------------------------------------------------------------------------------------------



	// 회원가입관련 --------------------------------------------------------------------------------------------------
	//var idTag = $('#idTool[data-toggle="tooltip"]');
	//id 중복체크
	$("#signup-email").keyup(function(){
		var inputId=$(this).val();
		 var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
		//console.log(inputId);
		$.ajax({
			type:"post",
			dataType:"json",
			url:"dispatcher",
			data:"command=CheckId&id="+inputId,
			success:function(data){
				if(data.flag=="true"){
					if( inputId.match(regExp) ){
						$("#checkId").text("사용가능!").prop("class","label label-info pull-left")
					}else {
						$("#checkId").text("");
					}
				} else {
					$("#checkId").text("사용불가!").prop("class","label label-danger pull-left")
				}
			}
		})//ajax
	});//keyup
	
	//비밀번호 일치 체크
	$("#signup-password2").keyup(function(){
		var checkPass=$(this).val();
		if($("#signup-password").val()==checkPass){
			$("#checkPass").text("비밀번호 일치!").prop("class","label label-info pull-left")
		}else{
			$("#checkPass").text("비밀번호가 일치하지 않습니다!").prop("class","label label-danger pull-left");
		}
	});//keyup
	
	//회원가입 닉네임 중복 체크
	$("#signup-username").keyup(function(){ 
		var userNick=$(this).val();
		$.ajax({
			type:"post",
			dataType:"json",
			url:"dispatcher",
			data:"command=CheckNickname&nickname="+userNick,
			success:function(data){
				if(data.nick=="true"){
					if(userNick.length != 0) {
						$("#checkNick").text("사용가능!").prop("class","label label-info pull-left");
					} else {
						$("#checkNick").text("");
					}
				}else {
					$("#checkNick").text("사용불가!").prop("class","label label-danger pull-left");
				}
			}
		})//ajax
	})
	
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
      }else if($("#checkNick").text()!="사용가능!"){
         failMessage("닉네임이 중복됩니다.","#signup-username");
         return false;
      }else if($("#signup-username").val().toUpperCase().startsWith("NM",0)){
         failMessage("닉네임 앞에는 GM을 붙일 수 없습니다!!","#signup-username");
         return false;
      }else{
         return true;
      }
			
		// 회원가입 실패 모달
	function failMessage(msg,form) {
		BootstrapDialog.show({
			type : "type-danger",
			title : "<i class='fas fa-exclamation-circle'></i> 알림",
			message : msg,
			closable : false,
			onhidden : function(dialogRef) {
				if(form=="#signup-email"){
					$(form).val("");
					$("#checkId").text("아이디를 작성하세요!");
				}
					$(form).focus();
				}, // onhidden
				buttons : [ {
					label : "확인",
					hotkey : 13,
					action : function(cancel) {
					cancel.close();
					}
				} ] // buttons
			}); // BootstrapDialog.show
		} // failMessage
	})//click
	// 회원가입관련끝 -------------------------------------------------------------------------------------------------------------
		
		
		
	// 임시비밀번호 ---------------------------------------------------------------------------------------------
		
	// 비밀번호찾기버튼 클릭시
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
	// 임시비밀번호 끝 --------------------------------------------------------------------------------------------------
	
	// 약관 ----------------------------------------- --------------------------------------------------------------------------------
	// 약관체크박스 클릭시
	$("#accept-terms").click(function() {
		if($(this).prop("checked")) {
			terms();
		} // checked
	}); // accept-terms
	
	// 약관보기 버튼 클릭시
	$("#termBtn").click(function() {
		terms();
	}); // termBtn click()
	
	// 약관 모달
	function terms() {
		var term = $("#term").html();
		BootstrapDialog.show({
			size : BootstrapDialog.SIZE_WIDE,
			type : "type-primary",
			title : "<i class='fas fa-info-circle'></i> 약관",
			message : "<p style='font-size: 20px;'>"+term+"</p>",
			closable : false,
			onhidden : function(dialogRef) {
				$("#accept-terms").prop("checked", true);
			},
			buttons : [ {
				label : "확인",
				action : function(cancel) {
					cancel.close();
				}
			} ] // buttons
		}); // BootstrapDialog.show
	} // terms()
	// 약관끝 -------------------------------------------------------------------------------------------------
		
		
	// 게시글 게시글보기,검색,삭제,수정  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	var category="제목";//검색 카테고리 기본 설정은 "제목"
	$("#findMenu li").click(function() { //검색 카테고리 설정
		$("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
		category = $(this).text(); 
	});
	
	//돋보기 아이콘 눌렀을 때 이동!
	$("#findBtn").click(function(){ 
		location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
	});

	// 게시글 쓰기에서 비공개 공개
	$(".js-switch").change(function(){
		//checked 되어 있을 때 p_lock 값을 "y"로
		if($(".js-switch").prop("checked")){
			$("#p_lock").val("y")
		}else{ 
			//checked 안 되어있을 때 p_lock 값을 "n"으로
			$("#p_lock").val("n")
		}
	}); // $(.js-switch").change
		
	//게시글 검색
	var category="제목";//검색 카테고리 기본 설정은 "제목"
	$("#findMenu li").click(function() { //검색 카테고리 설정
		 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
		 category = $(this).text(); 
		});
	
	//돋보기 아이콘 눌렀을 때 이동!
	$("#findBtn").click(function(){ 
		location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
	});
	
	// 게시글 삭제버튼 클릭시
	$("#deleteConfirm").click(function() {
		var url = "${pageContext.request.contextPath}/dispatcher?command=DeletePost&pNo=${requestScope.postVO.pNo}";
		confirmModal("게시글을 삭제하시겠습니까?",url,"danger")
	});
	
	// 게시글 수정버튼 클릭시
	$("#updateConfirm").click(function() {
		var url = "${pageContext.request.contextPath}/dispatcher?command=UpdatePostView&pNo=${requestScope.postVO.pNo}";
		confirmModal("게시글을 수정하시겠습니까?",url,"success")
	});
		
	// 게시글 삭제,클릭 모달
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
	// 게시글보기,검색,삭제,수정 끝 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
	
	// 답글관련 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	// 답글관련 끝------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// 내상담목록 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	var category="제목";//검색 카테고리 기본 설정은 "제목"
	$("#findMenu li").click(function() { //검색 카테고리 설정
		 $("#menuBtn").html($(this).text()+ ' <span class="caret"></span>'); 
		 category = $(this).text(); 
		});
	$("#findBtn").click(function(){ //돋보기 아이콘 눌렀을 때 이동!
		location.href="${pageContext.request.contextPath}/dispatcher?command=Search&category="+category+"&keyword="+$("#keyword").val();
	});
	// 내상담목록 끝