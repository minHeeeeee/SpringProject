<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<style type="text/css">
#quitForm div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>
</head>
<body>
	<form name="quitForm" id="quitForm">
		<input type="hidden" id="id" name="id" value="${memId}">

		<p class="lead">회원탈퇴를 하려면 비밀번호를 입력해주세요.</p>
		<table border="1" cellspacing="0" cellpadding="5">

			<tr>
				<td width="100" align="center" style="font-size: 9pt;">비밀번호</td>
				<td><input type="password" name="pwd" id="pwd" size="30"
					placeholder="비밀번호">
					<div id="pwdDiv"></div></td>
			</tr>

			<tr>
				<td width="100" align="center" style="font-size: 9pt;">비밀번호확인</td>
				<td><input type="password" name="pwd2" id="pwd2" size="30"
					placeholder="비밀번호확인">
					<div id="pwd2Div"></div></td>
			</tr>


			<tr>
				<td colspan="2" align="center"><input type="button"
					id="quitBtn" value="회원탈퇴"> <input type="button" value="취소"
					onclick="location.href='/SpringProject/index.jsp'"></td>
			</tr>
		</table>
		<div id="quitResult"></div>
	</form>

	<script type="text/javascript"
		src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

	<script type="text/javascript">

//회원탈퇴
$('#quitBtn').click(function(){
	
	if($('#quitForm #pwd').val() == '') 
		
		Swal.fire({
			  icon: 'warning',
			  title: '비밀번호를 입력해주세요!',
			  
			})
		
	else if($('#quitForm #pwd2').val() == '') 
		Swal.fire({
			  icon: 'warning',
			  title: '비밀번호확인을 해주세요!',
			})
	
	else if($('#quitForm #pwd').val() != $('#pwd2').val()) 
		Swal.fire({
			  icon: 'error',
			  title: '비밀번호가 틀렸어요!',
			})
	else{
	
	$.ajax({
		type:'post',
		url: '/SpringProject/member/pwCheck',//DB에 가서 비밀번호를 꺼내온다
		//data : $("quitForm").serialize(),
		data : {
			'id':$('#id').val(),
			'pwd':$('#pwd').val()
		},
		success: function(data){ 
			
				if(data=='ok'){
					const swalWithBootstrapButtons = Swal.mixin({
						  customClass: {
						    confirmButton: 'btn btn-success',
						    cancelButton: 'btn btn-danger'
						  },
						  buttonsStyling: false
						});
					swalWithBootstrapButtons.fire({
						  title: '정말로 탈퇴 하실껀가요?',
						  icon: 'warning',
						  showCancelButton: true,
						  confirmButtonText: '넹!!탈퇴할래요',
						  cancelButtonText: '아니요!!',
						  reverseButtons: true
						}).then((result) => {
						  if (result.isConfirmed) {
							  
						    
						  } else if (
						    /* Read more about handling dismissals below */
						    result.dismiss === Swal.DismissReason.cancel
						  ) {
						    swalWithBootstrapButtons.fire(
						      '취소 되었어요!',
						      'Your imaginary file is safe :)',
						      'error'
						    )
						  }
						});
					
			}
				else{
					Swal.fire({
						  icon: 'error',
						  title: '비밀번호가 맞지않아요!!',
						});
				}
		},
		error: function(){
			Swal.fire({
				  icon: 'error',
				  title: '서버에러!',
				});
		}
	});
}
});

</script>
