package guestbook.bean;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data

public class GuestbookDTO {
	private int seq;
	private String name;
	private String email;
	private String homepage;
	private String subject;
	private String content;


	@JsonFormat(pattern="yyyy.MM.dd")
	private Date logtime;   //이거는 자바코드에서 처리 (SimpleDateFormat, Calendar)

}
