<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style type="text/css">
#imageboardListTable th {
	font-size: 16px;
}

#imageboardListTable td {
	font-size: 13px;
}

#imageboardListTable {
	border-color: black;
	margin-left: 10pt;
}

#currentPaging {
	color: red;
	text-decoration: underline;
	cursor: pointer;
}

#paging {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.imageNameA:link {
	color: black;
	text-decoration: none;
}

.imageNameA:visited {
	color: black;
	text-decoration: none;
}

.imageNameA:hover {
	color: red;
	text-decoration: underline;
}

.imageNameA:active {
	color: red;
	text-decoration: none;
}
</style>

<form id="imageboardListForm" method=""
	action="/SpringProject/imageboard/imageboardDelete">
	<input type="hidden" id="pg" value="${pg}">
	
	<table id="imageboardListTable" border="1" cellspacing="0"
		cellpadding="5" frame="hsides" rules="rows">
		<tr>
			<th width="100">
			<input type="checkbox" id="all" >글번호</th>
			<th width="100">이미지</th>
			<th width="150">상품명</th>
			<th width="150">단가</th>
			<th width="100">개수</th>
			<th width="150">합계</th>
		</tr>

	</table>

	<input id="imageboardDeleteBtn" type="button" value="선택삭제"
		style="float: left; margin: 5px 10px;">

	<div id="imageboardPagingDiv" style="text-align: center; width: 750px; font-size: 11pt;"></div>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
function imageboardPaging(pg2){
	//pg2는 2페이지로 가라는뜻이 아니라 이름 정해준것!
	
	location.href='/SpringProject/imageboard/imageboardList?pg=' +pg2; //쿼리스트링
}

</script>

<script type="text/javascript">
	//이파일을 열자마자 DB가서 데이터 처리를 하는것이 onload 함수
	$(function() {
		$.ajax({
			type : 'post',
			url : '/SpringProject/imageboard/getimageboardList',
			data : 'pg=' + $('#pg').val(), // input type의 hidden으로 넘어오는 값
		//	data:'pg=${pg}', //컨트롤러로부터 넘어오는 값
			dataType : 'json',
			success : function(data) {
				console.log(data);

				$.each(data.list, function(index, items) {
					//tr안에 td 6개 잡힌다.
					$('<tr/>').append($('<td/>', {
						align : 'center',
						text : items.seq
					//append는 자식이므로 내 뒤에 붙지만 prepend는 내seq 앞에 붙는다.
					}).prepend($('<input/>', {
						type : 'checkbox',
						name: 'check',
						value: items.seq
					}))

					).append($('<td/>', {

						align : 'center',
					}).append($('<img/>', {
						//servlet-context에 경로 알려줘야 서블릿으로 안간다.
						//실제폴더위치로 가면 안되고 무조건 가상폴더로 가줘야 한다.
						//실제폴더로가려면 주소창에 C://~~~ 가 입력되야하는데 입력불가
						//사실 가상폴더란거 자체가 사용자가 편하게 써먹으라고 만들어둔거라 톰켓은 사실 실제폴더밖에 못읽음
						src : '/SpringProject/storage/' + items.image1,
						style : 'width:70px; height:70px; cursor:pointer;',
						
						//class:'img_'+items.seq  //이미지 클릭 했을 때 - 첫번째
						  class: 'img'			  //이미지 클릭 했을 때 - 두번째
					}))

					).append($('<td/>', {
						align : 'center',
						text : items.imageName

					})).append($('<td/>', {
						align : 'center',
						text : items.imagePrice.toLocaleString()  //toLocalString()써주면 자동 콤마(,)붙여준다

					})).append($('<td/>', {
						align : 'center',
						text : items.imageQty

					})).append(
							$('<td/>', {
								align : 'center',
								text : (items.imagePrice * items.imageQty)
										.toLocaleString()

							})).appendTo($('#imageboardListTable'));
					
					//이미지 클릭 했을 때 - 첫번째
					$('.img_'+items.seq).click(function(){
						
						alert('번호 ='+items.seq);
						location.href ='/SpringProject/imageboard/imageboardView?seq='+items.seq+'&pg='+$('#pg').val();
						
					});
					
					
				}); //$.each
					
					//이미지 클릭 했을 때 - 두번째 
					$('.img').click(function(){
						//alert($(this).parent().prev().prop('tagName'));
						//this는 클릭한 애의 정보값을 가지고온다 (태그를 가지고옴)
						//alert($(this).parent().prev().text()); alert으로 확인만 해본것.
						
						var seq = $(this).parent().prev().text();
						location.href ='/SpringProject/imageboard/imageboardView?seq='+seq+'&pg='+$('#pg').val();
						//seq와 pg값 가지고 가야한다.
						 
						
						
						
					});
				
				//페이징 처리
				$('#imageboardPagingDiv').html(data.imageboardPaging.pagingHTML);
				//pagingHTML은 버퍼에보관중이라 꺼내서 사용
					
			},
			error : function(err) {
				console.log(err);
			}

		}); //$.ajax

	});
	
	//전체선택 또는 해제
	$('#all').click(function(){
		//alert($('#all').attr('checked')) //cheked라는 속성이 없어서 undefind으로 나온다.문자열로 반환되기 때문
		//alert($('#all').prop('checked')) //true 또는 false 꺼내온다.
		if($('#all').prop('checked')){
			$('input[name=check]').prop('checked', true); //체크하는것
			
		}else{
			$('input[name=check]').prop('checked', false); //체크해제하는것.
			
		}
		
	});
	
	
	//선택삭제
	
	$('#imageboardDeleteBtn').click(function(){
		var count =$('input[name=check]:checked').length; 	//checked된 개수를 구하기
	
		if(count ==0)
			Swal.fire({
				  icon: 'warning',
				  title: '삭제할 항목을 선택해주세요!!',
				  
				});
		else
			if(confirm('정말로 삭제하시겠습니까?'))
		       $('#imageboardListForm').submit();
		
		
	/*	
		Swal.fire({
			  title: 'Are you sure?',
			  text: "You won't be able to revert this!",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes, delete it!'
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire(
			      'Deleted!',
			      'Your file has been deleted.',
			      'success'
			    )
			  }
			})
		
		
		*/
		
		
		//submit누르면 action타고 서블릿으로 가는데 우리가 선택한 항목만 넘어간다.
		//check의 값이 넘어가는데 우리가 몇개를 선택하던 넘어가기 때문에
		//check[]의 배열로 controller에서 받게 된다.
		
		
		
	});
	</script>
		<%--
		attr()
		-HTML에 작성된 속성값을 "문자열"로 가져온다.
		
		prop()
		-자바스크립트의 프로퍼티를 가져온다.
		-자바스크립트의 프로퍼티 값이 넘어오므로 boolean, date,function등을 가져올 수 있다.
		
		[형식]
		prop(key)           -->속성값을 가져온다
		prop(key,value)     -->속성값을 추가한다.
		--%>
	