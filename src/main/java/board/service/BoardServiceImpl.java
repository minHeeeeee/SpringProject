package board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private HttpSession session;
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private BoardPaging boardPaging;

	@Override
	public void boardWrite(Map<String, String> map) {
		String id = (String) session.getAttribute("memId");
		String name = (String) session.getAttribute("memName");
		String email = (String) session.getAttribute("memEmail");
		
		
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		
		boardDAO.boardWrite(map);
	}

	@Override
	public List<BoardDTO> getBoardList(String pg) {	
		//DB - 1페이지당 5개씩
		int endNum = Integer.parseInt(pg) * 5;
		int startNum = endNum - 4;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		List<BoardDTO> list = boardDAO.getBoardList(map);
		
		return list;
	}
	
	/*
	@Override
	public Map<String, Object> getBoardList(String pg) {
		Map<String,Integer> map=new HashMap<String, Integer>();
		map.put("endNum", Integer.parseInt(pg)*5);
		map.put("startNum", Integer.parseInt(pg)*5-4);
		
		List<BoardDTO> list = boardDAO.getBoardList(map);
		
		String memId = (String) session.getAttribute("memId");
	      
		//페이징
		int totalA=boardDAO.getTotalA();//총글수
	      
		boardPaging.setCurrentPage(Integer.parseInt(pg));
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA);
	      
		boardPaging.makePagingHTML();
	      
		Map<String, Object> temp = new HashMap<String, Object>();
		temp.put("list", list);
		temp.put("memId", memId);
		//temp.put("boardPaging", boardPaging.getPagingHTML().toString());
		
		return temp;
	}
	*/
	
	@Override
	public BoardPaging boardPaging(String pg) {
		int totalA = boardDAO.getTotalA(); //총글수
		
		boardPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA); //총글수
		boardPaging.makePagingHTML(); //makePaging은 [이전],[다음] 이런것을 만들어내는 역할
		
		return boardPaging;
	}
	
	//boardSearchList에 있는 paging
	@Override
	public BoardPaging boardPaging(Map<String, String> map) {
		int totalA = boardDAO.getTotalSearchA(map); //검색한 총글수
		
		boardPaging.setCurrentPage(Integer.parseInt(map.get("pg")));
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA); 
		boardPaging.makePagingHTML();
		
		
		return boardPaging; //리턴하면 컨트롤러로 넘어간다. 
	}

	@Override
	public BoardDTO getBoardView(String seq) {
      //DB
		
		return boardDAO.getBoardView(seq);
	}

	@Override
	public void boardModify(Map<String, String> map) {
		boardDAO.boardModify(map);
		
	}
	
	@Override
	public void boardDelete(String seq) {
		boardDAO.boardDelete(seq);
		
	}

	@Override
	public void boardReply(Map<String, String> map) { //pseq, subject,content
		//원글
		BoardDTO boardDTO = this.getBoardView(map.get("pseq")+"");
		
		//세션
		String id = (String)session.getAttribute("memId");
		String name = (String)session.getAttribute("memName");
		String email = (String)session.getAttribute("memEmail");
		
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		map.put("ref",boardDTO.getRef()+""); //원글의 ref  답글의 ref =원글의 ref니까
		map.put("lev", boardDTO.getLev()+""); //답글의 lev = 원글의 lev + 1
		map.put("step", boardDTO.getStep()+""); //원글의 step
	
		boardDAO.boardReply(map);
		
		//**우리가 답글을 처리하기위해선 실질적으로 원글의 ref, lev, step이 필요한 
		//것이기 때문에 담아준것.

		//답글의 ref는 원글의 ref이고
		//답글의 lev는 원글의 lev+ 1이며
		//답글의 step은 원글의 step +1 이기 때문에!
		//원글의 lev와 원글의 step에는 좀 있다가 + 1 해주어야 답글의 lev, step이 된다.
		//     ->mapper에서 해줄 예정 
		
		
		//System.out.println(map);
		//{pseq=11, subject=bh, content=hh, 
		//id=als3440, name=민희, email=null@null,
		//ref=11, lev=0, step=0}
		
	}
	
	 @Override
	public void boardHit(String seq) {
		boardDAO.boardHit(seq);
		
	}

	@Override
	public List<BoardDTO> getBoardSearchList(Map<String, String> map) {
		//DB - 1페이지당 5개씩
		int endNum = Integer.parseInt(map.get("pg")) * 5;
		int startNum = endNum - 4;
		
		
		map.put("startNum", startNum+"");  //+"" 쓰면 String으로 변환
		map.put("endNum", endNum+"");
		
		List<BoardDTO> list = boardDAO.getBoardSearchList(map);
		
		return list;
			
			
	}
	
	
}
	
	
