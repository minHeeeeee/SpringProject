<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
#boardReplyForm div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>

<h3>답글쓰기</h3>
<form name="boardReplyForm" id="boardReplyForm">

	<input type="hidden" name="pseq" id="pseq" value=${pseq }>
	<input type="hidden" name="pg" id="pg" value=${pg }>

	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td width="100" align="center">제목</td>
			<td>
				<input type="text" name="subject" id="subject" size="30" placeholder="제목입력">
				<div id="subjectDiv"></div>
			</td>
		</tr>
		<tr>
			<td width="100" align="center">내용</td>
			<td>
				<textarea rows="15" cols="50" placeholder="내용입력" name="content" id="content"></textarea>
				<div id="contentDiv"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="button" id="boardReplyBtn" value="답글쓰기"> 
			<input type="reset" id="resetBtn" value="다시작성">
			<input type="button" id="back" value="뒤로가기" onclick="history.back()">
			</td>
		</tr>
	</table>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$('#boardReplyBtn').click(function() {
		$('#subjectDiv').empty();
		$('#contentDiv').empty();
		
		if ($('#subject').val() == '')
			$('#subjectDiv').text('제목를 입력하세요');
		else if ($('#content').val() == '')
			$('#contentDiv').text('글내용을 입력하세요');
		else{
			$.ajax({
				type: 'post',
				url: '/SpringProject/board/boardReply',
				data: {
					'pseq': $('#pseq').val(),   //원글번호
					'subject': $('#subject').val(),
					'content': $('#content').val()
				},
				success: function(){
					alert('답글쓰기 성공');
					location.href = '/SpringProject/board/boardList?pg=${pg}' //원글이 있는 pg값 들고가자
				},
				error: function(err){
					alert(err);
				}
			});
		}
			
	});
	
	$('#resetBtn').click(function(){
		$('#subjectDiv').empty();
		$('#contentDiv').empty();
		
	});
</script>
