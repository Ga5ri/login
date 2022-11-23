<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 안전장치
	if(request.getParameter("memberId")==null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberName")==null || request.getParameter("memberName").equals("")
		|| request.getParameter("memberPw")==null || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp");
		return;
	}
	// Model
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.insert(paramMember);
	System.out.println(memberDao.login(paramMember)+"<-resultMember");
	
	String redirectUrl = "/loginForm.jsp";

	// View
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>