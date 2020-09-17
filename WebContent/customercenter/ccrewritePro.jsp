<%@page import="ccboard.CCBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="ccboard.CCBoardBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%
	request.setCharacterEncoding("utf-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String secret = request.getParameter("secret");
	if(secret == null) {
		secret = "off";
	}
	
	
	CCBoardBean ccBoardBean = new CCBoardBean();
	
	ccBoardBean.setNum(num);
	ccBoardBean.setSubject(subject);
	ccBoardBean.setContent(content);
	if(secret.equals("on")) {
		ccBoardBean.setSecret(1);
	}
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	ccBoardDAO.updateBoard(ccBoardBean);
	
	response.sendRedirect("/JSPProject/customercenter/cccontent.jsp?num=" + num);
%>
