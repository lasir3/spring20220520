<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script>
		$(document).ready(function() {
			$("#button1").click(function() {
				$.ajax({url : "/spr2/ex03/sub03"});
			});

			$("#button2").click(function() {
				$.ajax({url : "/spr2/ex03/sub04"});
			});
			
			$("#button3").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub05", 
					type : "get"
				});<%-- 요청 타입을 바꿀 수 있다. --%>
			});
			
			$("#button4").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub06", 
					type : "post"
				});<%-- 요청 타입을 바꿀 수 있다. --%>
			});
			
			$("#button7").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub09",
					type : "get", // type의 기본값은 get이므로 생략가능
					data : {
						title : "epl",
						writer : "son"
					}
				});
			})
			
			$("#button8").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub10",
					type : "post", // type의 기본값은 get이므로 생략가능
					data : {
						name : "son",
						address : "tottenham"
					}
				});
			})
			
			$("#button9").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub11", 
					type : "post",
					data : {
						title : "득점왕 되기",
						writer : "son"
					}
				});
			});
			
			$("#button10").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub10", 
					type : "post",
					data : "name=donald&address=newyork"
				});
			});
			
			$("#button11").click(function() {
				$.ajax({
					url : "/spr2/ex03/sub11", 
					type : "post",
					data : "title=park&writer=seoul"
				});
			});
			
			$("#button12").click(function(e) {
				e.preventDefault();
				
				const dataString = $("#form1").serialize();
				
				$.ajax({
					url : "/spr2/ex03/sub10",
					type : "post",
					data : dataString
				});
			});
			
			$("#button13").click(function(e) {
				e.preventDefault();
				
				const dataString = $("#form2").serialize();
				
				$.ajax({
					url : "/spr2/ex03/sub11",
					type : "post",
					data : dataString
				});
			});
		});
	</script>

<title>Insert title here</title>
</head>
<body>
	<button id="button1">ajax 요청 보내기</button>
	
	<%-- 이 버튼을 클릭하면 /spr2/ex03/sub04로 ajax 요청 보내기 --%>
	<%-- 콘트롤러에도 해당경로 요청에 일하는 메소드 추가 --%>
	<button id="button2">ajax 요청 보내기2</button>
	
	<br />
	
	<%-- /spr2/ex03/sub05 get 방식 요청 보내기 --%>
	<button id="button3">get방식 요청 보내기3</button>
		
	<%-- /spr2/ex03/sub06 post 방식 요청 보내기 --%>
	<button id="button4">post방식 요청 보내기4</button>
	
	<br />
	
	<%-- /spr2/ex03/sub07 delete 방식 요청 보내기 --%>
	<button id="button5">delete 방식 요청 보내기</button>
	
	<br />
	
	<%-- /spr2/ex03/sub08 put 방식 요청 보내기 --%>
	<button id="button6">put 방식 요청 보내기</button>
	
	<hr />
	<p>서버로 데이터 보내기</p>
	
	<%-- /spr2/ex03/sub09 get방식으로 데이터 보내기 --%>
	<button id="button7">get방식으로 데이터 보내기</button>
	
	<br />
	
	<%-- /spr2/ex03/sub10 post방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 name, address --%>
	<button id="button8">post방식으로 데이터 보내기</button>
	
	<br />
	
	<%-- /spr2/ex03/sub11 post방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 title, writer  --%>
	<button id="button9">post방식으로 데이터 보내기2</button>
	
	<%-- /spr2/ex03/sub10 post방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 name, address  --%>
	<button id="button10">post방식으로 데이터 보내기2 (encoded String)</button>
	
	<%-- /spr2/ex03/sub11 post방식으로 데이터 보내기 --%>
	<%-- 전송될 데이터는 title, writer  --%>
	<button id="button11">post방식으로 데이터 보내기2 (encoded String)</button>
	
	<hr />
	
	<p>폼 데이터 보내기</p>
	<form action="/spr2/ex03/sub10" id="form1" method="post">
		name : <input type="text" name="name" /> <br />
		address : <input type="text" name="address" /> <br />
		<button id="button12">ajax 데이터 전송</button>
	</form>
	<hr />
	<%-- #button13이 클릭되면 --%>
	<%-- /spr2/ex03/sub11로 post 방식 ajax 요청 전송 (title, writer 전송) --%>
	<form action="/spr2/ex03/sub11" id="form2" method="post">
		title : <input type="text" name="title" /> <br />
		writer : <input type="text" name="writer" /> <br />
		<button id="button13">ajax 데이터 전송2</button>
	</form>
	
</body>
</html>