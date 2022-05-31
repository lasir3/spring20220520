<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
	
<script>
	$(document).ready(function() {
		let pwCheck = false;
		let emailCheck = false;
		let nickNameCheck = false;
		
		// 기존 이메일
		const oldEmail = $("#emailValue1").val();
		// 기존 닉네임
		const oldNickName = $("#nickNameValue1").val();
		
		// 암호 일치 체크
		$("#pwInputCheck1, #pwInputCheck2").keyup(function() {
			const pw1 = $("#pwInputCheck1").val();
			const pw2 = $("#pwInputCheck2").val();
			
			if(pw1 === pw2) {
				$("#pwCheckMessage1").text("암호가 같습니다.");
				pwCheck = true;
			} else {
				$("#pwCheckMessage1").text("암호가 틀립니다.");
			}
			checkModify();
		});
		
		// 이메일 중복 체크
		// 이메일 텍스트 내용 변경시 버튼 활성화
		$("#emailValue1").keyup(function() {
			const newEmail = $("#emailValue1").val();
			
			// 기존 이메일과 같을 시 버튼 비활성화
			if (oldEmail == newEmail) {
				$("#emailCheckButton1").attr("disabled", "");		
				$("#emailMessage1").text("");
			} else {
				$("#emailCheckButton1").removeAttr("disabled");
			}
		});
		
		// 이메일 버튼 클릭시 ajax 실행
		$("#emailCheckButton1").click(function(e) {
			// 기본 이벤트 진행 중지
			e.preventDefault();
			const data = {
					email : $("#emailValue1").val()
			};
			
			emailCheck = false;
			$.ajax ({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#emailCheckMessage1").text("이메일 변경이 가능합니다.");
						emailCheck = true;
						break;
					case "notOk" :
						$("#emailCheckMessage1").text("중복된 이메일입니다.");
					}
				},
				error : function() {
					$("#emailCheckMessage1").text("이메일 중복확인 오류, 다시시도하세요.");
				},
				complete : function() {
					console.log("이메일 중복확인 완료");
					$("#emailCheckButton1").attr("disabled", "");
					checkModify();
					
				}
			}); 
		});

		// 닉네임 중복 체크
		// 닉네임 텍스트 내용 변경시 버튼 활성화
		$("#nickNameValue1").keyup(function() {
			const newNickName = $("#nickNameValue1").val();
			
			// 기존 닉네임과 같을 시 버튼 비활성화
			if (oldNickName == newNickName) {
				$("#nickNameCheckButton1").attr("disabled", "");		
				$("#nickNameCheckMessage1").text("");
			} else {
				$("#nickNameCheckButton1").removeAttr("disabled");
			}
		});
			
		// 닉네임 버튼 클릭시 ajax 실행
		$("#nickNameCheckButton1").click(function(e) {
			// 기본 이벤트 진행 중지
			e.preventDefault();
			const data = {
					nickName : $("#nickNameValue1").val() // id를 지정
			};
			
			nickNameCheck = false; // 요청전에 false 
			$.ajax ({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#nickNameCheckMessage1").text("닉네임 변경이 가능합니다.");
						nickNameCheck = true;
						break;
					case "notOk" :
						$("#nickNameCheckMessage1").text("중복된 닉네임입니다.");
					}
				},
				error : function() {
					$("#nickNameCheckMessage1").text("닉네임 중복확인 오류, 다시시도하세요.");
				},
				complete : function() {
					console.log("닉네임 중복확인 완료");
					$("#nickNameCheckButton1").attr("disabled", "");
					checkModify();
				}
			}); 
		});
		
		// 수정버튼 활성화
		const checkModify = function() {
			if (pwCheck && emailCheck && nickNameCheck) {
				$("#modifyButton1").removeAttr("disabled");
			} else {
				$("#modifyButton1").attr("disabled", "");
			}
		}
		
		// 수정 submit 버튼 ("modifyButton2") 클릭 시
		$("#modifyButton2").click(function(e) {
			e.preventDefault();
			const form2 = $("#form2");
			
			// input 값 옮기기
			form2.find("[name=password]").val($("#pwInputCheck1").val());
			form2.find("[name=email]").val($("#emailValue1").val());
			form2.find("[name=nickName]").val($("#nickNameValue1").val());
			
			form2.submit();
		});
	});
</script>
<title>Insert title here</title>
</head>

<body>
	<my:navBar current="memberInfo"></my:navBar>
	<p>${message }</p>
	<div>
		아이디 : <input type="text" value="${member.id }" readonly/> <br />
		암호 : <input id="pwInputCheck1" type="text" value="" /> <br />
		암호확인 : <input id="pwInputCheck2" type="text" value="" /> 
		<span id="pwCheckMessage1"></span> <br />
		이메일 : <input id="emailValue1" name="email" type="email" value="${member.email }" /> 
		<button disabled id="emailCheckButton1" type="button">이메일 중복확인</button> 
		<span id="emailCheckMessage1"></span> <br />
		닉네임 : <input id="nickNameValue1" name="nickName" type="text" value="${member.nickName }" /> 
		<button disabled id="nickNameCheckButton1" type="button">닉네임 중복확인</button> 
		<span id="nickNameCheckMessage1"></span> <br />
		가입일 : <input type="datetime-local" value="${member.inserted }" readonly /> <br />
	</div>

	<%-- 요구사항
	1. 이메일 input에 변경 발생 시 '이메일 중복확인버튼 활성화' 
	   -> 버튼클릭시 ajax로 요청/응답, 적절한 메시지 출력
	2. 닉네임 input에 변경 발생 시 '닉네임 중복확인버튼 활성화'
	   -> 버튼클릭시 ajax로 요청/응답, 적절한 메시지 출력
	
	3. 암호/암호확인 일치, 이메일 중복확인 완료, 닉네임 중복확인 완료시에만
	   수정버튼 활성화
	 --%>

	<div>
		<button id="modifyButton1" data-bs-toggle="modal" data-bs-target="#modal2" disabled>수정</button>
		<button data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
	</div>

	<!-- 탈퇴암호 확인 Modal -->
	<div class="modal fade" id="modal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel1">삭제 확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form1" action="${appRoot }/member/remove" method="post">
						<input type="hidden"  value="${member.id }" name="id" />
						암호 : <input type="text" name="password" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
					<button form="form1" type="submit" class="btn btn-danger">탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 수정(modify) 기존 암호 확인 Modal -->
	<div class="modal fade" id="modal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel2">수정 확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form2" action="${appRoot }/member/modify" method="post">
						<input type="hidden"  value="${member.id }" name="id" />
						<input type="hidden"  name="password"  />
						<input type="hidden"  name="email" />
						<input type="hidden"  name="nickName" />
						기존 암호 : <input type="text" name="oldPassword" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
					<button id="modifyButton2" form="form2" type="submit" class="btn btn-danger">수정</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>