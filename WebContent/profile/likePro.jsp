<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int feedNum = Integer.parseInt(request.getParameter("feedNum"));
	String id = request.getParameter("id");
	String func = request.getParameter("func");
	
	LikeDAO likeDAO = new LikeDAO();
	if(func.equals("likeOn")) {
		likeDAO.likeOn(feedNum, id);
	} else if(func.equals("likeOff")) {
		likeDAO.likeOff(feedNum, id);
	} else if(func.equals("getLikeList")) {
		ArrayList<String> likeArr = likeDAO.getLikeList(feedNum);
		
		JSONArray jsonArr = new JSONArray();
		for(int i=0; i<likeArr.size(); i++) {
			jsonArr.add(likeArr.get(i));
		}
		out.print(jsonArr.toString());
	} else if(func.equals("doYouLike")) {
		boolean result = likeDAO.doYouLike(feedNum, id);
		if(result) {
			out.print("true");
		} else {
			out.print("false");
		}
	}
%>