<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>
</head>
<body>
	<my:navBar current="memberList" />
	<c:if test="${not empty message }">
		<div class="alert alert-primary">
			${message }
		</div>
	</c:if>
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>회원목록</h1>
				<table class="table">
					<thead>
						<tr>
							<th>회원 id</th>
							<th>회원 pw</th>
							<th>회원 email</th>
							<th>회원 nickName</th>
							<th>회원등록 시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberList }" var="member">
							<tr>
								<td>
									<c:url value="/member/get" var="getMemberUrl">
										<c:param name="id" value="${member.id }"></c:param>
									</c:url>
									<a href="${getMemberUrl }">
										${member.id }
									</a>
								</td>
								<td>${member.password }</td>
								<td>${member.email }</td>
								<td>${member.nickName }</td>
								<td>${member.inserted }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>