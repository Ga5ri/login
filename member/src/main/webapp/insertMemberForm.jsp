<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			.b1 {
				position: absolute;
				top: 100px;
				left: 40%;
				width: 20%;
				box-shadow: inset 0 0 10px skyblue, 0 0 10px black;
			}
			.b3 {
				float: right;
			}
			input {
				width: 100%;
			}
		</style>
	</head>
	<body>
		<div class="container b1 rounded">
			<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<h1 class="text-center p-3">회원가입</h1>
				<table class="table table-borderless">
					<tr>
						<td class="text-center">아이디</td>
						<td>
							<input type="text" name="memberId" placeholder="ID를 입력하세요">
							<%
								if(msg != null){	
							%>
									<span><%=msg%></span>
							<%		
								}
							%>
						</td>
					</tr>
					<tr>
						<td class="text-center">비밀번호</td>
						<td><input type="password" name="memberPw" placeholder="Password를 입력하세요."></td>
					</tr>
					<tr>
						<td class="text-center">닉네임</td>
						<td><input type="text" name="memberName" placeholder="닉네임을 입력하세요"></td>
					</tr>
				</table>
				<div class="btn p-3 b3">
					<button type="submit">회원가입</button>
				</div>
			</form>
		</div>
	</body>
</html>