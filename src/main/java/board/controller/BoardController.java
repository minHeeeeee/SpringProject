
package board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.service.BoardService;

@Controller
@RequestMapping(value="board")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@GetMapping(value="boardWriteForm")
	public String boardWriteForm(Model model) {
		//원글 -1페이지, 첫번째 줄 
		model.addAttribute("display", "/board/boardWriteForm.jsp");
		return "/index";
	}
	
	@PostMapping(value="boardWrite")
	@ResponseBody
	public void boardWrite(@RequestParam Map<String, String> map) { //subject,content
		boardService.boardWrite(map); //원글 - 1페이지, 첫번째 줄
	}
	
	@GetMapping(value="boardList")
	public String boardList(@RequestParam(required = false, defaultValue = "1") String pg, Model model){
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/board/boardList.jsp");
		return "/index";
	}
	
	@PostMapping(value="getBoardList")
	@ResponseBody
	public ModelAndView getBoardList(@RequestParam(required=false, defaultValue="1") String pg,
									 HttpSession session,
									 HttpServletResponse response){
		
		//1페이지당 5개씩
		List<BoardDTO> list = boardService.getBoardList(pg);
		
		//세션 
		String memId = (String) session.getAttribute("memId"); //목록은 session값이 있던없던 무조건 뜨지만
		                                                       //글 보기(boardview)에서는 session 필요
		
		//페이징 처리
		BoardPaging boardPaging = boardService.boardPaging(pg);
		
		//조회수 
		if(memId != null) {//null이 아니여야 새로고침할 때 막을 수 있음(세션값이 있으면)
			
			Cookie cookie = new Cookie("memHit","0"); //쿠키를 생성
			cookie.setMaxAge(30*60);//기본이 초단위  30분동안 살아있으라는뜻 60=1분
			//클라이언트에게 보내기
			response.addCookie(cookie); //클라이언트에게 보내자
			
			
		
		}//모델앤뷰는 view쪽으로 가는거기 때문에 응답쪽에 가깝다.
		ModelAndView mav = new ModelAndView();
		mav.addObject("memId", memId);
		mav.addObject("list",  list);
		mav.addObject("boardPaging", boardPaging); //jsp로 갈 수있게 페이징 같이 실어주자
		mav.setViewName("jsonView"); //이 이름의 bean을 찾아라.jsp로 가지말고 <bean id="jsonView">
		
		return mav;
	}
	
	/*
	@PostMapping(value = "getBoardList")
	@ResponseBody
	public Map<String,Object> getBoardList(@RequestParam(required=false, defaultValue = "1") String pg){
		return boardService.getBoardList(pg);
	}
	*/

	@GetMapping(value="boardView")
	//글보기를 누르면 무조건 현재 pg값과 seq값 가지고 가야한다.
		//그 글을 보고 목록 누르면 현재 페이지로 돌아와야 하기 떄문 
	public String boardView(@RequestParam Map<String , String> map,Model model) {
		model.addAttribute("map",map);
		model.addAttribute("display","/board/boardView.jsp");
		return "/index";
		
	}
	
	@PostMapping(value="getBoardView")
	@ResponseBody
	public ModelAndView getBoardView(@RequestParam String seq,
									HttpSession session,
									@CookieValue(name="memHit",required=false)Cookie cookie,
									 HttpServletResponse response) {
		
		//한사람의 글만 보이면 되기 때문에 DTO로 담아줘도 된다(원래는)
		//근데 sesssion 값이 필요하기 때문에 ModelAndView에 담아서 같이 보내줘야 한다.
		
		//조회수
		if(cookie!=null) { //쿠키값이 없으면 아무 의미 없으므로
			boardService.boardHit(seq); //조회수 증가.
			
			cookie.setMaxAge(0); //쿠키 삭제
			//그 상태에서 새로고침해도 조회수 안오르게 하기위해 쿠키 값 삭제
			response.addCookie(cookie); //클라이언트에게 보내자
		}
		
		BoardDTO boardDTO = boardService.getBoardView(seq);
		//세션
		String memId = (String) session.getAttribute("memId");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardDTO",boardDTO);  //DTO
		mav.addObject("memId", memId);       //session
		mav.setViewName("jsonView");         //resolver타고 넘어가라
		
		return mav;
		
		
	}
	
	
	@PostMapping(value="boardModifyForm")
	public String boardModifyForm(@RequestParam String seq,@RequestParam String pg,Model model ) {
		model.addAttribute("seq",seq);
		model.addAttribute("pg",pg);
		model.addAttribute("display","/board/boardModifyForm.jsp");
		return "/index";
	}
	
	@PostMapping(value="boardModify")
	@ResponseBody
	public void boardModify(@RequestParam Map<String , String> map) {
		boardService.boardModify(map);
	}
	
	@PostMapping(value="boardDelete")
	public ModelAndView boardDelete(@RequestParam String seq) {
		boardService.boardDelete(seq);
		
		//jsp로 alert창 띄우지 않고 바로 삭제후 목록으로 가게하려면 이렇게 해도 된다.
		//?pg=1 이라는 값 싣지 않아도 기본 default 값이 1이기 때문에 알아서 1페이지로 간다.
		return new ModelAndView("redirect:/board/boardList");//sendredirect와 같음
	}
	
	@PostMapping(value="boardReplyForm")
	public String boardReplyForm(@RequestParam String seq,
			                     @RequestParam String pg,
			                       Model model) {
		//답글 -원글페이지의 원글밑에 들어거야 한다.
		model.addAttribute("pseq",seq); //원글번호로 취급받아라.
		model.addAttribute("pg",pg); //원글이 있는 페이지 번호
		model.addAttribute("display", "/board/boardReplyForm.jsp");
		return "/index";
	}
	
	@PostMapping(value="boardReply")
	@ResponseBody
	public void boardReply(@RequestParam Map<String, String> map) { //pseq, subject, content
		boardService.boardReply(map); //원글이 있는페이지, 원글 밑으로 들어간다.
	}
	
	@PostMapping(value="getBoardSearchList")
	@ResponseBody
	public ModelAndView getBoardSearchList(@RequestParam Map<String, String> map,
			                            //pg(id=searchPg), searchOption(제목,작성자), keword
			                              HttpSession session) {
		//1페이지당 5개씩                   
		List<BoardDTO> list = boardService.getBoardSearchList(map);
		
		//세션
		String memId = (String) session.getAttribute("memId");
				
		//페이징 처리
		BoardPaging boardPaging = boardService.boardPaging(map); 
		//검색옵션 , 키워드 다 끌고 가야하니까 map이 필요 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("memId", memId);
		mav.addObject("list",  list);
		mav.addObject("boardPaging", boardPaging);
		mav.setViewName("jsonView");
		
		
		return mav;
	}
}

