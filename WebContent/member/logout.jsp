<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	session.removeAttribute("id");
	response.sendRedirect("/JSPProject/member/login.jsp");
%>