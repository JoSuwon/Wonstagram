<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="relation.RelationDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String targetId = request.getParameter("targetId");
	String func = request.getParameter("func");
	
	if(func.equals("followOn")) {
		RelationDAO relationDAO = new RelationDAO();
		relationDAO.followOn(id, targetId);
	} else if(func.equals("followOff")) {
		RelationDAO relationDAO = new RelationDAO();
		relationDAO.followOff(id, targetId);
	} else if(func.equals("getFollowerList")) {
		RelationDAO relationDAO = new RelationDAO();
		ArrayList<String> followerArr = relationDAO.getFollowerList(targetId); 
		
		JSONArray jsonArr = new JSONArray();
		for(int i=0; i<followerArr.size(); i++) {
			jsonArr.add(followerArr.get(i));
		}
		out.print(jsonArr);
	} else if(func.equals("getFollowingList")) {
		RelationDAO relationDAO = new RelationDAO();
		ArrayList<String> followingArr = relationDAO.getFollowingList(id);
		
		JSONArray jsonArr = new JSONArray();
		for(int i=0; i<followingArr.size(); i++) {
			jsonArr.add(followingArr.get(i));
		}
		out.print(jsonArr);
	}
%>