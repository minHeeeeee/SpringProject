package member.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.bean.MemberDTO;
import member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private HttpSession session;

	@Override
	public String login(Map<String, String> map) {
		//DB
		MemberDTO memberDTO = memberDAO.login(map);
		
		if(memberDTO == null) {
			return "fail";
			
		}else {
			//세션
			session.setAttribute("memName", memberDTO.getName());
			session.setAttribute("memId", memberDTO.getId());
			session.setAttribute("memEmail", memberDTO.getEmail1()+"@"+memberDTO.getEmail2());
			
			return "ok";
		}
	}

	@Override
	public void logout() {
		session.invalidate(); //무효화
	}

	@Override
	public String checkId(String id) {
		//DB
		MemberDTO memberDTO= memberDAO.checkId(id);
		
		if(memberDTO == null)
		return "non_exist"; //사용가능
		else
			return "exist"; //사용불가능
	}

	@Override
	public void write(MemberDTO memberDTO) {
		memberDAO.write(memberDTO);
		
	}

	@Override
	public MemberDTO getMember(String id) {
		
		return memberDAO.getMember(id)	;
	}

	@Override
	public void modify(MemberDTO memberDTO) {
		
		memberDAO.modify(memberDTO);
	}

	@Override
	public void quit(MemberDTO memberDTO) {
		memberDAO.quit(memberDTO);
		session.invalidate();
		
	}


	@Override
	public String pwCheck(MemberDTO memberDTO) {
	
		String id = memberDTO.getId();
		String quitPwd = memberDAO.pwCheck(id);
	
		if(memberDTO.getPwd().equals(quitPwd)) {
	
				return "ok";
				
			}else {
		
			return "no";
		}
	
	}
}




