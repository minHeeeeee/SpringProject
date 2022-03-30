<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
#guestbookViewTable td {
	font-size: 13px;
}

#guestbookViewTable {
	border-color: black;
	margin-left: 10pt;
}
</style>

<form id="guestbookViewForm">
<input type="text" name="seq" id="seq" value="${map.seq }">
<input type="text" name="pg" id="pg" value="${map.pg }">

<table width="450" id="guestbookViewTable" border="1" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">

	<tr>
	
		<td width="150">작성자 : <span id="nameSpan"></span></td>
		<td width="150">작성일 : <span id="logtimeSpan"></span></td>
		
	</tr>
	
	<tr>
	<td width="150" colspan="2">이메일 : <span id="emailSpan"></span></td>
	</tr>
	
	<tr>
	<td width="150" colspan="2" >홈페이지 : <span id="homepageSpan"></span></td>
	</tr>
	
	
	
	<tr>
	<td width="150" colspan="2">제목 : <span id="subjectSpan"></span></td>
	</tr>
	
	
	
	
	<tr>
		<!-- valign="top, middle(center), bottom" -->
		<td colspan="3" height="100" valign="top">
			<pre style="white-space: pre-line; word-break: break-all;">
				<span id="contentSpan"></span>
			</pre>
		</td>
	</tr>
</table>

<input type="button" value="목록"
onclick="location.href='/SpringProject/guestbook/guestbookList?pg=1'">


<span id="guestbookViewSpan">
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
		url: '/SpringProject/guestbook/getGuestbookView',
		data: 'seq='+ $('#seq').val(),
		dataType: 'json',
		success: function(data){
			//alert(JSON.stringify(data));
			
			$('#nameSpan').text(data.guestbookDTO.name);
			$('#logtimeSpan').text(data.guestbookDTO.logtime);
			$('#emailSpan').text(data.guestbookDTO.email);
			$('#homepageSpan').text(data.guestbookDTO.homepage);
			$('#contentSpan').text(data.guestbookDTO.content);
			
			if(data.memName == data.guestbookDTO.name)
				$('#guestbookViewSpan').show();
			else
				$('#guestbookViewSpan').hide();
			
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
		document.getElementById("guestbookViewForm").method = 'post';
		document.getElementById("guestbookViewForm").action = '/SpringProject/guestbook/guestbookModifyForm';
		document.getElementById("guestbookViewForm").submit();
		
	}else if(num==2){ //글삭제, seq
		document.getElementById("guestbookViewForm").method = 'post';
		document.getElementById("guestbookViewForm").action = '/SpringProject/guestbook/guestbookDelete';
		document.getElementById("guestbookViewForm").submit();
	
	}else if(num==3){ //답글, seq(원글번호), pg(원글이 있는 페이지 번호)
		document.getElementById("guestbookViewForm").method = 'post';
		document.getElementById("guestbookViewForm").action = '/SpringProject/guestbook/guestbookReplyForm';
		document.getElementById("guestbookViewForm").submit();
	}
}
</script>


