package board.service;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import board.bean.BoardPaging;

public interface BoardService {

	public void boardWrite(Map<String, String> map);

	public List<BoardDTO> getBoardList(String pg);
	//public Map<String, Object> getBoardList(String pg);

	public BoardPaging boardPaging(String pg);

	public BoardDTO getBoardView(String seq);

	public void boardModify(Map<String, String> map);

	public void boardDelete(String seq);

	public void boardReply(Map<String, String> map);

	public void boardHit(String seq);

	public List<BoardDTO> getBoardSearchList(Map<String, String> map);

	public BoardPaging boardPaging(Map<String, String> map);



}
