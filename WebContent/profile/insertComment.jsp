<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String content = request.getParameter("comment");
	String feedNum = request.getParameter("feedNum");
	
	CommentDAO commentDAO = new CommentDAO();
	
	CommentBean commentBean = new CommentBean();
	commentBean.setId(id);
	commentBean.setContent(content);
	commentBean.setFeedNum(Integer.parseInt(feedNum));
	
	int commentNum = commentDAO.insertComment(commentBean);
	CommentBean newBean = commentDAO.getComment(commentNum);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("feedNum", newBean.getFeedNum());
	jsonObj.put("num", newBean.getNum());
	jsonObj.put("id", newBean.getId());
	jsonObj.put("content", newBean.getContent());
	jsonObj.put("date", newBean.getDate().toString().substring(0, 16));
%>
<%=jsonObj.toString()%>