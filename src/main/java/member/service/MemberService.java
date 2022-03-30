package member.service;

import java.util.Map;

import member.bean.MemberDTO;

public interface MemberService {

	public String login(Map<String, String> map);

	public void logout();

	public String checkId(String id);

	public void write(MemberDTO memberDTO);

	public MemberDTO getMember(String id);

	public void modify(MemberDTO memberDTO);

	public void quit(MemberDTO memberDTO);

	public String pwCheck(MemberDTO memberDTO);



}
