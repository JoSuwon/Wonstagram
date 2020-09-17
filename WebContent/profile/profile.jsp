<%@page import="java.io.File"%>
<%@page import="relation.RelationDAO"%>
<%@page import="feed.FeedBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="feed.FeedDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String sessionId = (String)session.getAttribute("id");
	if(sessionId == null) {
		out.print("<script>alert('로그인을 해주세요!'); location.href='/JSPProject/member/login.jsp';</script>");
	}
	
	String id = request.getParameter("id");
	if(id == null) {
		//response.sendRedirect("/JSPProject/member/login.jsp");
		id = "";
	}
	
	FeedDAO feedDAO = new FeedDAO();
	ArrayList<FeedBean> feedArr = feedDAO.getFeedList(id);
%>
<%
	RelationDAO relationDAO = new RelationDAO();
	boolean b_relation = relationDAO.doYouFollow(sessionId, id);
%>
<%
	ServletContext ctx = getServletContext();
	String realPath = ctx.getRealPath("upload/profileImg/");
    File f = new File(realPath + "profileImg_" + id + ".jpg");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>@<%=id %>님 프로필</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/profile/profile.css">

<!-- Remember to include jQuery :) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
	var followerList;
	var followingList;
	
	$(function() {
		$('a[href="#feedModal"]').click(function(e) {
			e.preventDefault();
			
			$(this).modal({
				fadeDuration:200
			});
		});
		
		$('a[href="#followerModal"]').click(function(e) {
			e.preventDefault();
			
			$(this).modal({
				fadeDuration:200
			});
		});
		
		$('a[href="#followingModal"]').click(function(e) {
			e.preventDefault();
			
			$(this).modal({
				fadeDuration:200
			});
		});
		
		$('a[href="#profileModal"]').click(function(e) {
			e.preventDefault();
			
			$(this).modal({
				fadeDuration:200
			});
		});
		
		
		$("#input_img").on("change", handleImgFileSelect);
	});
	
	function handleImgFileSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")) {
				$("#previewImg").removeAttr("src");
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#previewImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	function follow(e) {
		if('<%=sessionId%>' == '') {
			alert("로그인을 해주세요");
			return;
		}
		
		if(e.id == 'followOn') {
			$.ajax({
				url: '/JSPProject/profile/followPro.jsp',
				type: 'post',
				data: {id: '<%=sessionId%>', targetId: '<%=id%>' , func: 'followOn'},
				success: function () {
					$('#followOn').val("팔로우 해제");
					$('#followOn').attr('id', 'followOff');
					getFollowerList();
				}
			});
		} else if(e.id == 'followOff') {
			$.ajax({
				url: '/JSPProject/profile/followPro.jsp',
				type: 'post',
				data: {id: '<%=sessionId%>', targetId: '<%=id%>' , func: 'followOff'},
				success: function () {
					$('#followOff').val("팔로우 하기");
					$('#followOff').attr('id', 'followOn');
					getFollowerList();
				}
			});
		}
	}
	
	function getFollowerList() {
		$.ajax({
			url: '/JSPProject/profile/followPro.jsp',
			type: 'post',
			data: {targetId: '<%=id%>' , func: 'getFollowerList'},
			dataType: 'json',
			success: function (data) {
				$('#followerNum').text(' '+data.length);
				followerList = data;
				$('#followerList').empty();
				for(var i=0; i<followerList.length; i++) {
					$('#followerList').append('<div id="f_profileImgBox"><img src="/JSPProject/upload/profileImg/basicProfile.png" id="f_profileImg"></div>'+
											  '<div id="f_id"><a href="/JSPProject/profile/profile.jsp?id=' + followerList[i] + '">@' + followerList[i] + '</a></div>');
				}
			}
		});
	}
	
	function getFollowingList() {
		$.ajax({
			url: '/JSPProject/profile/followPro.jsp',
			type: 'post',
			data: {id: '<%=id%>' , func: 'getFollowingList'},
			dataType: 'json',
			success: function (data) {
				$('#followingNum').text(' '+data.length);
				followingList = data;
				$('#followingList').empty();
				for(var i=0; i<followingList.length; i++) {
					<%-- <%
					ServletContext ctx = getServletContext();
					String realPath = ctx.getRealPath("upload/profileImg/");
				    File f = new File(realPath + "profileImg_" + followingList[i].toLowerCase() + ".jpg");
				    if(f.exists()) {
			    	%>
			    	<%
				    } else {
			    	%>
			    	<%
				    }
					%> --%>
					$('#followingList').append('<div id="f_profileImgBox"><img src="/JSPProject/upload/profileImg/basicProfile.png" id="f_profileImg"></div>'+
							  '<div id="f_id"><a href="/JSPProject/profile/profile.jsp?id=' + followingList[i] + '">@' + followingList[i] + '</a></div>');
				}
			}
		});
	}
	
	$(function() {
		getFollowerList();
		getFollowingList();
	});
</script>

</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<table id="profileTable">
			<tr>
				<td rowspan="2" id="img_td">
					<div id="profileImgBox">
						<%
						if(f.exists()) {
						%>
							<img src="/JSPProject/upload/profileImg/profileImg_<%=id.toLowerCase() %>.jpg" id="profileImg">
						<%
						} else {
						%>
							<img src="/JSPProject/upload/profileImg/basicProfile.png" id="profileImg">
						<%
						}
						%>
						
						<%
						if(id.equals(sessionId)) {
						%>
							<a href="#profileModal"><img src="/JSPProject/images/profile/setting.svg" id="setting"></a>
						<%
						}
						%>
					</div>
				</td>
				<td colspan="2">
					<h2>@<%=id %>님 프로필</h2>
					<%
					if(!id.equals(sessionId)) {
						if(b_relation) {
					%>
							<input type="button" id="followOff" class="btn" value="팔로우 해제" onclick="follow(this)">
					<%
						} else {
					%>
							<input type="button" id="followOn" class="btn" value="팔로우 하기" onclick="follow(this)">
					<%
						}
					}
					%>
				</td>
			</tr>
			<tr>
				<td><h3><a href="#followerModal" id="follow_a">팔로워 <span id="followerNum"></span></a></h3></td>
				<td><h3><a href="#followingModal" id="follow_a">팔로잉 <span id="followingNum"></span></a></h3></td>
			</tr>
			<tr>
				<td colspan="3" id="add_td">
					<%
					if(id.equals(sessionId)) {
					%>
						<a href="#feedModal"><h3>+ 피드 쓰기</h3></a>
					<%
					}
					%>
				</td>
			</tr>
			<tr>
				<td colspan="3"><hr style="border:none; border-top:1.2px solid #00000085;"></td>
			</tr>
			<%
			for(int i=0; i<feedArr.size(); i++) {
				FeedBean feedBean = feedArr.get(i);
				if(i % 3 == 0) {
			%>
					<tr>	
			<%
				}
			%>
				<td id="feed_td">
					<div>
						<a href="/JSPProject/profile/feed.jsp?num=<%=feedBean.getNum()%>">
							<img src="/JSPProject/upload/tn_<%=feedBean.getImgLocation() %>">
						</a>
					</div>
				</td>
			<%
				if(i % 3 == 2) {
			%>
					</tr>
			<%
				}
			}
			%>
		</table>
	</div>
	
	<!-- Modal HTML embedded directly into document -->
	<div id="feedModal" class="modal">
		<h1>피드 올리기</h1>
		<form action="feedUpload.jsp" method="post" enctype="multipart/form-data" name="uploadFeed" onsubmit="if($('#input_img').val() ==''){alert('사진을 선택해주세요!');return false;}">
			<table id="modalTable">
				<tr>
					<td>
						이미지 : <input type="file" id="input_img" name="imgLocation" size=40>
					</td>
				</tr>
				<tr>
					<td>
						<div class="img_wrap">
							<img id="previewImg">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" class="btn" onclick="sample5_execDaumPostcode()" value="주소 검색">
						<input type="text" name="address" id="sample5_address" class="textBox" placeholder="주소" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						<div class="map_wrap">
							<div id="map" style="width:100%;height:300px;margin-top:10px;display:none"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="content" class="textBox" placeholder="본문을 작성해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width:100px; margin:15px auto;"><input type="submit" value="피드올리기" class="btn"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="followerModal" class="modal">
		<h2>팔로워 목록</h2>
		<div id="followerList" >
		</div>
	</div>
	
	<div id="followingModal" class="modal">
		<h2>팔로잉 목록</h2>
		<div id="followingList">
		</div>
	</div>
	
	<div id="profileModal" class="modal">
		<h2>프로필 사진 변경</h2>
		<form action="profileImgUpdate.jsp" method="post" enctype="multipart/form-data" name="uploadFeed" onsubmit="if($('#input_profile').val() ==''){alert('사진을 선택해주세요!');return false;}">
			<table id="modalTable">
				<tr>
					<td>
						프로필이미지 선택 : <input type="file" id="input_profile" name="profileImg" size=40>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width:100px; margin:15px auto;"><input type="submit" value="프로필 변경" class="btn"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
 	
	<jsp:include page="/inc/bottom.jsp"/>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e6d799c2d48212cc04d6af4a71889a8&libraries=services"></script>
	<script src="/JSPProject/js/map/map.js"></script>
</body>
</html>