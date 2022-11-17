<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%
	// 1
	if(session.getAttribute("loginEmp") == null) {
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Employee loginEmp = (Employee)session.getAttribute("loginEmp");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
				float : left;
				margin : 10px;
			}
			.b3 {
				float : right;
				margin : 10px;
			}
			.a1 {
				text-align: center;
				margin : 10px;
			}
		</style>
	</head>
	<body>
		<div class="container b1">
		<h1 class="a1">마이페이지</h1>
		<div class="a1">
			<%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.
		</div>
			<div>
				<a href="<%=request.getContextPath()%>/empList.jsp" class="btn btn-outline-primary b2">사원 정보</a>
				<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-danger b3">로그아웃</a>
			</div>
		</div>
	</body>
</html>