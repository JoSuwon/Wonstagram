<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email_1") + "@" + request.getParameter("email_2");
	
	MemberDAO memberDAO = new MemberDAO();
	MemberBean memberBean = new MemberBean(id,pw,name,gender,email);
	
	memberDAO.modifyMember(memberBean);
	
	response.sendRedirect("/JSPProject/index.jsp");
%>