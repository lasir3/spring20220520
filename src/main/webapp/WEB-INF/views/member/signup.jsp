<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>

<script>
	$(document).ready(function() {
		// 중복 암호 확인 변수
		let idOk = false;
		let pwOk = false;
		let emailOk = false;
		let nickNameOk = false;
		
		$("#checkIdButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					id : $("#form1").find("[name=id]").val()
			};
			
			idOk = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#idMessage1").text("사용 가능한 아이디 입니다.");
						idOk = true;
						break;
					case "notOk" :
						$("#idMessage1").text("사용 불가능한 아이디 입니다.");
						break;
					}
				},
				error : function() {
					$("idMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function() {
					$("#checkIdButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		$("#checkEmailButton1").click(function(e){
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					email : $("#form1").find("[name=email]").val()
			};
			
			emailOk = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#emailMessage1").text("이메일 사용 가능합니다.");
						emailOk = true;
						break;
					case "notOk" :
						$("#emailMessage1").text("이메일 사용 불가능합니다.");
					}
				},
				error : function() {
					$("#emailMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					console.log("이메일 중복확인 완료");
					$("#checkEmailButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		$("#checkNickNameButton1").click(function(e) {
			e.preventDefault();
			$(this).attr("disabled", "");
			
			const data = {
					nickName : $("#form1").find("[name=nickName]").val()	
			};
			
			nickNameOk = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#nickNameMessage1").text("닉네임 사용 가능합니다.");
						nickNameOk = true;
						break;
					case "notOk" :
						$("#nickNameMessage1").text("닉네임 사용 불가능합니다.");
					}
				},
				error : function() {
					$("#nickNameMessage1").text("중복 확인 중 오류발생, 다시 시도해 주세요");
				},
				complete : function() {
					console.log("닉네임 중복확인 완료");
					$("#checkNickNameButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		// 패스워드 오타 확인
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			pwOk = false;
			if(pw1 === pw2) {
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				pwOk = true;				
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");			
			}
			enableSubmit();
		});
		
		// 회원가입 submit 버튼 활성화/비활성화 함수
		const enableSubmit = function() {
			if (idOk && pwOk && emailOk && nickNameOk) {
				$("#submitButton1").removeAttr("disabled");
			} else {
				$("#submitButton1").attr("disabled", "");
			}
		}
	});
</script>
</head>
<body>

<my:navBar current="signup"></my:navBar>

<form id="form1" action="${appRoot}/member/signup" method="post">
	아이디 : <input type="text" name="id" /> 
	<button id="checkIdButton1" type="button">아이디 중복확인</button> <!-- type="button"을 통해 submit button 방지 -->
	<p id="idMessage1"></p>	<br />
	
	패스워드 : <input id="passwordInput1" type="text" name="password" /> <br />
	패스워드확인 : <input id="passwordInput2" type="text" name="passwordConfirm" /> <br />
	<p id="passwordMessage1"></p> <br />
	
	이메일 : <input type="email" name="email" />
	<button id="checkEmailButton1" type="button">이메일 중복확인</button> <!-- type="button"을 통해 submit button 방지 -->
	<p id="emailMessage1"></p> <br />
	
	닉네임 : <input type="text" name="nickName"/> 
	<button id="checkNickNameButton1" type="button">닉네임 중복확인</button>
	<p id="nickNameMessage1"></p> <br />
	
	<button id="submitButton1" disabled>회원가입</button>
</form>

</body>
</html>