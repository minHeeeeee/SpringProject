package board.bean;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class BoardPaging {
	private int currentPage;
	private int pageBlock; // [1][2][3] [다음] 이런 블럭만 만들어주는 것
	private int pageSize; //1페이지당 5개씩
	private int totalA; //총글수
	private StringBuffer pagingHTML; //실제 현재 내가 몇 페이지에 있느냐에 따라 [이전] [1][2] 이거 처리하는 역할
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		int totalP = (totalA + pageSize-1) / pageSize;//총 페이지 수
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1; //1 4 7 
		
		int endPage = startPage + pageBlock - 1;//9
		if(endPage > totalP) endPage = totalP;
			
		if(startPage > pageBlock)
			pagingHTML.append("<span id=paging onclick=boardPaging(" + (startPage-1) + ")>이전</span>");
				
		for(int i=startPage; i<=endPage; i++) {
			if(i == currentPage)
				pagingHTML.append("<span id=currentPaging onclick=boardPaging(" + i + ")>" + i + "</span>");
			else
				pagingHTML.append("<span id=paging onclick=boardPaging(" + i + ")>" + i + "</span>");
		}
		
		if(endPage < totalP)
			pagingHTML.append("<span id=paging onclick=boardPaging(" + (endPage+1) + ")>다음</span>");
		
	}

}





















