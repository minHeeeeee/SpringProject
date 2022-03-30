package imageboard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import imageboard.bean.ImageboardDTO;
import imageboard.bean.ImageboardPaging;
import imageboard.dao.ImageboardDAO;

@Service
public class ImageboardServiceImpl implements ImageboardService {
  @Autowired
	private ImageboardDAO imageboardDAO;
  @Autowired
  private ImageboardPaging imageboardPaging;

@Override
public void imageboardWrite(ImageboardDTO imageboardDTO) {
imageboardDAO.imageboardWrite(imageboardDTO);
	
}

@Override
public List<ImageboardDTO> getimageboardList(String pg) {
	//한페이지당 3개씩 꺼내주자
	int endNum = Integer.parseInt(pg)* 3;
	int startNum = endNum-2;
	
	Map<String ,Integer>map = new HashMap<String ,Integer>();
	map.put("startNum", startNum);
	map.put("endNum", endNum);
	
	return imageboardDAO.getimageboardList(map);
}

@Override
public ImageboardPaging imageboardPaging(String pg) {
	
	int totalA = imageboardDAO.getTotalA();  //총글수
	imageboardPaging.setCurrentPage(Integer.parseInt(pg));
	imageboardPaging.setPageBlock(3);
	imageboardPaging.setPageSize(3);
	imageboardPaging.setTotalA(totalA);
	imageboardPaging.makePagingHTML();
	
	
	return imageboardPaging;
}

@Override
public ImageboardDTO getImageboardView(String seq) {
	
	return imageboardDAO.getImageboardView(seq);
}

@Override //배열로 보내면 안되고 map으로 묶어서 보내줘야 DB에서 처리 가능하다.
public void imageboardDelete(String[] check) {
	
	Map<String,String[]> map = new HashMap<String,String[]>();
	map.put("check",check); 
	
	//배열이 map에 실린상태.
	imageboardDAO.imageboardDelete(map);
	
}



	
}
