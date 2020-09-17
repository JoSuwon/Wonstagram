<%@page import="java.io.File"%>
<%@page import="like.LikeDAO"%>
<%@page import="comment.CommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comment.CommentDAO"%>
<%@page import="feed.FeedDAO"%>
<%@page import="feed.FeedBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%
	request.setCharacterEncoding("utf-8");

	String sessionId = (String)session.getAttribute("id");
	if(sessionId == null) sessionId = "";

	int num = Integer.parseInt(request.getParameter("num"));
	FeedDAO feedDAO = new FeedDAO();
	FeedBean feedBean = feedDAO.getFeed(num);
		
	String content = "";
	
	if(feedBean.getContent() != null) {
		content = feedBean.getContent().replace("\r\n", " <br/>");
	}
%>

<%
	LikeDAO likeDAO = new LikeDAO();
	boolean b_like = likeDAO.doYouLike(feedBean.getNum(), sessionId);
%>

<%
	CommentDAO commentDAO = new CommentDAO();
	ArrayList<CommentBean> commentArr = commentDAO.getCommentList(num);
%>

<%
	ServletContext ctx = getServletContext();
	String realPath = ctx.getRealPath("upload/profileImg/");
    File f = new File(realPath + "profileImg_" + feedBean.getId() + ".jpg");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>피드 보기</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/profile/feed.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	var content = '<%=content%>';
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
	
	$(function() {
		$('#content').append(transContent);
	});
	
	function searchTag(e) {
		location.href="/JSPProject/search/searchFeed.jsp?column=tag&val="+e.innerText.substr(1);
	}
	
	
	function insertComment() {
		var comment = $('#comment').val();
		if(comment == '') {
			alert("댓글을 작성해주세요!");
			$('#comment').focus();
			return;
		}
		
		$.ajax({
			url: '/JSPProject/profile/insertComment.jsp',
			type: 'post',
			data: {comment : comment, id : '<%=sessionId%>', feedNum : '<%=num%>'},
			dataType : 'json',
			success: function(data) {
				console.log(data);
				$('#comment').val("");
				if($('.noComment').length == 1) {
					$('#commentTable').empty();
				}
				$('#commentTable').append('<tr id="comment_' + data.num + '"><td id="commentId"><b><a href="/JSPProject/profile/profile.jsp?id='+ data.id +'">' + data.id + '</a> : </b>' + data.content + ' (' + data.date + ')<span id="deleteBtn" onclick="deleteComment(' + data.num + ')">✖️</span></td></tr>');
			}
		});
	}
	
	function deleteComment(num) {
		$.ajax({
			url: '/JSPProject/profile/deleteComment.jsp',
			type: 'post',
			data: {num : num},
			success : function() {
				alert("댓글을 삭제 하였습니다.");
				$('#comment_'+num).remove();
			}
		});
	}
	
	function deleteFeed(num) {
		$.ajax({
			url: '/JSPProject/profile/deleteFeed.jsp',
			type: 'post',
			data: {num : num},
			async: false,
			success: function() {
				alert("피드를 삭제 하였습니다.");
				location.href = "/JSPProject/profile/profile.jsp?id=<%=feedBean.getId()%>"; 
			}
		});
	}
	
	function changeLike(e) {
		if('<%=sessionId%>' == '') {
			alert("로그인을 해주세요");
			return;
		}
		if(e.id == 'likeOff') {
			$.ajax({
				url: '/JSPProject/profile/likePro.jsp',
				type: 'post',
				data: {feedNum: <%=feedBean.getNum()%>, id: '<%=sessionId%>', func: 'likeOn'},
				success: function () {
					$('#likeOff').attr('src', '/JSPProject/images/feed/likeOn.svg');
					$('#likeOff').attr('id', 'likeOn');
					likeList();
				}
			});
		} else if(e.id == 'likeOn') {
			$.ajax({
				url: '/JSPProject/profile/likePro.jsp',
				type: 'post',
				data: {feedNum: <%=feedBean.getNum()%>, id: '<%=sessionId%>', func: 'likeOff'},
				success: function () {
					$('#likeOn').attr('src', '/JSPProject/images/feed/likeOff.svg');
					$('#likeOn').attr('id', 'likeOff');
					likeList();
				}
			});
		}
	}
	
	function likeList() {
		$('#likeList').empty();
		$.ajax({
			url: '/JSPProject/profile/likePro.jsp',
			type: 'post',
			data: {feedNum: <%=feedBean.getNum()%>, func: 'getLikeList'},
			dataType : 'json',
			success: function(data) {
				if(data.length > 3) {
					for(var i=0; i<3; i++) {
						if(i < 2) {
							$('#likeList').append(data[i] + '님, ');	
						} else {
							$('#likeList').append(data[i] + '님');
						}
					}
					$('#likeList').append(' 외 ' + (data.length-3) + '명이 좋아합니다!');
				} else if(data.length > 0) {
					for(var i=0; i<data.length; i++) {
						if(i < data.length-1) {
							$('#likeList').append(data[i] + '님, ');	
						} else {
							$('#likeList').append(data[i] + '님');
						}
					}
					$('#likeList').append('이 좋아합니다!');
				}
			}
		});
	}
	
	$(function() {
		likeList();
	});
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<table id="feedTable">
			<tr>
				<td>
					<%
					if(sessionId.equals(feedBean.getId())) {
					%>
						<input type="button" class="btn" value="피드삭제" style="float: right;" onclick="deleteFeed(<%=num%>)">
					<%
					}
					%>
					<input type="button" class="btn" value="사진 다운로드" style="float: right; margin-right: 10px;" onclick="location.href='/JSPProject/profile/downloadImg.jsp?imgLocation=<%=feedBean.getImgLocation()%>'">
					<div id="profileImgBox">
						<%
						if(f.exists()) {
						%>
							<img src="/JSPProject/upload/profileImg/profileImg_<%=feedBean.getId().toLowerCase() %>.jpg" id="profileImg">
						<%
						} else {
						%>
							<img src="/JSPProject/upload/profileImg/basicProfile.png" id="profileImg">
						<%
						}
						%>
					</div>
					<h3 id="idH3"><a href="/JSPProject/profile/profile.jsp?id=<%=feedBean.getId()%>">@<%=feedBean.getId() %></a></h3>
				</td>
			</tr>
			<tr>
				<td>
					<h3 id="idH3">위치 : <%=feedBean.getAddress() %></h3>
				</td>
			</tr>
			<tr>
				<td>
					<h3 id="idH3">작성일 : <%=feedBean.getDate().toString().substring(0, 16) %></h3>
				</td>
			</tr>
			<tr>
				<td>
					<img id="feedImg" src="/JSPProject/upload/<%=feedBean.getImgLocation() %>">
				</td>
			</tr>
			<tr>
				<td>
					<h4 id="content"></h4>
				</td>
			</tr>
			<tr>
				<td>
					<%
					if(b_like) {
					%>
						<img id="likeOn" class="like" src="/JSPProject/images/feed/likeOn.svg" onclick="changeLike(this)">
					<%
					} else {
					%>
						<img id="likeOff" class="like" src="/JSPProject/images/feed/likeOff.svg" onclick="changeLike(this)">
					<%
					}
					%>
					<span id="likeList"></span>
				</td>
			</tr>
			
		</table>
		<br>
		<table id="commentTable">
			<%
			if(commentArr.size() == 0) {
			%>
				<tr>
					<td id="commentId" class="noComment">
						등록된 댓글이 없습니다.
					</td>
				</tr>
			<%
			} else {
				for(int i=0; i<commentArr.size(); i++) {
			%>
					<tr id="comment_<%=commentArr.get(i).getNum()%>">
						<td id="commentId">
							<b><a href="/JSPProject/profile/profile.jsp?id=<%=commentArr.get(i).getId()%>"><%=commentArr.get(i).getId() %></a> : </b>
							<%=commentArr.get(i).getContent() %>
							&nbsp;(<%=commentArr.get(i).getDate().toString().substring(0, 16) %>)
							<%
							if(sessionId.equals(commentArr.get(i).getId())) {
							%>
								<span id="deleteBtn" onclick="deleteComment(<%=commentArr.get(i).getNum()%>);">✖️</span>
							<%
							}
							%>
						</td>
					</tr>
			<%
				}
			}
			%>
		</table>
		<br>
		<div id="commentInput">
			<%
			if(sessionId == "") {
			%>
			<input type="text" id="comment" class="textBox" placeholder="로그인 이후 댓글을 작성하실수 있습니다." disabled="disabled">
			<input type="button" class="btn" value="작성하기">
			<%
			} else {
			%>
			<input type="text" id="comment" class="textBox" placeholder="댓글 작성하기">
			<input type="button" class="btn" value="작성하기" onclick="insertComment();">
			<%
			}
			%>
		</div>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>

</body>
</html>