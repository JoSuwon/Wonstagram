<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	
	CommentDAO commentDAO = new CommentDAO();
	commentDAO.deleteComment(num);
%>