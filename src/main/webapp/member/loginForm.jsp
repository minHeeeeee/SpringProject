<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
#loginForm div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>
</head>
<body>
<form name="loginForm" id="loginForm">
	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td width="100" align="center" style="font-size: 9pt;">아이디</td>
			<td>
				<input type="text" name="id" id="id" placeholder="아이디 입력">
				<div id="idDiv"></div>
			</td>	
		</tr>
		
		<tr>
			<td width="100" align="center" style="font-size: 9pt;">비밀번호</td>
			<td>
				<input type="password" name="pwd" id="pwd" size="30" placeholder="비밀번호 입력">
				<div id="pwdDiv"></div>
			</td>	
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="loginBtn" value="로그인">
				<input type="button" value="회원가입"
				 	onclick="location.href='/SpringProject/member/writeForm'">
			</td>
		</tr>
	</table>
	<div id="loginResult"></div>
</form>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$('#loginBtn').click(function(){
	$('#loginForm #idDiv').empty();
	$('#loginForm #pwdDiv').empty();
	
	if($('#loginForm #id').val() == '') 
		$('#loginForm #idDiv').text('아이디 입력');
	else if($('#loginForm #pwd').val() == '') 
		$('#loginForm #pwdDiv').text('비밀번호 입력');
	else {
		$.ajax({
			type: 'post',
			url: '/SpringProject/member/login',
			
			data: {
				'id': $('#loginForm #id').val(),
				'pwd': $('#loginForm #pwd').val()
			},
			dataType: 'text', //문자열이 넘어와야한다.
			success: function(data){
				data = data.trim(); //문자열의 공백을 지워라
				//alert(data);
				
				if(data == 'ok')
					location.href="/SpringProject/index.jsp";
				
				else if(data == 'fail'){
					$('#loginResult').css('font-size', '15pt');
					$('#loginResult').css('font-weight', 'bold');
					$('#loginResult').css('color', 'red');
					$('#loginResult').text('로그인 실패');
				}
			},
			error: function(err){
				alert(err);
			}
		});
	}
});
</script>
</body>
</html>


