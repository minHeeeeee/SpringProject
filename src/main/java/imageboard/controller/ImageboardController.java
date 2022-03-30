 package imageboard.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import imageboard.bean.ImageboardDTO;
import imageboard.bean.ImageboardPaging;
import imageboard.service.ImageboardService;

@Controller
@RequestMapping(value="imageboard")
public class ImageboardController {
	
	@Autowired
	private ImageboardService imageboardService;
	
	
	@GetMapping(value="imageboardWriteForm")
	public String imageboardWriteForm(Model model) { 
		model.addAttribute("display", "/imageboard/imageboardWriteForm.jsp");
		//화면에 중간부분에 채워져야 하기 때문에 
	
		return "/index"; //부르는건 index 전체
	}
	
	//1.name="img" 1개인 경우 (사진1장 업로드 할 경우)
	/*
	@PostMapping(value="imageboardWrite")
	@ResponseBody
	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
			                    @RequestParam MultipartFile img,
			                    HttpSession session) {
		
		//현재 img에는 temp라는 임시파일로 업로드가 되었기 때문에 실제파일로 복사를 해줘야 한다.
		//가상폴더에 올리기
		String filePath ="D:\\Spring\\workspace\\SpringProject\\src\\main\\webapp\\storage";
		String fileName = img.getOriginalFilename(); //실제파일의 이름을 가지고 와라 변경하지 말고
		
		File file = new File(filePath, fileName); //파일 생성
		
		//파일 복사
			try {
			FileCopyUtils.copy(img.getInputStream(), new FileOutputStream(file));
	
			} catch (IOException e) {
		
			e.printStackTrace();
		}
		//현재 DTO에 image1만 못들어가고 있기 떄문에 DTO에 파일이름으로  image1 넣어주자.
		imageboardDTO.setImage1(fileName);
		*/
		
		
		
		/*
		//실제폴더에 올리기
		//D:\Spring\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SpringProject\storage
		String filePath = session.getServletContext().getRealPath("/storage");
		String fileName = img.getOriginalFilename();
		
		File file = new File(filePath, fileName); //파일 생성
		
		try {
			img.transferTo(file);
	
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		imageboardDTO.setImage1(fileName); //img만 DTO에 못들어오고 있으니까 DTO에 넣어주자 
		//DTO에서는 img가 image1 으로 되어 있다.
		
		//DB
		imageboardService.imageboardWrite(imageboardDTO);
		
	}
	*/
		
		
	/*
	
		
	//2. name="img" 2개 이상인 경우
		@PostMapping(value="imageboardWrite")
		@ResponseBody
		public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
				                    @RequestParam MultipartFile[] img,
				                    HttpSession session) {
			
			//실제폴더에 올리기
		
			String filePath = session.getServletContext().getRealPath("/storage");
			String fileName;
			
			File file ;
			
			//image[0] 번째 배열
			if(img[0]!= null) { //사진이 들어왔다면
				fileName=img[0].getOriginalFilename();
				file = new File(filePath, fileName);
				
				try {
				img[0].transferTo(file);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
				//이안에 데이터가 들어와야 DB로 넘어간다.
				imageboardDTO.setImage1(fileName);
				
				
				
			}else { 
				imageboardDTO.setImage1("");
				
			}
			
			
			//image[1] 번째 배열
			if(img[1]!= null) { //사진이 들어왔다면
				fileName=img[1].getOriginalFilename();
				file = new File(filePath, fileName);
				
				try {
				img[1].transferTo(file);
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//이안에 데이터가 들어와야 DB로 넘어간다.
				imageboardDTO.setImage2(fileName);
				
				
				
			}else { 
				imageboardDTO.setImage2("");
				
			}
			//DB
			imageboardService.imageboardWrite(imageboardDTO);
			
		
		}
		
		*/
	
	//3.한번에 여러개의 파일을 선택했을 때
	
	@PostMapping(value="imageboardWrite")
	@ResponseBody
	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
			                    @RequestParam("img[]")List<MultipartFile> list, //list의형태로 여러개의 파일 들어오게
			                    HttpSession session) {
		
		//실제폴더에 올리기
		
		String filePath = session.getServletContext().getRealPath("/storage");
		String fileName;
		File file ;
		
		//list에 들어온 파일 수만큼 for문 돌아라
		for(MultipartFile img : list) {
			fileName= img.getOriginalFilename();
			file = new File(filePath, fileName);
			
			try {
				img.transferTo(file);
					
				} catch (IOException e) {
				
					e.printStackTrace();
				}
			imageboardDTO.setImage1(fileName);
			imageboardDTO.setImage2("");  //이렇게 하면 imge1에만 데이터가 들어간다.
			
			//DB
			imageboardService.imageboardWrite(imageboardDTO);
			//for문 안에 들어와 있어야 for문 돌면서 생성 
			
		}//for
	}
	
	 //여기는 list창만 뜨는것 DB로 연결 안한다
	//menu.jsp에서 넘어오는것.
	@GetMapping(value="imageboardList") 
	//처음엔 무조건 1페이지를 열것이다.그래서 pg값 받아와야한다.
	public String imageboardList(@RequestParam(required=false, defaultValue="1") String pg,Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("display","imageboard/imageboardList.jsp");
		return "/index";
		
	}
	
	@PostMapping(value="getimageboardList")
	@ResponseBody
	public ModelAndView getimageboardList(@RequestParam String pg) {
		//DB -1페이지당 3개씩
		List<ImageboardDTO>list = imageboardService.getimageboardList(pg);
		
		
		//페이징 처리
		ImageboardPaging imageboardPaging = imageboardService.imageboardPaging(pg);
		
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list",list);
		mav.addObject("imageboardPaging",imageboardPaging);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@GetMapping(value="imageboardView")
	public String imageboardView(@RequestParam String pg,@RequestParam String seq ,Model model) {
		model.addAttribute("pg",pg);
		model.addAttribute("seq",seq);
		model.addAttribute("display","imageboard/imageboardView.jsp");
		
		return "/index";
		
	}
	
	@PostMapping(value="getImageboardView")
	@ResponseBody
	public ImageboardDTO getImageboardView(@RequestParam String seq) {
		
		ImageboardDTO imageboardDTO = imageboardService.getImageboardView(seq);
		return imageboardDTO;
		
	}
	
	@GetMapping(value="imageboardDelete")
	public ModelAndView imageboardDelete(String[] check) {
		
		imageboardService.imageboardDelete(check);
		return new ModelAndView("redirect:/imageboard/imageboardList");
				//jsp거치지말고 바로 가라.
	}
}
