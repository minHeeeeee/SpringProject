package board.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class BoardDTO {
	
	private int seq; //글번호
	private String id;  //아이디
	private String name;  //이름
	private String email; //이메일
	private String subject; //제목
	private String content;  //내용
	
	private int ref; //그룹번호
	private int lev;  //단계
	private int step; //글 순서
	private int pseq; //원글번호
	private int reply; //답변수
	private int hit;  //조회수
	
	
	//private String logtime; // 이거는 DB에서 처리
	
	@JsonFormat(shape=JsonFormat.Shape.STRING,pattern="yyyy.MM.dd")
	private Date logtime;   //이거는 자바코드에서 처리 (SimpleDateFormat, Calendar)
	
	

}
