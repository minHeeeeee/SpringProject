<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style type="text/css">
#guestbookListTable th {
	font-size: 16px;
}

#guestbookListTable td {
	font-size: 13px;
}

#guestbookListTable {
	border-color: black;
	margin-left: 10pt;
}

.subjectA:link{ color: black; text-decoration: none; }
.subjectA:visited{ color: black; text-decoration: none;}
.subjectA:hover{ color: red; text-decoration: underline;}
.subjectA:active{ color: black; text-decoration: none;}

#guestbookPagingDiv{
	text-align: center;
	font-size: 13pt;
	margin-top: 20px;
}

#guestbookPagingDiv span {
	margin: 0 5px;
	padding: 10px;
	border: 1px white solid;
} 

#currentPaging {
	color:black;
	cursor: pointer;
}

#paging {
	color: black;
	cursor: pointer;
}
</style>


<div id="guestbookPagingDiv"></div>

<input type="hidden" id="pg" value="${pg }"> <!-- 이거 모르겠으면 text로 바꿔서 확인해보자 -->



<table id="guestbookListTable" border="1" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">
	<tr>
		<th width="100">방명록번호</th>
		<th width="300">제목</th>
		<th width="100">이름</th>
		<th width="100">이메일</th>
		<th width="100">작성일</th>
	</tr>
	
</table>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(function(){
	$.ajax({
		type: 'post',
		url: '/SpringProject/guestbook/getGuestbookList',
		data: 'pg='+ $('#pg').val(),
		dataType: 'json',
		success: function(data){
			console.log(JSON.stringify(data));
						
			$.each(data.list, function(index, items){
				$('<tr/>')
					.append($('<td/>',{
						align: 'center',
						text: items.seq
					})).append($('<td/>',{
									
						}).append($('<a/>',{
							href: '#',
							text: items.subject,
							class: 'subjectA subjectA_' + items.seq 
						}))
					
					).append($('<td/>',{
						align: 'center',
						text: items.name
					})).append($('<td/>',{
						align: 'center',
						text: items.email
					})).append($('<td/>',{
						align: 'center',
						text: items.logtime
					})).appendTo($('#guestbookListTable'));
					 
			});//each
			
			//로그인 여부
			$('.subjectA').click(function(){
				//alert(data.memId);
				
				//alert(this.tagName); //A
				//alert($(this).parent().prev().text()); //seq가져온다		
				
				var seq = $(this).parent().prev().text();
					
				if(data.memId == null){
					alert('먼저 로그인하세요');
				}else{
					
					//이렇게 location으로 링크달고 넘어가는것은 무조건 get방식
					location.href='/SpringProject/guestbook/guestbookView?seq='+seq+'&pg='+$('#pg').val();
					//글보기를 누르면 글번호와 현재 페이지번호 가지고 가야 한다..
					//그 글을 보고 다시 그 페이지로 돌아와야 하기 때문에 
				}
				/* var table = '';
	              $.each(data.list, function(index, items){
	                 
	                 table += '<table border="1" cellspacing="0" cellpadding="5">
	                 <TR>
	                 	<TD>' + '작성자' + '</TD>
	                 	<TD>' + items.name + '</TD>
	                 	<TD>'+ '작성일'+ '</TD>
	                 	<TD>'+ items.logtime + '</TD>
	                 </TR>
	                 <TR>
	               		  <TD>'+  '이메일' + '</TD>
	               		  <TD colspan="3">'+ items.email + '</TD>
	               	 </TR>
	               	 <TR>
	               	 	<TD>'+ '홈페이지' + '</TD>
	               	 	<TD colspan="3">'+  items.homePage + '</TD>
	               	 </TR>
	               	 <TR>
	               	 	<TD>'+ '제목' + '</TD>
	               	 	<TD colspan="3">'+ items.subject + '</TD>
	               	 </TR>
	               	 <TR>
	               	 	<TD>'+ '내용' + '</TD>
	               	 	<TD width="500px" height="70px" colspan="3">'+ items.content + '</TD>
	               	 </TR>
	               	 </table><br>';
	                
	                });  //each문  
	                
				  $('#guestbookTable').append(table);
				*/

			});
			
			//페이징 처리
			$('#guestbookPagingDiv').html(data.guestbookPaging.pagingHTML);
			
		},
		error:  function(err){
			alert(err);
		}
	});
	

});
	
function guestbookPaging(pg2){
	location.href = '/SpringProject/guestbook/guestbookList?pg='+pg2;
}

</script>

					