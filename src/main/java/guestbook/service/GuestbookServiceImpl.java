package guestbook.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import guestbook.bean.GuestbookDTO;
import guestbook.bean.GuestbookPaging;
import guestbook.dao.GuestbookDAO;

@Service
public class GuestbookServiceImpl implements GuestbookService {

	@Autowired
	private GuestbookDAO guestbookDAO;
	@Autowired
	private GuestbookPaging guestbookPaging;
	

	@Override
	public void guestbookWrite(Map<String, String> map) {
	
		guestbookDAO.guestbookWrite(map);
		
		

	}



	@Override
	public List<GuestbookDTO> getGuestbookList(String pg) {
	
		//DB - 1페이지당 2개씩
		int endNum = Integer.parseInt(pg) * 2;
		int startNum = endNum - 1;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		List<GuestbookDTO> list = guestbookDAO.getGuestbookList(map);
		
		return list;
	}



	@Override
	public GuestbookDTO getGuestbookView(String seq) {
		
		return guestbookDAO.getGuestbookView(seq);
	}



	@Override
	public GuestbookPaging guestbookPaging(String pg) {
		int totalA = guestbookDAO.getTotalA(); //총글수
		
		guestbookPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		guestbookPaging.setPageBlock(3);
		guestbookPaging.setPageSize(2);
		guestbookPaging.setTotalA(totalA);
		guestbookPaging.makePagingHTML();
		
		return guestbookPaging;
	}



	@Override
	public void guestbookDelete(String seq) {
		guestbookDAO.guestbookDelete(seq);
		
	}



	@Override
	public void guestbookModify(Map<String, String> map) {
		guestbookDAO.guestbookModify(map);
		
	}
		
	
}
