<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
#boardModifyForm div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>

<h3>글수정</h3>
<form name="boardModifyForm" id="boardModifyForm">
	<input type="hidden" name="seq" id="seq" value="${seq }">
	<input type="hidden" name="pg" id="pg" value="${pg }">

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
			<input type="button" id="boardModifyBtn" value="글수정"> 
			<input type="reset" id="resetBtn" value="다시작성">
		</td>
		</tr>
	</table>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		type: 'post',
		url: '/SpringProject/board/getBoardView',
		data: 'seq=' + $('#seq').val(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			
			$('#subject').val(data.boardDTO.subject);
			$('#content').val(data.boardDTO.content);
		},
		error: function(err){
			console.log(err);
		}
	});
});

//수정버튼
$('#boardModifyBtn').click(function(){
	$('#subjectDiv').empty();
	$('#contentDiv').empty();
	
	if ($('#subject').val() == '')
		$('#subjectDiv').text('제목를 입력하세요');
	else if ($('#content').val() == '')
		$('#contentDiv').text('글내용을 입력하세요');
	else{
		$.ajax({
			type: 'post',
			url: '/SpringProject/board/boardModify',
			data: {
				'seq': $('#seq').val(),
				'subject': $('#subject').val(),
				'content': $('#content').val()
			},
			success: function(){
				alert('글수정 완료')
				location.href='/SpringProject/board/boardList?pg='+$('#pg').val();
			},
			error: function(err){
				console.log(err);
			}
		});
	}
});
</script>


