<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>정보수정</h1>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp"	method="post">
		<table>
			<tr>
				<td>닉네임</td>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td>변경할 닉네임</td>
				<td><input type="text" name="newName"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>