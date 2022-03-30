//목록

$(function(){
	$.ajax({
		type: 'post',
		url: '/SpringProject/board/getBoardList',
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
							class: 'subjectA   subjectA_' + items.seq 
						}))
					
					).append($('<td/>',{
						align: 'center',
						text: items.id
					})).append($('<td/>',{
						align: 'center',
						text: items.logtime
					})).append($('<td/>',{
						align: 'center',
						text: items.hit
					})).appendTo($('#boardListTable'));
					
					//답글
					for(i=0; i<items.lev; i++){
						$('.subjectA_'+items.seq).before('&emsp;');
					}
					if(items.pseq != 0){
						$('.subjectA_'+items.seq).before($('<img/>',{
							src: '/SpringProject/image/reply.gif'
						}));
					}
					 
			});//each
			
			//로그인 여부
			$('.subjectA').click(function(){
				//alert(data.memId);
				
				//alert(this.tagName); //A
				//alert($(this).parent().prev().text()); //seq가져온다		
				
				var seq = $(this).parent().prev().text();
					
				if(data.memId == null){
					Swal.fire({
			  icon: 'warning',
			  title: '먼저 로그인을 해주세요!',
			})
				}else{
						//이렇게 location으로 링크달고 넘어가는것은 무조건 get방식
					location.href='/SpringProject/board/boardView?seq='+seq+'&pg='+$('#pg').val();
				}     //글보기를 누르면 글번호와 현재 페이지번호 가지고 가야 한다..
					//그 글을 보고 다시 그 페이지로 돌아와야 하기 때문에 
				
			});
			
			//페이징 처리
			$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
			
			   //boardpaging에서 StringBuffer에 담아주었고
			   //controller에서 boardpaging만 보냈기 때문에 메소드으로 꺼내서 적어줘야 한다.
		},
		error:  function(err){
			alert(err);
		}
	});
	

});

//검색
$('#boardSearchBtn').click(function(){

if($('#keyword').val()=='') 


Swal.fire({
			  icon: 'warning',
			  title: '검색어를 입력해주세요!',
			})
 
else  //내용이 있을때
$('#key').val($('#keyword').val());

$.ajax({
type:'post',
url:'/SpringProject/board/getBoardSearchList',
data: $('#boardSearchForm').serialize(),
				//pg(id=searchPg), searchOption(제목,작성자), keyword,  보내줘야 한다.
				//검색버튼을 누를 때마다 1페이지라는 것을 알려줘야한다.(1페이지로 돌아가야 하니까)

dataType:'json',

success: function(data){
			console.log(JSON.stringify(data));
			
			$('#boardListTable tr:gt(0)').remove();
			//0번째 행보다 큰 행은 지워라 (0번째 행이 목록이름이니까)
			$.each(data.list, function(index, items){
				$('<tr/>')
					.append($('<td/>',{
						align: 'center',
						text: items.seq
					})).append($('<td/>',{
									
						}).append($('<a/>',{
							href: '#',
							text: items.subject,
							class: 'subjectA   subjectA_' + items.seq 
						}))
					
					).append($('<td/>',{
						align: 'center',
						text: items.id
					})).append($('<td/>',{
						align: 'center',
						text: items.logtime
					})).append($('<td/>',{
						align: 'center',
						text: items.hit
					})).appendTo($('#boardListTable'));
					
					//답글
					for(i=0; i<items.lev; i++){
						$('.subjectA_'+items.seq).before('&emsp;');
					}
					if(items.pseq != 0){
						$('.subjectA_'+items.seq).before($('<img/>',{
							src: '/SpringProject/image/reply.gif'
						}));
					}
					 
			});//each
			
			//페이징 처리
			$('#boardPagingDiv').html(data.boardPaging.pagingHTML);
			
},

error:  function(err){
			alert(err);
		}



});


});


