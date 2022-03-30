<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h3>글쓰기</h3>
<form id="guestbookWriteForm" name="guestbookWriteForm">
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
			<input type="button" id="guestbookWriteBtn" value="글작성"> 
			<input type="reset" value="다시작성" id="resetBtn">
			<input type="button" value="글목록" onclick="location.href='/SpringProject/guestbook/guestbookList?pg=1'"></td>
		</tr>

	</table>
</form>

	<script type="Text/javascript"
		src="http://code.jquery.com/jquery-3.6.0.min.js"> </script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script type="Text/javascript">
	$('#guestbookWriteBtn').click(function(){
		
		if($('#subject').val()=='') {
			$('#subjectDiv').css('color', 'red');
			$('#subjectDiv').text('제목을 입력하세요');
			
		
		
		}else if($('#content').val()==''){
			
			$('#contentDiv').css('color', 'red')
			;
			$('#contentDiv').text('내용을 입력하세요');
			
		}else{
			$.ajax({
				type: 'post',
				url: '/SpringProject/guestbook/guestbookWrite',
				data: {
					'name' : $('#name').val(),
					'email' : $('#email').val(),
					'homepage' : $('#homepage').val(),
					'subject': $('#subject').val(),
					'content': $('#content').val(),
				},
				success: function(){
					Swal.fire({
						  icon: 'success',
						  title: '등록성공!',
						  text: '방명록에 글이 등록완료되었습니다.',
						closeOnClickOutside : false
							}).then(function(){
								location.href='/SpringProject/guestbook/guestbookList?pg=1'           
							});
						  
           
						
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
</body>
</html>



