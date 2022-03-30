package imageboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import imageboard.bean.ImageboardDTO;

@Repository 
@Transactional //안써도 되지만 써주는게 좋다.
public class ImageboardDAOMybatis implements ImageboardDAO {
@Autowired
	private SqlSession sqlSession;

	@Override
	public void imageboardWrite(ImageboardDTO imageboardDTO) {
sqlSession.insert("imageboardSQL.imageboardWrite",imageboardDTO);
		
	}

	@Override
	public List<ImageboardDTO> getimageboardList(Map<String, Integer> map) {
		return sqlSession.selectList("imageboardSQL.getimageboardList",map);
		
	}

	@Override
	public ImageboardDTO getImageboardView(String seq) {
		
		return sqlSession.selectOne("imageboardSQL.getImageboardView",Integer.parseInt(seq));
	}

	@Override
	public int getTotalA() {

		return sqlSession.selectOne("imageboardSQL.getTotalA");
	}

	@Override
	public void imageboardDelete(Map<String, String[]> map) {
      sqlSession.delete("imageboardSQL.imageboardDelete2",map);
      //mapper에 delete와 delete2가 있는데 우리는 delete2로 가야한다.
		
	}

}
