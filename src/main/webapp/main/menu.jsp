<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.mainnav {
background-color: #b0c4de;
	list-style: none;
}

.mainnav li {
	display: inline-block;
}

.mainnav li a {
	display: block;
	padding: 0 13px; /* 위아래, 좌우 */
	color:#000000;
font: bold 16px/40px 'Sunflower',sans-serif;
	    /* 폰트 굵기 | 크기/line-height : 글꼴  */
	text-decoration: none;
}

.mainnav li a:hover {
	color: #ffffff;
background-color : #4169e1;
}
</style>

<ul class="mainnav">
	<c:if test="${memId != null }">
		<li><a href="/SpringProject/board/boardWriteForm">글쓰기</a></li>
		<li><a href="/SpringProject/imageboard/imageboardWriteForm">이미지등록</a></li>
			<li><a href="/SpringProject/guestbook/guestbookWriteForm">방명록등록</a></li>
	</c:if>
	
	<li><a href="/SpringProject/board/boardList">목록</a></li>
	<li><a href="/SpringProject/imageboard/imageboardList">이미지목록</a></li>
	<li><a href="/SpringProject/guestbook/guestbookList">방명록목록</a></li>
</ul>


