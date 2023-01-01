<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// session 유효성 검증 코드
	if(session.getAttribute("loginEmp")!=null){
		response.sendRedirect(request.getContextPath()+"/empList.jsp");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			.b1{
				position: absolute;
				top: 100px;
				left: 40%;
				width: 20%;
				box-shadow: inset 0 0 10px skyblue, 0 0 10px black;
			}
			.b2 {
				float: right;
			}
		</style>
	</head>
<body>
	<div class="container b1">
		<h1 class="text-center p-3">로그인</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp">
			<table class="table">
				<tr>
					<td class="text-center">empNo</td>
					<td><input type="text" name="empNo"></td>
				</tr>
				<tr>
					<td class="text-center">firstName</td>
					<td><input type="text" name="firstName"></td>
				</tr>
				<tr>
					<td class="text-center">lastName</td>
					<td><input type="text" name="lastName"></td>
				</tr>
			</table>
			<div class="p-3 b2">
				<button type="submit" class="btn btn-success">로그인</button>
			</div>
		</form>
	</div>
</body>
</html>