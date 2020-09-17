<%@page import="feed.FeedBean"%>
<%@page import="feed.FeedDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	
	FeedDAO feedDAO = new FeedDAO();
	FeedBean feedBean = feedDAO.getFeed(num);
	feedDAO.deleteFeed(num);
%>