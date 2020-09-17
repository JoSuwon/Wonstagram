<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	MemberDAO memberDAO = new MemberDAO();
	
	ArrayList<MemberBean> arr = memberDAO.findId(name);
	
	JSONArray jsonArr = new JSONArray();
	for(int i=0; i<arr.size(); i++) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("id", arr.get(i).getId());
		
		jsonArr.add(jsonObj);
	}
%>
<%=jsonArr.toString()%>