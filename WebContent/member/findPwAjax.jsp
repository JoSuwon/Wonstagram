<%@page import="mail.MailSend"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	MemberDAO memberDAO = new MemberDAO();
	String pw = memberDAO.findPw(id, email);
	if(pw.equals("")) {
		out.print("실패");
	} else {
		MailSend ms = new MailSend();
		ms.MailSend(email, pw);
		out.print("성공");
	}
%>