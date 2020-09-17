<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- Remember to include jQuery :) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
	var colors = ['#00000', '#1a1a1a', '#333333', '#4d4d4d', '#666666', '#808080', '#999999', '#b3b3b3', '#cccccc', '#e6e6e6', '#ffffff'];
	var colorsIdx = [0,1,2,3,4,5,6,7,8,9,10];
	var titles;
	
	window.onload = function() {
		titles = document.getElementsByClassName("title");
		setInterval("changeColor()", 100);

		$('a[href="#noticeModal"]').click(function(e) {
			e.preventDefault();
			
			$(this).modal({
				fadeDuration:200
			});
		});
	}
	
	function changeColor() {
		for(var i=0; i<colorsIdx.length; i++) {
			colorsIdx[i]--;
			if(colorsIdx[i] == -1) {
				colorsIdx[i] = 10;
			}
			
			var idx = colorsIdx[i];
			var color = colors[idx];
			
			titles[i].style.color = color;
		}
	}
	
	function search_feed() {
		var val = $("#inputBox").val();
		if(val[0] == '#') {
			location.href = "/JSPProject/search/searchFeed.jsp?column=tag&val="+val.substr(1, val.length-1);
		} else if(val[0] == '@') {
			location.href = "/JSPProject/search/searchFeed.jsp?column=id&val="+val.substr(1, val.length-1);
		} else {
			alert("알맞은 형식으로 검색해주세요!");
			$("#inputBox").val("");
			$("#inputBox").focus();
		}
	}
</script>
<header>
	<%
	String id = (String)(session.getAttribute("id"));
	if(id != null) {
	%>
		<div id="top_login">
			<b><a href="/JSPProject/profile/profile.jsp?id=<%=session.getAttribute("id")%>">@<%=session.getAttribute("id") %></a>님 안녕하세요.&nbsp;&nbsp;&nbsp;&nbsp;</b>
			<a href="/JSPProject/member/modify.jsp">회원정보수정</a> |
			<a href="/JSPProject/member/logout.jsp">로그아웃</a>
		</div>	
	<%
	} else {
	%>
	<div id="top_login">
		<a href="/JSPProject/member/login.jsp">로그인</a> |
		<a href="/JSPProject/member/join.jsp">회원가입</a>
	</div>
	<%
	}
	%>
	<div class="top_clear"></div>
	<div id="logo">
		<a href="/JSPProject/newsfeed/newsfeed.jsp">
			<!-- <img src="/JSPProject/images/logo.png" width="265" height="62"> -->
			<h1 id="logoTitle">
				<!-- <span>W</span><span>o</span><span>n</span><span>s</span><span>t</span><span>a</span><span>g</span><span>r</span><span>a</span><span>m</span> -->
				<span class="title">W</span><span class="title">o</span><span class="title">n</span><span class="title">s</span><span class="title">t</span><span class="title">a</span><span class="title">g</span><span class="title">r</span><span class="title">a</span><span class="title">m</span><span class="title">&nbsp;!</span>
			</h1>
		</a>
	</div>
	
	<nav id="top_menu">
		<ul>
			<!-- <li><a href="/JSPProject/index.jsp">홈</a></li> -->
			<li>
				<div id="search_input">
					<input id="inputBox" type="text" placeholder="@아이디 or #해시태그"><input id="inputBtn" type="button" value="검색" onclick="search_feed()">
				</div>
			</li>
			<li><a href="/JSPProject/newsfeed/newsfeed.jsp">뉴스피드</a></li>
			<%
			if(id != null) {
			%>
			<li><a href="/JSPProject/profile/profile.jsp?id=<%=id%>">내 프로필</a></li>
			<%
			} else {
			%>
			<li><a href="/JSPProject/profile/profile.jsp">내 프로필</a></li>
			<%
			}
			%>
			<li><a href="/JSPProject/customercenter/customercenter.jsp">고객센터</a></li>
		</ul>
	</nav>
	<div class="top_clear"></div>
	<div style="text-align: right; margin-right: 20px;"><a href="#noticeModal">새로운 알림(만드는중)</a></div>
	<br><hr>
	<div id="noticeModal" class="modal">
		<h2>새로운 알림</h2>
		<div id="noticeList">
		</div>
	</div>
</header>