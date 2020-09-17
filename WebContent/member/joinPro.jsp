<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email_1") + "@" + request.getParameter("email_2");
	
	MemberBean memberBean = new MemberBean(id, pw, name, gender, email);
	MemberDAO memberDAO = new MemberDAO();
	memberDAO.insertMember(memberBean);
%>


<script>
	alert("회원가입 되었습니다!!");
	location.href = "/JSPProject/member/login.jsp";
</script>