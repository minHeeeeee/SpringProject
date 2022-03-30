package member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.bean.MemberDTO;
import member.service.MemberService;


@Controller
@RequestMapping(value="member")
public class MemberController {

		@Autowired 
		private MemberService memberService;

		
		@PostMapping(value="login")
		@ResponseBody
		public String login(@RequestParam Map<String,String> map) {
			return memberService.login(map);
			
		}
		@PostMapping(value="logout")
		@ResponseBody
		public void logout() {
			memberService.logout();
		}
		
		@GetMapping(value="writeForm")
		public String writeForm(Model model) { //스프링 컨테이너가 값을 주입
			model.addAttribute("display","/member/writeForm.jsp"); //얘는 resolver가 jsp를 따로 붙여주지 않기 때문에
	                                                                  //뒤에 적어줘야 한다.
			return "/index";
		}
		
		@PostMapping(value="write")
		@ResponseBody
		public void write(@ModelAttribute MemberDTO memberDTO) {
			memberService.write(memberDTO);
			
			
		}
		
		@PostMapping(value="checkId")
		@ResponseBody
		public String checkId(@RequestParam String id) {
			return memberService.checkId(id);  //이렇게하면 exist, non_exist가 들어오게 된다.
		}
		
		@GetMapping(value="modifyForm")
		public String modifyForm(HttpSession session , Model model) { 
			String id = (String) session.getAttribute("memId");
			//session 값 얻어서 modify form에 수정할 id의 정보를 뿌려주자.
			//한사람의 정보를 가져오는것이기 때문에 DTO에 담아주자.
			MemberDTO memberDTO = memberService.getMember(id);
			
			model.addAttribute("memberDTO",memberDTO); 
			model.addAttribute("display","/member/modifyForm.jsp"); 
	                                                                  
			return "/index";
			
			
		}
		
		@PostMapping(value="modify")
		@ResponseBody
		public void modify(@ModelAttribute MemberDTO memberDTO) {
			memberService.modify(memberDTO);
			
			
		}
		
		@GetMapping(value="quitForm")
		public String quitForm(HttpSession session , Model model) { 
			String id = (String) session.getAttribute("memId");
	
			model.addAttribute("display","/member/quitForm.jsp"); 
	                                                                  
			return "/index";
			
			
		}
		
		@PostMapping(value="quit")
		@ResponseBody
		public void quit(@ModelAttribute MemberDTO memberDTO) {
			
			memberService.quit(memberDTO);
			
			
		}

		
	@PostMapping(value="pwCheck")
		@ResponseBody
	public String pwCheck(@ModelAttribute MemberDTO memberDTO) {
		
			return memberService.pwCheck(memberDTO);
		}
		
		
}	

