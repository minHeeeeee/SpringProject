package guestbook.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import guestbook.bean.GuestbookDTO;
import guestbook.bean.GuestbookPaging;
import guestbook.service.GuestbookService;

@Controller
@RequestMapping(value="guestbook")
public class GuestbookController {
	@Autowired
	private GuestbookService guestbookSercive;
	
	
	@GetMapping(value="guestbookWriteForm")
	public String guestbookWriteForm(Model model) {
		model.addAttribute("display","/guestbook/guestbookWriteForm.jsp");
		
		return "/index"; 
	}

	@PostMapping(value="guestbookWrite")
	@ResponseBody
	public void guestbookWrite(@RequestParam Map<String, String> map) {
		System.out.println(map);
		guestbookSercive.guestbookWrite(map);
	}
	
	@GetMapping(value="guestbookList")
	public String guestbookList(@RequestParam(required = false, defaultValue = "1") String pg, Model model){
		model.addAttribute("pg", pg);
		model.addAttribute("display", "/guestbook/guestbookList.jsp");
		return "/index";
	}
	
	@PostMapping(value="getGuestbookList")
	@ResponseBody
	public ModelAndView getGuestbookList(@RequestParam(required=false, defaultValue="1") String pg,
									 HttpSession session,
									 HttpServletResponse response){
		
		//guestbookList.jsp에서 pg값을 넘기는데 파라미터에 pg값이 넘어오지 않아도 상관없다는 뜻이
		//required=false 
		//만약 아무데이터도 넘어오지 않는다면 자동으로 부여되는 값이 1로 지정해라는 뜻이 defaultValue="1"
		
		//1페이지당 5개씩
		List<GuestbookDTO> list = guestbookSercive.getGuestbookList(pg);
		
		//세션
		String memId = (String) session.getAttribute("memId");
		
		//페이징 처리
		GuestbookPaging guestbookPaging = guestbookSercive.guestbookPaging(pg);
		
	
		ModelAndView mav = new ModelAndView();
		mav.addObject("memId", memId);
		mav.addObject("list",  list);
		mav.addObject("guestbookPaging", guestbookPaging);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@GetMapping(value="guestbookView")
	public String guestbookView(@RequestParam Map<String,String> map,Model model) {
		model.addAttribute("map",map);
		model.addAttribute("display","/guestbook/guestbookView.jsp");
		return "/index";
		
	}
	
	@PostMapping(value="getGuestbookView")
	@ResponseBody
	
	public ModelAndView getGuestbookView(@RequestParam String seq,
										HttpSession session,
										HttpServletResponse response) {
						
		
		GuestbookDTO guestbookDTO = guestbookSercive.getGuestbookView(seq);
	//세션
	String memName=(String) session.getAttribute("memName");
	
	ModelAndView mav = new ModelAndView();
	mav.addObject("guestbookDTO",guestbookDTO);
	mav.addObject("memName", memName);
	mav.setViewName("jsonView");
	
	return mav;
	
	
}
	
	@PostMapping(value="guestbookDelete")
	public ModelAndView guestbookDelete(@RequestParam String seq) {
		
		guestbookSercive.guestbookDelete(seq);
		
		//넘겨줄 view 페이지 없으므로 바로 객체생성해서
		//redirect로 넘긴다.
		return new ModelAndView("redirect:/guestbook/guestbookList");
	}

	@PostMapping(value="guestbookModifyForm")
	public String guestbookModifyForm(@RequestParam String seq, @RequestParam String pg, Model model) {
		model.addAttribute("seq",seq);
		model.addAttribute("pg",pg);
		model.addAttribute("display","/guestbook/guestbookModifyForm.jsp");
		return "/index";
	}
	
	@PostMapping(value="guestbookModify")
	@ResponseBody	
	public void guestbookModify(@RequestParam Map<String, String> map ) {
		guestbookSercive.guestbookModify(map);
	}
	
}
