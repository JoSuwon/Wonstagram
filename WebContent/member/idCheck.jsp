<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	MemberDAO memberDAO = new MemberDAO();
	boolean result = memberDAO.idCheck(id);
	if(result == true) out.print("true");
	else out.print("false");
%>