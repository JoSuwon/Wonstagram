<%@page import="java.io.File"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="feed.FeedBean"%>
<%@page import="feed.FeedDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="relation.RelationDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String sessionId = (String)session.getAttribute("id");
	if(sessionId == null) {
		out.print("<script>alert('로그인을 해주세요!'); location.href='/JSPProject/member/login.jsp';</script>");
		//response.sendRedirect("/JSPProject/member/login.jsp");
	}
	RelationDAO relationDAO = new RelationDAO();
	ArrayList<String> followingArr = relationDAO.getFollowingList(sessionId);
	followingArr.add(sessionId);
	
	FeedDAO feedDAO = new FeedDAO();
	ArrayList<FeedBean> feedArr = new ArrayList<FeedBean>();
	for(int i=0; i<followingArr.size(); i++) {
		feedArr.addAll(feedDAO.getFeedList(followingArr.get(i)));
	}
	JSONArray jsonArr = new JSONArray();
	JSONArray sortedJsonArr = new JSONArray();
	List<JSONObject> jsonValues = new ArrayList<JSONObject>();
	
	ServletContext ctx = getServletContext();
	String realPath = ctx.getRealPath("upload/profileImg/");
	for(int i=0; i<feedArr.size(); i++) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("num", feedArr.get(i).getNum());
		jsonObj.put("id", feedArr.get(i).getId());
		jsonObj.put("address", feedArr.get(i).getAddress());
		jsonObj.put("imgLocation", feedArr.get(i).getImgLocation());
		jsonObj.put("content", feedArr.get(i).getContent().replace("\r\n", "<br>"));
		jsonObj.put("date", feedArr.get(i).getDate().toString());
		File f = new File(realPath + "profileImg_" + feedArr.get(i).getId() + ".jpg");
		if(f.exists()) {
			jsonObj.put("profileExist", true);
		} else {
			jsonObj.put("profileExist", false);
		}
		
		jsonArr.add(jsonObj);
		jsonValues.add(jsonObj);
	}
	
	Collections.sort(jsonValues, new Comparator<JSONObject>() {
		//You can change "Name" with "ID" if you want to sort by ID
        private static final String KEY_NAME = "date";

        @Override
        public int compare(JSONObject a, JSONObject b) {
            String valA = new String();
            String valB = new String();
            

            try {
                valA = (String) a.get(KEY_NAME);
                valB = (String) b.get(KEY_NAME);
            } 
            catch (Exception e) {
                //do something
            }
            
            return -valA.compareTo(valB);
            //if you want to change the sort order, simply use the following:
            //return -valA.compareTo(valB);
        }
	});
	
	for(int i=0; i<jsonArr.size(); i++) {
		sortedJsonArr.add(jsonValues.get(i));
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>뉴스피드</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/newsfeed/newsfeed.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	var feedList = <%=sortedJsonArr.toString()%>;
	var index = 0;
	var endFeed = false;
	var prepare = true;
	var sessionId = '<%=sessionId%>';
	
	
	$(function() {
		if(feedList.length > 0) {
			addFeed(index);
			/* index++; */
		} else {
			$('#wrap').append('<h2 style="text-align:center; margin-top: 30px;">더이상 피드가 없습니다.</h2>');
			endFeed = true;			
		}
		
		
		
		window.addEventListener('scroll', function() {
			let scrollLocation = document.documentElement.scrollTop; // 현재 스크롤바 위치
			let windowHeight = window.innerHeight; // 스크린 창
			let fullHeight = document.body.scrollHeight; //  margin 값은 포함 x
		
			if(scrollLocation + windowHeight >= fullHeight*0.97){
				if(feedList.length <= index && !endFeed) {
					$('#wrap').append('<h2 style="text-align:center; margin-top: 30px;">더이상 피드가 없습니다.</h2>');
					endFeed = true;
				} else if(index < feedList.length) {
					if(prepare) {
						prepare = false;
						addFeed(index);
						/* index++; */
					}
				}
			}
		});
		
	});
	
	
	
	function searchTag(e) {
		location.href="/JSPProject/search/searchFeed.jsp?column=tag&val="+e.innerText.substr(1);
	}
	
	
	function addFeed() {
		var content = feedList[index].content;
		var flag = false;
		var transContent = '';
		
		for(var i=0; i<content.length; i++) {
			if(flag == false) {
				if(content[i] == '#') {
					flag = true;
					transContent += '<a class="hashtag" onclick="searchTag(this)">' + content[i];	
				} else {
					transContent += content[i];
				}
			} else {
				if(content[i] == '#') {
					falg = false;
					transContent += '</a>' + '<a class="hashtag" onclick="searchTag(this)">' + content[i];
				} else if(content[i] == ' ') {
					falg = false;
					transContent += ' </a>';
				} else {
					transContent += content[i];
				}
			}
		}
		if(flag) transContent += '</a>';
		
		$('#nextBtn').remove();
		
		var feedTable = '<br><br>';
		feedTable += '<table id="feedTable_' + feedList[index].num + '" class="feedTable">';
		feedTable += 	'<tr>';
		feedTable += 		'<td>';
		feedTable += 			'<div id="profileImgBox">';
		if(feedList[index].profileExist) {
			feedTable += 				'<img src="/JSPProject/upload/profileImg/profileImg_' + feedList[index].id.toLowerCase() + '.jpg" id="profileImg">';
		} else {
			feedTable += 				'<img src="/JSPProject/upload/profileImg/basicProfile.png" id="profileImg">';
		}
		feedTable += 			'</div>';
		feedTable += 			'<h3 id="idH3"><a href="/JSPProject/profile/profile.jsp?id=' + feedList[index].id + '">' + feedList[index].id + '</a></h3>';
		feedTable += 		'</td>';
		feedTable += 	'</tr>';
		feedTable += 	'<tr><td><h3 id="idH3">위치 : ' + feedList[index].address + '</h3></td></tr>';
		feedTable += 	'<tr><td><h3 id="idH3">작성일 : ' + feedList[index].date.substring(0,16) + '</h3></td></tr>';
		feedTable += 	'<tr><td><img id="feedImg" src="/JSPProject/upload/' + feedList[index].imgLocation + '"  onclick="goFeed(' + feedList[index].num + ')"></td></tr>';
		feedTable +=	'<tr><td><h4>' + transContent + '</h4></td></tr>';
		if(doYouLike(feedList[index].num) == 'true') {
			feedTable +=	'<tr><td><img id="likeOn_' + feedList[index].num + '" class="like" src="/JSPProject/images/feed/likeOn.svg" onclick="changeLike(this,' + feedList[index].num + ')"><span id="likeList_' + feedList[index].num + '" class="likeList"></span></td><tr>';	
		} else {
			feedTable +=	'<tr><td><img id="likeOff_' + feedList[index].num + '" class="like" src="/JSPProject/images/feed/likeOff.svg" onclick="changeLike(this,' + feedList[index].num + ')"><span id="likeList_' + feedList[index].num + '" class="likeList"></span></td><tr>';
		}
		feedTable += '</table>';
		$('#wrap').append(feedTable);
		likeList(feedList[index].num);
		
		index++;
		prepare = true;
		if(feedList.length <= index && !endFeed) {
			$('#wrap').append('<h2 style="text-align:center; margin-top: 30px;">더이상 피드가 없습니다.</h2>');
			endFeed = true;
		} else {
			$('#wrap').append('<br><div style="text-align:center;"><input id="nextBtn" class="btn" type="button" onclick="addFeed()" value="더 불러오기"></div>');
		}
		
	}
	
	function goFeed(num) {
		location.href = '/JSPProject/profile/feed.jsp?num=' + num;
	}
	
	function changeLike(e, feedNum) {
		if(e.id == 'likeOff_'+feedNum) {
			$.ajax({
				url: '/JSPProject/profile/likePro.jsp',
				type: 'post',
				data: {feedNum: feedNum, id: sessionId, func: 'likeOn'},
				success: function () {
					$('#likeOff_'+feedNum).attr('src', '/JSPProject/images/feed/likeOn.svg');
					$('#likeOff_'+feedNum).attr('id', 'likeOn_'+feedNum);
					likeList(feedNum);
				}
			});
		} else if(e.id == 'likeOn_'+feedNum) {
			$.ajax({
				url: '/JSPProject/profile/likePro.jsp',
				type: 'post',
				data: {feedNum: feedNum, id: sessionId, func: 'likeOff'},
				success: function () {
					$('#likeOn_'+feedNum).attr('src', '/JSPProject/images/feed/likeOff.svg');
					$('#likeOn_'+feedNum).attr('id', 'likeOff_'+feedNum);
					likeList(feedNum);
				}
			});
		}
	}
	
	function likeList(feedNum) {
		$('#likeList_'+feedNum).empty();
		$.ajax({
			url: '/JSPProject/profile/likePro.jsp',
			type: 'post',
			data: {feedNum: feedNum, func: 'getLikeList'},
			dataType : 'json',
			success: function(data) {
				if(data.length > 3) {
					for(var i=0; i<3; i++) {
						if(i < 2) {
							$('#likeList_'+feedNum).append(data[i] + '님, ');	
						} else {
							$('#likeList_'+feedNum).append(data[i] + '님');
						}
					}
					$('#likeList_'+feedNum).append(' 외 ' + (data.length-3) + '명이 좋아합니다!');
				} else if(data.length > 0) {
					for(var i=0; i<data.length; i++) {
						if(i < data.length-1) {
							$('#likeList_'+feedNum).append(data[i] + '님, ');	
						} else {
							$('#likeList_'+feedNum).append(data[i] + '님');
						}
					}
					$('#likeList_'+feedNum).append('이 좋아합니다!');
				}
			}
		});
	}
	
	function doYouLike(feedNum) {
		let result = '';
		$.ajax({
			url: '/JSPProject/profile/likePro.jsp',
			type: 'post',
			async: false,
			data: {func: 'doYouLike', id: sessionId, feedNum: feedNum},
			dataType: 'text',
			success: function (data) {
				data = data.replace(/\s+/, "");//왼쪽 공백제거
				data = data.replace(/\s+$/g, "");//오른쪽 공백제거
				data = data.replace(/\n/g, "");//행바꿈제거
				data = data.replace(/\r/g, "");//엔터제거
				result = data;
			}
		});	
		return result;
	}
	
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>뉴스피드</h1>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>