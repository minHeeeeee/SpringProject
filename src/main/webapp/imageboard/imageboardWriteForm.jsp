<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3>이미지 등록</h3>
<!--1. 단순 submit (제이쿼리 이용안하고 바로 띄우겠다) -->
<%-- <form id="imageboardWriteForm" method="post" enctype="multipart/form-data"  
action="/SpringProject/imageboard/imageboardWrite"> --%>
<!-- 2.Ajax 통신 -->
<form id ="imageboardWriteForm">
	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td width="100" align="center">상품코드</td>
			<td><input type="text" name="imageId" size="50"></td>
		</tr>
		
		<tr>
			<td width="100" align="center">상품명</td>
			<td><input type="text" name="imageName" size="50"></td>
		</tr>
		
		<tr>
			<td width="100" align="center">단가</td>
			<td><input type="text" name="imagePrice" value="0"size="50"></td>
		</tr>
		
		<tr>
			<td width="100" align="center">개수</td>
			<td><input type="text" name="imageQty"value="0" size="50"></td>
		</tr>
		
		<tr>
			<td width="100" align="center">내용</td>
			<td><textarea cols="50" rows="15" name="imageContent"></textarea></td>
		</tr>
		
		<tr>
			<td colspan="2">
			<input type="file" name="img"></td> <!-- name=image1 에서 변경 DTO못가게 -->
		</tr>
		
		<tr>
			<td colspan="2">
			<input type="file" name="img"></td> 
		</tr>
		
		
		<tr>
			<td colspan="2">
			<input type="file" name="img[]" multiple><!-- 파일을 한번에 여러개 선택 or 드래그 하겠다 -->
			</td> 
		</tr>
		
		<!-- 다중 파일 업로드 시에는 name속성에 같은 이름으로 잡아주자
		      나중에 배열로 받기위해 -->
		
		
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="imageboardWriteBtn" value="이미지등록"> 
				<input type="reset" value="다시작성">
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
$('#imageboardWriteBtn').click(function(){
	
	//1.단순 submit
	//$('#imageboardWriteForm').submit();
	
	
	//2.Ajax 통신
	var formData = new FormData($('#imageboardWriteForm')[0]);  //form안에 있는 모든것.
	
	$.ajax({
		type: 'post',
		url: '/SpringProject/imageboard/imageboardWrite',
		enctype:'multipart/form-data',
		processData: false,
		contentType:false,
		data:formData,
		success:function(){
			Swal.fire({
				  icon: 'success',
				  title: '이미지 등록 완료 (๑>ᴗ<๑)',
				closeOnClickOutside : false
					}).then(function(){
						location.href='/SpringProject/imageboard/imageboardList';      
					});
				
		},
		error: function(err){
			console.log(err);
		}
		
	});
});

</script>

<!-- 
processData
 - 기본값은 true
 - 기본적으로 Query String으로 변환해서 보내진다('변수=값&변수=값')
 - 파일 전송시에는 반드시 false로 해야 한다.(formData를 문자열로 변환하지 않는다)
 
contentType
  - 기본적으로 "application/x-www-form-urlencoded; charset=UTF-8"
  - 파일 전송시에는 'multipart/form-data'로 전송이 될 수 있도록 false로 설정한다


 -->

