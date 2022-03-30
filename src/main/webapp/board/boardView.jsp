<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
#boardViewTable td {
	font-size: 13px;
}

#boardViewTable {
	border-color: black;
	margin-left: 10pt;
}
</style>

<form id="boardViewForm">
<input type="hidden" name="seq" id="seq" value="${map.seq }">
<input type="hidden" name="pg" id="pg" value="${map.pg }">

<table width="450" id="boardViewTable" border="1" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">
	<tr>
		<td colspan="3">
			<h3><span id="subjectSpan"></span></h3>
		</td>
	</tr>
	
	<tr>
		<td width="150">글번호 : <span id="seqSpan"></span></td>
		<td width="150">작성자 : <span id="idSpan"></span></td>
		<td width="150">조회수 : <span id="hitSpan"></span></td>
	</tr>
	
	<tr>
		<!-- valign="top, middle(center), bottom" -->
		<td colspan="3" height="200" valign="top">
			<pre style="white-space: pre-line; word-break: break-all;"> <!-- 자동 줄바꿈 -->
				<span id="contentSpan"></span>
			</pre>
		</td>
	</tr>
</table>

<input type="button" value="목록"
onclick="location.href='/SpringProject/board/boardList?pg=${map.pg}'">


<span id="boardViewSpan">
	<input type="button" value="글수정" onclick="mode(1)"> <!-- seq, pg -->
	<input type="button" value="글삭제" onclick="mode(2)"> <!-- seq -->
</span>

<input type="button" value="답글" onclick="mode(3)"> <!-- seq(원글번호), pg(원글이 있는 페이지 번호) -->

</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		type: 'post',
		url: '/SpringProject/board/getBoardView',
		data: 'seq='+ $('#seq').val(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			
			//controller에서 보낼 때 각각의 이름으로
			//보내주는게 아니라 통으로 보내준다 
			//BoardDTO에 한꺼번에  싣고 보냈기 떄문에 boardDTO.~~적어주어야 한다.
			$('#subjectSpan').text(data.boardDTO.subject);
			$('#seqSpan').text(data.boardDTO.seq);
			$('#idSpan').text(data.boardDTO.id);
			$('#hitSpan').text(data.boardDTO.hit);
			$('#contentSpan').text(data.boardDTO.content);
			
			if(data.memId == data.boardDTO.id)
				$('#boardViewSpan').show();
			else
				$('#boardViewSpan').hide();
			
		},
		error:  function(err){
			alert(err);
		}
	});
});
</script>

<script>
function mode(num){
	if(num==1){ //글수정, seq, pg
		document.getElementById("boardViewForm").method = 'post';
		document.getElementById("boardViewForm").action = '/SpringProject/board/boardModifyForm';
		document.getElementById("boardViewForm").submit();
		
	}else if(num==2){ //글삭제, seq
		document.getElementById("boardViewForm").method = 'post';
		document.getElementById("boardViewForm").action = '/SpringProject/board/boardDelete';
		document.getElementById("boardViewForm").submit();
	
	}else if(num==3){ //답글, seq(원글번호), pg(원글이 있는 페이지 번호)
		document.getElementById("boardViewForm").method = 'post';
		document.getElementById("boardViewForm").action = '/SpringProject/board/boardReplyForm';
		document.getElementById("boardViewForm").submit();
	}
}
</script>


