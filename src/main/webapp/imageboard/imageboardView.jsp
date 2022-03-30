<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css" >
#imageboardViewTable th{
   font-size: 16px;
   width: 100px
}

#imageboardViewTable td{
   font-size: 13px;
   width: 100px;
   text-align: center;
}

#imageboardViewTable{
   border-color: black;
   margin-left: 10pt;
  /*  table-layout: fixed; */
}
</style>
<input type="text" name="seq" id="seq" value="${seq}">
<input type="text" name="pg" value="${pg}">


<table border="1" cellspacing="0" cellpadding="5" id="imageboardViewTable" frame="hsides" rules="rows">
	<tr>
      <td rowspan="4">
         <img id="image1"  width="150" height="auto" >
      </td>
      <th>상품명</th>
      <td><span id="imageNameSpan"></span></td>
   </tr>
   
   <tr>
      <th>단가</th>
      <td> <span id="imagePriceSpan"></span> </td>
   </tr>
   
   <tr>
      <th>개수</th>
      <td><span id="imageQtySpan"></span></td>
   </tr>
   
   <tr>
      <th>합계</th>
      <td><span id="totalSpan"></span></td>
         
   </tr> 
   
   <tr>
      <td colspan="3" style="text-align: left; vertical-align: top;" height="200">
      <pre style="white-space: pre-line; word-break: break-all;">
      <span id="imageContentSpan"></span>
      </pre>
      </td>
   </tr> 
</table>
<input type="button" value="목록" style="float: left; margin: 3px 0 0 10px;"
onclick="location.href='/SpringProject/imageboard/imageboardList?pg=${pg}'">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		type:'post',
		url:'/SpringProject/imageboard/getImageboardView',
		data:'seq='+$('#seq').val(),
		dataType: 'json',
		success:function(data){
			console.log(JSON.stringify(data));
			
			var total = data.imagePrice * data.imageQty;
			//가상폴더의 주소를 넣어줘라 실제폴더의 주소는 적는거 아니다.
			$('#image1').attr('src','/SpringProject/storage/'+data.image1); //속성 src를 넣어라
			$('#imageNameSpan').text(data.imageName);
			$('#imagePriceSpan').text(data.imagePrice);
			$('#imageQtySpan').text(data.imageQty);
			$('#totalSpan').text(total);
			$('#imageContentSpan').text(data.imageContent);
		},
		error:  function(err){
			console.log(err);
		}
		
		
	});
	
});


</script>


