<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	MemberDAO memberDAO = new MemberDAO();
	//loginCheck 반환값
	//0=>존재하지않는 아이디
	//1=>로그인성공
	//2=>비밀번호가 틀림
	int loginCheck = memberDAO.loginCheck(id, pw); 
	
	if(loginCheck == 1) {
		session.setAttribute("id", id);
		response.sendRedirect("/JSPProject/index.jsp");
	} else if(loginCheck == 0) {
		%>
		<script>
			alert("존재하지 않는 아이디 입니다.");
			history.back();
		</script>
		<%
	} else if(loginCheck == 2) {
		%>
		<script>
			alert("비밀번호가 틀립니다.");
			history.back();
		</script>
		<%
	}
%>
