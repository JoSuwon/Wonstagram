<%@page import="ccboard.CCBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="ccboard.CCBoardBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String secret = request.getParameter("secret");
	if(secret == null) {
		secret = "off";
	}
	
	
	CCBoardBean ccBoardBean = new CCBoardBean();
	
	ccBoardBean.setId(id);
	ccBoardBean.setPw(pw);
	ccBoardBean.setSubject(subject);
	ccBoardBean.setContent(content);
	if(secret.equals("on")) {
		ccBoardBean.setSecret(1);
	}
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	ccBoardDAO.insertBoard(ccBoardBean);
	
	int boardCount = ccBoardDAO.getMaxNum();	
	response.sendRedirect("/JSPProject/customercenter/cccontent.jsp?num=" + boardCount);
%>
