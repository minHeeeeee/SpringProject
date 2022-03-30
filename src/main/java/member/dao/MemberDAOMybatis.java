package member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import member.bean.MemberDTO;

@Repository
@Transactional //자동으로 commit,colse,rollback해준다.
public class MemberDAOMybatis implements MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberDTO login(Map<String, String> map) {
		return sqlSession.selectOne("memberSQL.login",map);
		
	}

	@Override
	public MemberDTO checkId(String id) {
		return sqlSession.selectOne("memberSQL.checkId",id);
		 
	}

	@Override
	public void write(MemberDTO memberDTO) {
	sqlSession.insert("memberSQL.write",memberDTO);
		
	}

	@Override
	public MemberDTO getMember(String id) {
	
		return sqlSession.selectOne("memberSQL.getMember",id);
	}

	@Override
	public void modify(MemberDTO memberDTO) {
		sqlSession.update("memberSQL.modify",memberDTO);
		
	}

	@Override
	public void quit(MemberDTO memberDTO) {
	sqlSession.delete("memberSQL.quit",memberDTO);
		
	}

	@Override
	public String pwCheck(String id) {
		return 	sqlSession.selectOne("memberSQL.pwCheck",id);
		
	}
	

}
