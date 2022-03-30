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
<form name="guestbookModifyForm" id="boardModifyForm">
	<input type="hidden" name="seq" id="seq" value="${seq }">
	<input type="hidden" name="pg" id="pg" value="${pg }">

	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td width="100" align="center">작성자</td>
			<td><input type="text" id="name" name="name" size="50"></td>
		</tr>
		<tr>
			<td width="100" align="center">이메일</td>
			<td><input type="text" id="email" name="email" size="50"></td>
		</tr>

		<tr>
			<td width="100" align="center">홈페이지</td>
			<td><input type="text"  id="homepage"name="homepage" size="50"></td>
		</tr>

		<tr>
			<td width="100" align="center">제목</td>
			<td><input type="text" id="subject" name="subject" size="50">
			<div id ="subjectDiv"></div></td>
			
			
		</tr>

		<tr>
			<td width="100" align="center">내용</td>
			<td><textarea cols="50" rows="15" id="content" name="content"></textarea>
			<div id ="contentDiv"></div></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="button" id="guestbookModifyBtn" value="글수정"> 
			<input type="reset" id="resetBtn" value="다시작성">
		</td>
		</tr>
	</table>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		type: 'post',
		url: '/SpringProject/guestbook/getGuestbookView',
		data: 'seq=' + $('#seq').val(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			
			$('#subject').val(data.guestbookDTO.subject);
			$('#content').val(data.guestbookDTO.content);
		},
		error: function(err){
			console.log(err);
		}
	});
});

//수정버튼
$('#guestbookModifyBtn').click(function(){
	$('#subjectDiv').empty();
	$('#contentDiv').empty();
	
	if ($('#subject').val() == '')
		$('#subjectDiv').text('제목를 입력하세요');
	else if ($('#content').val() == '')
		$('#contentDiv').text('글내용을 입력하세요');
	else{
		$.ajax({
			type: 'post',
			url: '/SpringProject/guestbook/guestbookModify',
			data: {
				'seq': $('#seq').val(),
				'subject': $('#subject').val(),
				'content': $('#content').val()
			},
			success: function(){
				
				Swal.fire({
					  icon: 'success',
					  title: '수정완료!',
					closeOnClickOutside : false
						}).then(function(){
							location.href='/SpringProject/guestbook/guestbookList?pg='+$('#pg').val();          
						});
					  
					
			},
			error: function(err){
				alert(err);
			}
		});
				

	}
});
</script>


